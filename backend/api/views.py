from requests import request
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from .models import Treino
from .serializers import TreinoSerializer


class TreinoListView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        treinos = Treino.objects.all()
        serializer = TreinoSerializer(treinos, many=True)

        return Response(serializer.data)
    
    def post(self, request):
        serializer = TreinoSerializer(data=request.data)

        serializer.is_valid(raise_exception=True)

        serializer.save()

        return Response(serializer.data, status=201)
    
class TreinoDetailView(APIView):
    permission_classes = [IsAuthenticated]

    def get_object(self, pk):
        return Treino.objects.get(pk=pk)

    def put(self, request, pk):
        treino = self.get_object(pk)

        serializer = TreinoSerializer(
            treino,
            data=request.data,
        )

        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data)

    def delete(self, request, pk):
        treino = self.get_object(pk)
        treino.delete()

        return Response(status=204)