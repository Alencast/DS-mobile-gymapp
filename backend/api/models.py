from django.db import models


class Treino(models.Model):
    titulo = models.CharField(max_length=100)
    descricao = models.TextField()
    duracao = models.CharField(max_length=50)
    nivel = models.CharField(max_length=50)

    def __str__(self):
        return self.titulo