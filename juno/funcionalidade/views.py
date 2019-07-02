from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth import authenticate as authenticate_dj
from django.contrib.auth.models import User as User_dj
from django.contrib.auth import logout as logout_dj
from django.contrib.auth import login as login_dj
from django.shortcuts import render
from django.db import connections
from log.forms import *
from .models import *
from juno.util import *
from funcionalidade.util import *
from funcionalidade.forms import *

# PAGINA PADRAO
def funcionalidade(request):
    # logado?
    if not request.user.is_authenticated:
        return HttpResponseRedirect('/acesso')
    link_list = ""
    # Contador de alunos que completaram enfase
    if p_num_aluno_completa_enfase(request.user.username):
        link_list += "<a href='contador_aluno_conclui_enfase'> Numero de alunos que completaram ênfase </a><br>"
    # Alunos que cursam um curso
    if p_alunos_curso(request.user.username):
        link_list += "<a href='alunos_curso'> Alunos em um curso </a><br>"
    # Alunos que cursam um oferecimento
    if p_alunos_oferecimento(request.user.username):
        link_list += "<a href='alunos_oferecimento'> Alunos em um oferecimento </a><br>"

    return render(request, "funcionalidade/list.html", {'content':link_list})

# CONTAR ALUNOS QUE COMPLETARAM UMA TRILHA
def contador_aluno_conclui_enfase(request):
    # Checa permissoes
    if not p_num_aluno_completa_enfase(request.user.username):
        return render(request, "funcionalidade/nao_autorizado.html")

    # Get selected by user
    content = "<p>"
    if request.method == 'POST':
        form = Select_enfase(request.POST)
        if form.is_valid():
            # If selected is valid
            id = form.cleaned_data["choice"]
            with connections['juno_curriculum'].cursor() as cursor:
                cursor.execute("SELECT nome FROM retrieve_enfase_by_id(%s)", (id))
                content += cursor.fetchall()[0][0] + ": "
            # Do the counting
            content += num_aluno_completa_enfase(id)
    else:
        form = Select_enfase()

    content += "</p>"
    return render(request, "funcionalidade/contador_aluno_conclui_enfase.html", {'form':form, 'content':content})

# ALUNOS QUE FAZEM UM CURSO
def alunos_curso(request):
    # Checa permissoes
    if not p_alunos_curso(request.user.username):
        return render(request, "funcionalidade/nao_autorizado.html")

    content = "<p>"
    if request.method == 'POST':
        form = Select_curso(request.POST)
        if form.is_valid():
            # If selected is valid
            id = form.cleaned_data["choice"]
            with connections['juno_curriculum'].cursor() as cursor:
                cursor.execute("SELECT nome FROM retrieve_curso_by_id(%s)", (id,))
                # Print the name
                content += cursor.fetchone()[0] + ":<br>"

            list_alunos = list_alunos_curso(id)
            content += "<table><tr><th>Nome</th><th>NUSP</th><th>CPF</th></tr>"
            for a in list_alunos:
                content +="<tr><td>"+str(a[3])+"</td><td>"+str(a[1])+"</td><td>"+str(a[2])+"</td></tr>"
            content += "</table>"

    else:
        form = Select_curso()

    content += "</p>"
    return render(request, "funcionalidade/alunos_curso.html", {'form':form, 'content':content})

def alunos_oferecimento(request):
    # Checa permissoes
    if not p_alunos_oferecimento(request.user.username):
        return render(request, "funcionalidade/nao_autorizado.html")

    content = "<p>"
    if request.method == 'POST':
        form = Select_oferecimento(request.POST)
        if form.is_valid():
            # If selected is valid
            id = form.cleaned_data["choice"]

            list_alunos = list_alunos_oferecimento(id)
            content += "<table><tr><th>Nome</th><th>NUSP</th><th>CPF</th></tr>"
            for a in list_alunos:
                content +="<tr><td>"+str(a[3])+"</td><td>"+str(a[1])+"</td><td>"+str(a[2])+"</td></tr>"
            content += "</table>"

    else:
        form = Select_oferecimento()

    content += "</p>"
    return render(request, "funcionalidade/alunos_oferecimento.html", {'form':form, 'content':content})
