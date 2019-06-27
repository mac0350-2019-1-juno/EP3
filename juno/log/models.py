from django.db import models

# Create your models here.
class User(models.Model):
    id = models.IntegerField(default=0, primary_key=True)
    email = models.CharField(max_length=128)
    senha = models.CharField(max_length=128)
