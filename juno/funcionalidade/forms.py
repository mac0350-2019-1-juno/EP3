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

class Select_oferecimento(forms.Form):
    # Seleciona todos os oferecimentos
    with connections['juno_people_curriculum'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_oferecimento_all()")
        oferecimentos = cursor.fetchall()

    selector = []
    # Para cada oferecimento pega o ministra e descobre semestre, ano, disciplina e nome do professor
    for i in range(0,len(oferecimentos)):
        # Ministra
        with connections['juno_people_curriculum'].cursor() as cursor:
            cursor.execute("SELECT * FROM retrieve_ministra_by_id(%s)", (oferecimentos[i][1],))
            ministra = cursor.fetchall()

        # Nome professor
        # Professor por id
        with connections['juno_people'].cursor() as cursor:
            cursor.execute("SELECT pessoa_id FROM retrieve_professor_by_id(%s)",(ministra[0][1],))
            professor_id = cursor.fetchone()[0]
        # Nome do professor por pessoa id
        with connections['juno_people'].cursor() as cursor:
            cursor.execute("SELECT nome FROM retrieve_pessoa_by_id(%s)",(professor_id,))
            professor_nome = cursor.fetchone()[0]

        # Nome disciplina
        with connections['juno_curriculum'].cursor() as cursor:
            cursor.execute("SELECT nome FROM retrieve_disciplina_by_id(%s)",(ministra[0][2],))
            disciplina_nome = cursor.fetchone()[0]

        nome = disciplina_nome + " dado por " + professor_nome + " em " + str(ministra[0][3]) + "/" + str(ministra[0][4])

        selector.append((oferecimentos[i][0], nome))

    choice = forms.ChoiceField( choices = selector,
                                label="",
                                initial='',
                                widget=forms.Select(),
                                required=True)
