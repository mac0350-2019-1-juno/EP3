from django.db import models

# Create your models here.
class base(models.Model):
    id = models.IntegerField(default=0, primary_key=True)
    nome = models.CharField(max_length=128)
