from instituto.forms import *
from juno.util import *

# Importa as funcoes de delete dos filhos para simular o CASCATE
from departamento.bd_operations import delete_departamento


# Funcoes
def delete_instituto_childrens(id):
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_departamento_all_by_instituto_id(%s)", [id])
        for departamento in cursor.fetchall():
            delete_departamento(departamento[0])

def check_instituto_fathers(parameters):
    # Instituto nao tem pai
    return True

def create_instituto(form):
    # Primeiro checa as existencias nos pais
    if not check_instituto_fathers(form):
        return None

    # Depois executa a funcao de criar
    parameters = ("%s, " * len(form))[:-2]
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT * FROM create_instituto({})".format(parameters), [i for i in form.values()])
        result = cursor.fetchone()
    return result

def update_instituto(form):
    # Primeiro checa as existencias nos pais
    if not check_instituto_fathers(form):
        return None

    # Depois executa a funcao de update
    parameters = ("%s, " * len(form))[:-2]
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT * FROM update_instituto_by_id({})".format(parameters), [i for i in form.values()])
        result = cursor.fetchone()
    return result

def delete_instituto(id):
    # Verifica existencia do instituto com o id passado
    if check_id('juno_people', 'instituto', id) == False:
        return None

    # Em seguida deleta os filhos
    delete_instituto_childrens(id)

    # Depois executa a funcao de deletar o instituto
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT * FROM delete_instituto_by_id(%s)", [id])
        result = cursor.fetchone()
    return result
