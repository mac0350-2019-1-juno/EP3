from departamento.forms import *
from juno.util import *

# Importa as funcoes de delete dos filhos para simular o CASCATE
#from Filho.bd_operations import filho_departamento


# Funcoes
def delete_departamento_childrens(id):
    # deletar os filhos de departamento
    print("Nao feito")

def check_departamento_fathers(parameters):
    check = check_id('juno_people', 'instituto', parameters['instituto_id'])
    if not check:
        return False
    return True

def create_departamento(form):
    # Primeiro checa as existencias nos pais
    if not check_departamento_fathers(form):
        return None

    # Depois executa a funcao de criar
    parameters = ("%s, " * len(form))[:-2]
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT * FROM create_departamento({})".format(parameters), [i for i in form.values()])
        result = cursor.fetchone()
    return result

def update_departamento(form):
    # Primeiro checa as existencias nos pais
    if not check_departamento_fathers(form):
        return None
    # Depois executa a funcao de update
    parameters = ("%s, " * len(form))[:-2]
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT * FROM update_departamento_by_id({})".format(parameters), [i for i in form.values()])
        result = cursor.fetchone()
    return result

def delete_departamento(id):
    # Verifica existencia do departamento com o id passado
    if check_id('juno_people', 'departamento', id) == False:
        return None

    # Em seguida deleta os filhos
    delete_departamento_childrens(id)

    # Depois executa a funcao de deletar o departamento
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT * FROM delete_departamento_by_id(%s)", [id])
        result = cursor.fetchone()
    return result
