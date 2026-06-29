from django.urls import path
from .views import TreinoDetailView, TreinoListView

urlpatterns = [
    path('treinos/', TreinoListView.as_view()),
    path('treinos/<int:pk>/', TreinoDetailView.as_view()),
]