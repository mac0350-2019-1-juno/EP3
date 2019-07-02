from django import forms
from .models import *
from django.db import connections

class Select_enfase(forms.Form):
    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id,nome FROM retrieve_enfase_all()")
        enfases = cursor.fetchall()

    for i in range(0,len(enfases)):
        enfases[i] = (enfases[i][0],enfases[i][1])

    nome = forms.MultipleChoiceField(
        required=False,
        widget=forms.CheckboxSelectMultiple,
        choices=enfases,
    )
