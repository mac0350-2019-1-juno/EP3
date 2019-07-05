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
        cursor.execute("SELECT id FROM retrieve_modulo_all_by_enfase_id(%s)", (enfase,))
        modulos = cursor.fetchall()

    # Contador
    count = 0

    # Para cada aluno
    for a in alunos:
        with connections['juno_people_curriculum'].cursor() as cursor:
            cursor.execute("SELECT oferecimento_id FROM retrieve_matricula_all_by_aluno_id(%s) WHERE estado='C'", (a[0],))
            oferecimentos = cursor.fetchall()
        # Para a enfase, roda todos os módulos
        completas = -1
        precisa = 0
        for m in modulos:
            completas = 0
            precisa = 0
            with connections['juno_curriculum'].cursor() as cursor:
                cursor.execute("SELECT id FROM retrieve_disciplina_modulo_by_id(%s)", (m[0],))
                disciplinas = cursor.fetchall()
                # Quantas disciplinas completas precisam
                precisa += len(disciplinas)
            # Roda as disciplinas daquele módulo
            for d in disciplinas:
                # Roda os oferecimento do aluno
                for o in oferecimentos:
                    # Step para achar o disciplina_id
                    with connections['juno_people_curriculum'].cursor() as cursor:
                        cursor.execute("SELECT ministra_id FROM retrieve_oferecimento_by_id(%s)", (o[0],))
                        ministra_id = cursor.fetchone()

                    # disciplina id
                    with connections['juno_people_curriculum'].cursor() as cursor:
                        cursor.execute("SELECT disciplina_id FROM retrieve_ministra_by_id(%s)", (ministra_id,))
                        disciplina_id = cursor.fetchone()

                    if disciplina_id[0] == d[0]:
                        completas += 1
                    print(completas,"/",precisa)

        if completas == precisa:
            count += 1

    return count

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
            cursor.execute("SELECT oferecimento_id,estado FROM retrieve_matricula_all_by_aluno_id(%s)", (pessoa_id,))
            matriculas = cursor.fetchall()

        for p in prerrequisitos:
            is_in = False
            for m in matriculas:
                if p == m[0] and m[1] == 'C':
                    is_in = True
                    break

            if not is_in:
                with connections['juno_curriculum'].cursor() as cursor:
                    cursor.execute("SELECT nome FROM retrieve_disciplina_by_id(%s)", (m[0],))
                    nome = cursor.fetchone()[0]
                    disc_list += nome

    return disc_list

# Aluno vê nota
def p_nota_de_aluno(user):
    if check_permission(user, "retrieve_pessoa_by_nusp"):
        if check_permission(user, "retrieve_aluno_by_pessoa_id"):
            if check_permission(user, "retrieve_matricula_all_by_aluno_id"):
                if check_permission(user, "retrieve_oferecimento_by_id"):
                    if check_permission(user, "retrieve_ministra_by_id"):
                        if check_permission(user, "retrieve_disciplina_by_id"):
                            return True
    return False


