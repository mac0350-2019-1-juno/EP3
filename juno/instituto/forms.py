from django import forms
from .models import *

class Create_form_instituto(forms.ModelForm):
    class Meta:
        model = Instituto
        fields = ["nome"]
    field_order = ["nome"]
    nome = forms.CharField(label='Nome do instituto', max_length=128)

class Update_form_instituto(forms.ModelForm):
    class Meta:
        model = Instituto
        fields = ["id", "nome_novo"]
    field_order = ["id", "nome_novo"]
    id = forms.CharField(label='Id do instituto', max_length=128)
    nome_novo   = forms.CharField(label='Novo nome do instituto', max_length=128)

class Delete_form_instituto(forms.ModelForm):
    class Meta:
        model = Instituto
        fields = ["id"]
    field_order = ["id"]
    id = forms.CharField(label='Id do instituto', max_length=128)
