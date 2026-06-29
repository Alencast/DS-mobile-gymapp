from rest_framework import serializers
from .models import Treino


class TreinoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Treino
        fields = '__all__'