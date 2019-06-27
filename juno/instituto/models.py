from django.db import models

# Create your models here.
class Instituto(models.Model):
    class Meta:
        db_table = 'instituto'
    id = models.IntegerField(default=0, primary_key=True)
    nome = models.CharField(max_length=128)

# Create your models here.
class InstitutoUpdater(models.Model):
    nome_novo = models.CharField(max_length=128)
    nome_antigo = models.CharField(max_length=128)
