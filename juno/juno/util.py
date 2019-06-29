from django.db import connections
def dictfetchall(cursor):
    "Returns all rows from a cursor as a dict"
    desc = cursor.description
    return [
            dict(zip([col[0] for col in desc], row))
            for row in cursor.fetchall()
    ]

def check_permission(user, servcice):
    if user == "":
        return False
    with connections['juno_access'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_servico_by_nome(%s)", [servcice])
        servico_id = cursor.fetchone()[0]
    with connections['juno_access'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_usuario_perfil_all_by_usuario_id(%s)", [user])
        for perfil in cursor.fetchall():
            with connections['juno_access'].cursor() as cursor2:
                cursor2.execute("SELECT * FROM retrieve_perfil_servico_by_perfil_id_servico_id(%s, %s)", [perfil[2], servico_id])
                result = cursor2.fetchone()
                if result is not None:
                    return True
    return False

def make_table(body_content):
    head = "".join("<tr>{}</tr>".format(
             "".join("<th>{}</th>".format(i) for i in body_content[0])))

    body = "".join("<tr>{}</tr>".format(
             "".join("<th>{}</th>".format(j) for j in i.values()))
           for i in body_content)

    return "<table>{}{}</table".format(head, body)

def retrive_all(database, servcice):
    with connections[database].cursor() as cursor:
        cursor.execute("SELECT * FROM {}()".format(servcice))
        dict = dictfetchall(cursor)
        content = make_table(dict)
    return content

def check_id(database, relation, id):
    with connections[database].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_{}_by_id(%s)".format(relation), [id])
        check_existence = cursor.fetchone()
    if check_existence == None:
        return False
    else:
        return True
