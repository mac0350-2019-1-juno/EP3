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


def funcionalidade(request):
    # logado?
    if not request.user.is_authenticated:
        return HttpResponseRedirect('/acesso')
    link_list = ""
    if p_num_aluno_completa_enfase(request.user.username):
        link_list += "<a href='contador_aluno_conclui_enfase'> Numero de alunos que completaram ênfase </a> "

    return render(request, "funcionalidade/list.html", {'content':link_list})

def contador_aluno_conclui_enfase(request):
    if not p_num_aluno_completa_enfase(request.user.username):
        return render(request, "funcionalidade/nao_autorizado.html")

    name = ""
    if request.method == 'POST':
        form = Select_enfase(request.POST)
        if form.is_valid():
            print(form.cleaned_data)
    else:
        form = Select_enfase()
    return render(request, "funcionalidade/contador_aluno_conclui_enfase.html", {'form':form})
