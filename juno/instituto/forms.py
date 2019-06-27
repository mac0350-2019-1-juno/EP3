from django import forms
from .models import *

class Create_form(forms.ModelForm):
    class Meta:
        model = Instituto
        fields = ["nome"]
    nome = forms.CharField(label='Nome do instituto', max_length=128)

class Update_form(forms.ModelForm):
    class Meta:
        model = Instituto
        fields = ["nome_antigo", "nome_novo"]
    nome_antigo = forms.CharField(label='Nome a ser alterado do instituto', max_length=128)
    nome_novo   = forms.CharField(label='Novo nome do instituto', max_length=128)

class Delete_form(forms.ModelForm):
    class Meta:
        model = Instituto
        fields = ["nome"]
    nome = forms.CharField(label='Nome do instituto', max_length=128)
