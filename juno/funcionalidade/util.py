from django.db import connections
from juno.util import *

def p_num_aluno_completa_enfase(user):
    if check_permission(user, "retrieve_aluno_completou_enfase"):
        if check_permission(user, "retrieve_aluno_all"):
            if check_permission(user, "retrieve_enfase_all"):
                if check_permission(user, "retrieve_pessoa_by_id"):
                    return True
    return False

def num_aluno_completa_enfase():
    # Pega todas as pessoas
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_aluno_all()")
        alunos = cursor.fetchall()

    # Pega todas as enfases
    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_enfase_all()")
        enfases = cursor.fetchall()


    return
