from django.db import connections
from juno.util import *

# CONTAR ALUNOS QUE COMPLETARAM UMA TRILHA
def p_num_aluno_completa_enfase(user):
    if check_permission(user, "retrieve_enfase_by_id"):
        if check_permission(user, "retrieve_aluno_all"):
            if check_permission(user, "retrieve_modulo_all_by_enfase_id"):
                return True
    return False

def num_aluno_completa_enfase(enfase):
    # Pega todas as pessoas
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_aluno_all()")
        alunos = cursor.fetchall()
    # Pega modulos da enfase
    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_modulo_all_by_enfase_id(%s)", (enfase))
        modulos = cursor.fetchall()

    completou = True

    return "TODO"

# ALUNOS QUE FAZEM UM CURSO
def p_alunos_curso(user):
    if check_permission(user, "retrieve_curso_by_id"):
        if check_permission(user, "retrieve_aluno_curso_all_by_curso_id"):
            if check_permission(user, "retrieve_aluno_by_id"):
                if check_permission(user, "retrieve_pessoa_by_id"):
                    return True
    return False

def list_alunos_curso(curso):
    with connections['juno_people_curriculum'].cursor() as cursor:
        cursor.execute("SELECT aluno_id FROM retrieve_aluno_curso_all_by_curso_id(%s)", (curso,))
        alunos_id = cursor.fetchall()

    alunos = []
    for a in alunos_id:
        # Acha que pessoa_id aquele aluno é pelo id
        with connections['juno_people'].cursor() as cursor:
            cursor.execute("SELECT pessoa_id FROM retrieve_aluno_by_id(%s)", (a[0],))
            pessoa_id = cursor.fetchone()
        # Acha a pessoa pelo pessoa_id
        with connections['juno_people'].cursor() as cursor:
            cursor.execute("SELECT * FROM retrieve_pessoa_by_id(%s)", (pessoa_id[0],))
            alunos.append(cursor.fetchone())
    return alunos

# ALUNOS QUE FAZEM UM OFERECIMENTO
def p_alunos_oferecimento(user):
    if check_permission(user, "retrieve_oferecimento_all"):
        if check_permission(user, "retrieve_ministra_by_id"):
            if check_permission(user, "retrieve_professor_by_id"):
                if check_permission(user, "retrieve_pessoa_by_id"):
                    if check_permission(user, "retrieve_disciplina_by_id"):
                        if check_permission(user, "retrieve_matricula_all_by_oferecimento_id"):
                            if check_permission(user, "retrieve_aluno_by_id"):
                                if check_permission(user, "retrieve_pessoa_by_id"):
                                    return True
    return False

def list_alunos_oferecimento(oferecimento):
    with connections['juno_people_curriculum'].cursor() as cursor:
        cursor.execute("SELECT aluno_id FROM retrieve_matricula_all_by_oferecimento_id(%s)", (oferecimento,))
        alunos_id = cursor.fetchall()

    alunos = []
    for a in alunos_id:
        # Acha que pessoa_id aquele aluno é pelo id
        with connections['juno_people'].cursor() as cursor:
            cursor.execute("SELECT pessoa_id FROM retrieve_aluno_by_id(%s)", (a[0],))
            pessoa_id = cursor.fetchone()
        # Acha a pessoa pelo pessoa_id
        with connections['juno_people'].cursor() as cursor:
            cursor.execute("SELECT * FROM retrieve_pessoa_by_id(%s)", (pessoa_id[0],))
            alunos.append(cursor.fetchone())
    return alunos
