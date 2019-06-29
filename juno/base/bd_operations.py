from base.forms import *
from juno.util import *

# Importa as funcoes de delete dos filhos para simular o CASCATE
from base_filho.bd_operations import delete_base_filho


# Funcoes
def delete_base_childrens(id):
    with connections['juno_base'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_base_filho_all_by_base_id(%s)", [id])
        for base_filho in cursor.fetchall():
            delete_base_filho(base_filho[0])

def check_base_fathers(parameters):
    check = check_id('juno_base', 'base_pai', parameters['pai_id'])
    if not check:
        return False
    return True

def create_base(form):
    # Primeiro checa as existencias nos pais
    if not check_base_fathers(form):
        return None

    # Depois executa a funcao de criar
    parameters = ("%s, " * len(form))[:-2]
    with connections['juno_base'].cursor() as cursor:
        cursor.execute("SELECT * FROM create_base({})".format(parameters), [i for i in form.values()])
        result = cursor.fetchone()
    return result

def update_base(form):
    # Primeiro checa as existencias nos pais
    if not check_base_fathers(form):
        return None

    # Depois executa a funcao de update
    parameters = ("%s, " * len(form))[:-2]
    with connections['juno_base'].cursor() as cursor:
        cursor.execute("SELECT * FROM update_base_by_id({})".format(parameters), [i for i in form.values()])
        result = cursor.fetchone()
    return result

def delete_base(id):
    # Verifica existencia do base com o id passado
    if check_id('juno_base', 'base', id) == False:
        return None

    # Em seguida deleta os filhos
    delete_base_childrens(id)

    # Depois executa a funcao de deletar o base
    with connections['juno_base'].cursor() as cursor:
        cursor.execute("SELECT * FROM delete_base_by_id(%s)", [id])
        result = cursor.fetchone()
    return result
