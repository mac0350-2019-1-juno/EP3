from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.db import connections
from instituto.forms import *
from .models import *
from .bd_operations import *
from juno.util import *

name =  """Instituto"""
msg_nao_autorizado = "Usu&aacute;rio n&atilde;o autorizado!"
msg_erro = "Ocorreu um erro ao tentar executar a a&ccedil;&atilde;o requisitada."
msg_sucesso = "A&ccedil;&atilde;o executada com suceso."

def index(request):
    return render(request, "index.html", {'content':"", 'menu':name})

def create(request):
    if not check_permission(request.user.username, "create_instituto"):
        return render(request, "index.html", {'content':msg_nao_autorizado, 'menu':name})
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Create_form_instituto(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            # Nao esqueica de incluir os valores que nao foram dados pelo usuario
            result = create_instituto(form.cleaned_data)
            if result == None:
                content = msg_erro
            else:
                content = msg_sucesso
            # redirect to a new URL:
            return render(request, "index.html", {'content':content, 'menu':name})

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Create_form_instituto()

    return render(request, "create.html", {'form':form, 'menu':name})

def retrieval(request):
    service = "retrieve_instituto_all"
    if not check_permission(request.user.username, service):
        return render(request, "index.html", {'content':msg_nao_autorizado,'menu':name})
    content = retrive_all("juno_people", service)
    return render(request, "retrieval.html", {'content':content, 'menu':name})

def update(request):
    if not check_permission(request.user.username, "update_instituto_by_id"):
        return render(request, "index.html", {'content':msg_nao_autorizado, 'menu':name})
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Update_form_instituto(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            result = update_instituto(form.cleaned_data)
            if result == None:
                content = msg_erro
            else:
                content = msg_sucesso
            # redirect to a new URL:
            return render(request, "index.html", {'content':content, 'menu':name})

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Update_form_instituto()

    return render(request, "update.html", {'form':form, 'menu':name})

def delete(request):
    if not check_permission(request.user.username, "delete_instituto_by_id"):
        return render(request, "index.html", {'content':msg_nao_autorizado, 'menu':name})
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Delete_form_instituto(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            result = delete_instituto(form.cleaned_data['id'])
            if result == None:
                content = msg_erro
            else:
                content = msg_sucesso
            # redirect to a new URL:
            return render(request, "index.html", {'content':content, 'menu':name})

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Delete_form_instituto()

    return render(request, "delete.html", {'form':form, 'menu':name})
