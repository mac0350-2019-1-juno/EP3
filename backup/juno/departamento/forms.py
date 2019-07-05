from django import forms
from .models import *

class Create_form_departamento(forms.ModelForm):
    class Meta:
        model = departamento
        fields = ["sigla", "instituto_id"]
    field_order = ["sigla", "instituto_id"]
    sigla = forms.CharField(label='Sigla do departamento', max_length=128)
    instituto_id = forms.IntegerField(label='Id do instituto')

class Update_form_departamento(forms.ModelForm):
    class Meta:
        model = departamento
        fields = ["id", "sigla", "instituto_id"]
    field_order = ["id", "sigla", "instituto_id"]
    id = forms.IntegerField(label='Id do departamento')
    sigla = forms.CharField(label='Nova sigla do departamento', max_length=128)
    instituto_id = forms.IntegerField(label='Novo id do instituto')

class Delete_form_departamento(forms.ModelForm):
    class Meta:
        model = departamento
        fields = ["id"]
    field_order = ["id"]
    id = forms.IntegerField(label='Id do departamento')
