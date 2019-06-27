from django import forms
from .models import *

class Log_form(forms.ModelForm):
    class Meta:
        model = User
        fields = ["email", "senha"]
    email = forms.CharField(label='Email', max_length=128)
    senha = forms.CharField(label='Senha', max_length=128)
