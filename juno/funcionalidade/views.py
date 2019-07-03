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
    # Professor acessa nota dos alunos
    if p_notas_alunos(request.user.username):
        link_list += "<a href='notas_alunos'> Notas dos alunos </a><br>"
    # Prerrequisito
    if p_prerrequisito(request.user.username):
        link_list += "<a href='prerrequisito'> Prerrequisito </a><br>"
    # Aluno ve suas notas
    if p_prerrequisito(request.user.username):
        link_list += "<a href='nota_de_aluno'> Ver notas </a><br>"
    # Media de um oferecimento
    if p_media_oferecimento(request.user.username):
        link_list += "<a href='media_oferecimento'> Ver notas </a><br>"
    # Media de um oferecimento
    if p_num_aluno_completa_enfase(request.user.username):
        link_list += "<a href='formou'> Ver se um aluno se formou</a><br>"

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
                cursor.execute("SELECT nome FROM retrieve_enfase_by_id(%s)", (id,))
                content += cursor.fetchall()[0][0] + ": "
            # Do the counting
            content += str(num_aluno_completa_enfase(id))
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

# Professor ve notas dos alunos
def notas_alunos(request):
    if not p_notas_alunos(request.user.username):
        return render(request, "funcionalidade/nao_autorizado.html")

    content = "<p>"
    if request.method == 'POST':
        form = Choose_ministra(request.POST)
        if form.is_valid():
            # If selected is valid
            prof_nusp = form.cleaned_data["prof_nusp"]
            sigla = form.cleaned_data["sigla"]
            semestre = form.cleaned_data["semestre"]
            ano = form.cleaned_data["ano"]

            list_alunos =  list_notas_alunos(prof_nusp,sigla,semestre,ano)
            content += "<table><tr><th>Nome</th><th>NUSP</th><th>Nota</th><th>Frequencia</th></tr>"
            for a in list_alunos:
                content +="<tr><td>"+str(a[0])+"</td><td>"+str(a[1])+"</td><td>"+str(a[2])+"</td><td>"+str(a[3])+"</td></tr>"
            content += "</table>"

    else:
        form = Choose_ministra()

    content += "</p>"
    return render(request, "funcionalidade/notas_alunos.html", {'form':form, 'content':content})

# Prerrequisito
def prerrequisito(request):
    if not p_notas_alunos(request.user.username):
        return render(request, "funcionalidade/nao_autorizado.html")

    content = "<p>"
    if request.method == 'POST':
        form = Select_requisito(request.POST)
        if form.is_valid():
            # If selected is valid
            id = form.cleaned_data["choice"]
            nusp = form.cleaned_data["nusp"]

            disc_list = list_prerrequisito(id,nusp)
            content += disc_list
    else:
        form = Select_requisito()

    content += "</p>"
    return render(request, "funcionalidade/prerrequisito.html", {'form':form, 'content':content})

# Aluno ve nota
def nota_de_aluno(request):
    if not p_nota_de_aluno(request.user.username):
        return render(request, "funcionalidade/nao_autorizado.html")

    content = "<table>"
    if request.method == 'POST':
        form = Choose_nusp(request.POST)
        if form.is_valid():
            # If selected is valid
            nusp = form.cleaned_data["nusp"]
            notas = list_nota_de_aluno(nusp)

            content += "<table><tr><th>Disciplina</th><th>Nota</th><th>Frequencia</th><th>Estado</th></tr>"
            for n in notas:
                content += "<tr><td>"+n[0]+"</td><td>"+str(n[1])+"</td><td>"+str(n[2])+"</td><td>"+n[3]+"</td></tr>"

    else:
        form = Choose_nusp()

    content += "</table>"
    return render(request, "funcionalidade/nota_de_aluno.html", {'form':form, 'content':content})

# Calcular media de um oferecimento
def media_oferecimento(request):
    if not p_media_oferecimento(request.user.username):
        return render(request, "funcionalidade/nao_autorizado.html")

    content = "<p>"
    if request.method == 'POST':
        form = Select_oferecimento(request.POST)
        if form.is_valid():
            # If selected is valid
            id = form.cleaned_data["choice"]
            media = calcula_media_oferecimento(id)
            content += "Média: " + str(media)

    else:
        form = Select_oferecimento()

    content += "</p>"
    return render(request, "funcionalidade/media_oferecimento.html", {'form':form, 'content':content})

# Verifica se o aluno se formou em um curso
def formou(request):
    if not p_nota_de_aluno(request.user.username):
        return render(request, "funcionalidade/nao_autorizado.html")

    content = "<table>"
    if request.method == 'POST':
        form = Choose_nusp_curso(request.POST)
        if form.is_valid():
            # If selected is valid
            nusp = form.cleaned_data["nusp"]
            curso = form.cleaned_data["curso"]
            formou = aluno_formou_curso(nusp, curso)

            content += "O aluno "
            if not formou:
                content += "n&atilde;o "
            content += "se formou."
    else:
        form = Choose_nusp_curso()

    content += "</p>"
    return render(request, "funcionalidade/formou.html", {'form':form, 'content':content})
