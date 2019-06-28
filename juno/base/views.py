from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.db import connections
from base.forms import *
from .models import *
from juno.util import *

menu =  """base"""

def index(request):
    renderer = menu
    return render(request, "index.html", {'content':"", 'menu':menu})

def create(request):
    if not check_permission(request.user.username, "create_base"):
        return render(request, "index.html", {'content':"Usu&aacute;rio n&atilde;o autorizado!", 'menu':menu})
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Create_form(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            with connections['juno_base'].cursor() as cursor:
                cursor.execute("SELECT * FROM create_base(%s)", [form.cleaned_data['nome']])
                result = cursor.fetchone()

                if result == None:
                    content = "Ocorreu um erro ao tentar executar a a&ccedil;&atilde;o requisitada."
                else:
                    content = "A&ccedil;&atilde;o executada com suceso."
            # redirect to a new URL:
            return render(request, "index.html", {'content':content, 'menu':menu})

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Create_form()

    return render(request, "create.html", {'form':form, 'menu':menu})

def retrival(request):
    if not check_permission(request.user.username, "create_base"):
        return render(request, "index.html", {'content':"Usu&aacute;rio n&atilde;o autorizado!", 'menu':menu})
    with connections['juno_base'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_base_all()")
        dict = dictfetchall(cursor)
        output = "".join(["<tr><th>{}</th></tr>".format(i['nome']) for i in dict])
        content = "<table><tr><th>base</th></tr>" + output + "</table>"
    return render(request, "retrival.html", {'content':content, 'menu':menu})

def update(request):
    if not check_permission(request.user.username, "update_base_by_nome"):
        return render(request, "index.html", {'content':"Usu&aacute;rio n&atilde;o autorizado!", 'menu':menu})
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Update_form(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            with connections['juno_base'].cursor() as cursor:
                cursor.execute("SELECT * FROM update_base_by_nome(%s, %s)", [form.cleaned_data['nome_antigo'], form.cleaned_data['nome_novo']])
                result = cursor.fetchone()

                if result == None:
                    content = "Ocorreu um erro ao tentar executar a a&ccedil;&atilde;o requisitada."
                else:
                    content = "A&ccedil;&atilde;o executada com suceso."
            # redirect to a new URL:
            return render(request, "index.html", {'content':content, 'menu':menu})

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Update_form()

    return render(request, "update.html", {'form':form, 'menu':menu})

def delete(request):
    if not check_permission(request.user.username, "delete_base_by_nome"):
        return render(request, "index.html", {'content':"Usu&aacute;rio n&atilde;o autorizado!", 'menu':menu})
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Delete_form(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            with connections['juno_base'].cursor() as cursor:
                cursor.execute("SELECT * FROM delete_base_by_nome(%s)", [form.cleaned_data['nome']])
                result = cursor.fetchone()

                if result == None:
                    content = "Ocorreu um erro ao tentar executar a a&ccedil;&atilde;o requisitada."
                else:
                    content = "A&ccedil;&atilde;o executada com suceso."
            # redirect to a new URL:
            return render(request, "index.html", {'content':content, 'menu':menu})

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Delete_form()

    return render(request, "delete.html", {'form':form, 'menu':menu})
