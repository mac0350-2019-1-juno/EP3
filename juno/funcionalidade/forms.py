from django import forms
from .models import *
from django.db import connections

class Select_enfase(forms.Form):
    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id,nome FROM retrieve_enfase_all()")
        enfases = cursor.fetchall()

    for i in range(0,len(enfases)):
        enfases[i] = (enfases[i][0],enfases[i][1])

    choice = forms.ChoiceField( choices = enfases,
                                label="",
                                initial='',
                                widget=forms.Select(),
                                required=True)

class Select_curso(forms.Form):
    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id,nome FROM retrieve_curso_all()")
        cursos = cursor.fetchall()

    for i in range(0,len(cursos)):
        cursos[i] = (cursos[i][0], cursos[i][1])

    choice = forms.ChoiceField( choices = cursos,
                                label="",
                                initial='',
                                widget=forms.Select(),
                                required=True)
