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

# Professor ve nota dos alunos
def p_notas_alunos(user):
    if check_permission(user, "retrieve_pessoa_by_nusp"):
        if check_permission(user, "retrieve_professor_by_pessoa_id"):
            if check_permission(user, "retrieve_disciplina_by_sigla"):
                if check_permission(user, "retrieve_ministra_by_professor_id_disciplina_id_semestre_ano"):
                    if check_permission(user, "retrieve_oferecimento_by_ministra_id"):
                        if check_permission(user, "retrieve_matricula_all_by_oferecimento_id"):
                            if check_permission(user, "retrieve_aluno_by_id"):
                                if check_permission(user, "retrieve_pessoa_by_id"):
                                    return True
    return False

def list_notas_alunos(prof_nusp,sigla,semestre,ano):
    # Acha pessoa pelo nusp
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_pessoa_by_nusp(%s)", (prof_nusp,))
        pessoa_id = cursor.fetchone()

    # Acha professor por pessoa id
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_professor_by_pessoa_id(%s)", (pessoa_id,))
        prof_id = cursor.fetchone()

    # Acha id de disciplina por sigla
    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_disciplina_by_sigla(%s)", (sigla,))
        disc_id = cursor.fetchone()[0]

    # Acha ministra
    with connections['juno_people_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_ministra_by_professor_id_disciplina_id_semestre_ano(%s,%s,%s,%s)", (prof_id,disc_id,semestre,ano,))
        ministra_id = cursor.fetchone()

    # Acha oferecimento com ministra id
    with connections['juno_people_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_oferecimento_by_ministra_id(%s)", (ministra_id,))
        oferecimento_id = cursor.fetchone()

    # Acha as matriculas pelo oferecimento
    with connections['juno_people_curriculum'].cursor() as cursor:
        cursor.execute("SELECT aluno_id,nota,frequencia FROM retrieve_matricula_all_by_oferecimento_id(%s)", (oferecimento_id,))
        matriculas = cursor.fetchall()

    # Coleta informacoes
    list_alunos = []
    for m in matriculas:
        with connections['juno_people'].cursor() as cursor:
            cursor.execute("SELECT pessoa_id FROM retrieve_aluno_by_id(%s)", (m[0],))
            pessoa_id = cursor.fetchone()
        # Acha a pessoa pelo pessoa_id
        with connections['juno_people'].cursor() as cursor:
            cursor.execute("SELECT nome,nusp FROM retrieve_pessoa_by_id(%s)", (pessoa_id[0],))
            aluno = cursor.fetchone()
            list_alunos.append([aluno[0],aluno[1],m[1],m[2]])

    return list_alunos

# Prerrequisito
def p_prerrequisito(user):
    if check_permission(user, "retrieve_disciplina_all"):
        if check_permission(user, "retrieve_prerrequisito_all_by_disciplina_id"):
            if check_permission(user, "retrieve_pessoa_by_nusp"):
                if check_permission(user, "retrieve_aluno_all_by_pessoa_id"):
                    if check_permission(user, "retrieve_matricula_all_by_aluno_id"):
                        if check_permission(user, "retrieve_disciplina_by_id"):
                            return True
    return False

def list_prerrequisito(id, nusp):
    disc_list = ""
    # Materias necessarias
    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT requisito_id FROM retrieve_prerrequisito_all_by_disciplina_id(%s)", (id,))
        prerrequisitos = cursor.fetchone()

    print(prerrequisitos)
    # Se não tem prerrequisitos
    if prerrequisitos == None:
        return disc_list

    # Pessoa pelo nusp
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_pessoa_by_nusp(%s)", (nusp,))
        pessoa_id = cursor.fetchone()

    # Alunos pela pessoa id
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_aluno_all_by_pessoa_id(%s)", (pessoa_id[0],))
        aluno_id = cursor.fetchall()

    for a in aluno_id:
        # Matriculas do aluno
        with connections['juno_people_curriculum'].cursor() as cursor:
            cursor.execute("SELECT oferecimento_id,nota FROM retrieve_matricula_all_by_aluno_id(%s)", (pessoa_id,))
            matriculas = cursor.fetchall()

        for p in prerrequisitos:
            is_in = False
            for m in matriculas:
                if p == m[0] and m[1] >= 5:
                    is_in = True
                    break

            if not is_in:
                with connections['juno_curriculum'].cursor() as cursor:
                    cursor.execute("SELECT nome FROM retrieve_disciplina_by_id(%s)", (m[0],))
                    nome = cursor.fetchone()[0]
                    disc_list += nome

    return disc_list
