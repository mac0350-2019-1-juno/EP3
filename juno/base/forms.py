from django import forms
from .models import *

class Create_form(forms.ModelForm):
    class Meta:
        model = base
        fields = ["nome"]
    nome = forms.CharField(label='Nome do base', max_length=128)

class Update_form(forms.ModelForm):
    class Meta:
        model = base
        fields = ["nome_antigo", "nome_novo"]
    nome_antigo = forms.CharField(label='Nome a ser alterado do base', max_length=128)
    nome_novo   = forms.CharField(label='Novo nome do base', max_length=128)

class Delete_form(forms.ModelForm):
    class Meta:
        model = base
        fields = ["nome"]
    nome = forms.CharField(label='Nome do base', max_length=128)