def list_nota_de_aluno(nusp):
    # Acha pessoa pelo nusp
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_pessoa_by_nusp(%s)", (nusp,))
        pessoa_id = cursor.fetchone()

    # Acha aluno pela pessoa id
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_aluno_by_pessoa_id(%s)", (pessoa_id,))
        aluno_id = cursor.fetchone()

    # Acha todas as matriculas do aluno
    with connections['juno_people_curriculum'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_matricula_all_by_aluno_id(%s)", (aluno_id,))
        matriculas = cursor.fetchall()

    # Lista com notas
    notas = []

    for m in matriculas:
        # Conseguir ministra pelo oferecimento
        with connections['juno_people_curriculum'].cursor() as cursor:
            cursor.execute("SELECT ministra_id FROM retrieve_oferecimento_by_id(%s)", (m[2],))
            ministra_id = cursor.fetchone()

        # Conseguir id disciplina por ministra
        with connections['juno_people_curriculum'].cursor() as cursor:
            cursor.execute("SELECT disciplina_id FROM retrieve_ministra_by_id(%s)", (ministra_id,))
            disciplina_id = cursor.fetchone()

        # Conseguir nome com disciplina id
        with connections['juno_curriculum'].cursor() as cursor:
            cursor.execute("SELECT nome FROM retrieve_disciplina_by_id(%s)", (disciplina_id,))
            nome = cursor.fetchone()[0]

        nota = m[4]
        estado = m[3]
        frequencia = m[5]

        notas.append([nome, nota, frequencia, estado])


    return notas

# Calcula media de oferecimento
def p_media_oferecimento(user):
    if check_permission(user, "retrieve_matricula_all_by_oferecimento_id"):
        if check_permission(user, "retrieve_oferecimento_all"):
            if check_permission(user, "retrieve_ministra_by_id"):
                if check_permission(user, "retrieve_professor_by_id"):
                    if check_permission(user, "retrieve_pessoa_by_id"):
                        if check_permission(user, "retrieve_disciplina_by_id"):
                            return True
    return False

def calcula_media_oferecimento(id):
    # Pega todas as notas das matriculas
    with connections['juno_people_curriculum'].cursor() as cursor:
        cursor.execute("SELECT nota FROM retrieve_matricula_all_by_oferecimento_id(%s)", (id,))
        matriculas = cursor.fetchall()

    count = 0
    result = 0
    for m in matriculas:
        result += m[0]
        count += 1

    if count == 0:
        return 0

    result /= count
    return result

def aluno_completou_enfase(aluno_id, enfase):
    with connections['juno_people_curriculum'].cursor() as cursor:
        cursor.execute("SELECT oferecimento_id FROM retrieve_matricula_all_by_aluno_id(%s) WHERE estado='C'", (aluno_id,))
        oferecimentos = cursor.fetchall()
    # Pega modulos da enfase
    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_modulo_all_by_enfase_id(%s)", (enfase,))
        modulos = cursor.fetchall()
    # Para a enfase, roda todos os módulos
    completas = -1
    precisa = 0
    for m in modulos:
        completas = 0
        precisa = 0
        with connections['juno_curriculum'].cursor() as cursor:
            cursor.execute("SELECT id FROM retrieve_disciplina_modulo_by_id(%s)", (m[0],))
            disciplinas = cursor.fetchall()
            # Quantas disciplinas completas precisam
            precisa += len(disciplinas)
        # Roda as disciplinas daquele módulo
        for d in disciplinas:
            # Roda os oferecimento do aluno
            for o in oferecimentos:
                # Step para achar o disciplina_id
                with connections['juno_people_curriculum'].cursor() as cursor:
                    cursor.execute("SELECT ministra_id FROM retrieve_oferecimento_by_id(%s)", (o[0],))
                    ministra_id = cursor.fetchone()

                # disciplina id
                with connections['juno_people_curriculum'].cursor() as cursor:
                    cursor.execute("SELECT disciplina_id FROM retrieve_ministra_by_id(%s)", (ministra_id,))
                    disciplina_id = cursor.fetchone()

                if disciplina_id[0] == d[0]:
                    completas += 1
                print(completas,"/",precisa)

    if completas == precisa:
        return True
    return False

def aluno_formou_curso(nusp, curso):
    # Procura pelo id do curso
    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_curso_by_codigo(%s)", (curso,))
        curso_id = cursor.fetchone()
    if curso_id is None:
        return False
    curso_id = curso_id[0]

    # Pega todas as pessoas
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_pessoa_by_nusp(%s)", (nusp,))
        pessoa_id = cursor.fetchone()
    if pessoa_id is None:
        return False
    pessoa_id = pessoa_id[0]

    # Pega o id de aluno
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_aluno_all_by_pessoa_id(%s)", (pessoa_id,))
        aluno_id = cursor.fetchone()
    if aluno_id is None:
        return False
    aluno_id = aluno_id[0]



    with connections['juno_curriculum'].cursor() as cursor:
        cursor.execute("SELECT id FROM retrieve_enfase_all_by_curso_id(%s)", (curso_id,))
        enfases = cursor.fetchall()
        for enfase in enfases:
            if not aluno_completou_enfase(aluno_id, enfase):
                return False
    return True
