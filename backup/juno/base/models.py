from django.db import models

# Create your models here.
class base(models.Model):
    class Meta:
        db_table = "base"
