from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.db import connections
from instituto.forms import *
from .models import *

menu =  """ <p align=center> <a href="..">Voltar ao inicio</a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Instituto -
            <a href="create">Create</a>
            <a href="retrival">Retrival</a>
            <a href="update">Update</a>
            <a href="delete">Delete</a> </p>
        """
def dictfetchall(cursor):
    "Returns all rows from a cursor as a dict"
    desc = cursor.description
    return [
            dict(zip([col[0] for col in desc], row))
            for row in cursor.fetchall()
    ]

def index(request):
    renderer = menu
    return HttpResponse(renderer)

def create(request):
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Create_form(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            with connections['juno_people'].cursor() as cursor:
                cursor.execute("SELECT * FROM create_instituto(%s)", [form.cleaned_data['nome']])
                cursor.fetchone()
            # redirect to a new URL:
            return HttpResponseRedirect('/instituto/retrival')

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Create_form()

    # return render(request, "create.html")
    return render(request, "create.html", {'form':form, 'menu':menu})

def retrival(request):
    with connections['juno_people'].cursor() as cursor:
        cursor.execute("SELECT * FROM retrieve_instituto_all()")
        dict = dictfetchall(cursor)
        output = "".join(["<tr><th>{}</th></tr>".format(i['nome']) for i in dict])
        renderer = menu + "<table><tr><th>Instituto</th></tr>" + output + "</table>"
    return HttpResponse(renderer)

def update(request):
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Update_form(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            with connections['juno_people'].cursor() as cursor:
                cursor.execute("SELECT * FROM update_instituto_by_nome(%s, %s)", [form.cleaned_data['nome_antigo'], form.cleaned_data['nome_novo']])
                cursor.fetchone()
            # redirect to a new URL:
            return HttpResponseRedirect('/instituto/retrival')

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Update_form()

    # return render(request, "create.html")
    return render(request, "update.html", {'form':form, 'menu':menu})

def delete(request):
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Delete_form(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            with connections['juno_people'].cursor() as cursor:
                cursor.execute("SELECT * FROM delete_instituto_by_nome(%s)", [form.cleaned_data['nome']])
                cursor.fetchone()
            # redirect to a new URL:
            return HttpResponseRedirect('/instituto/retrival')

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Delete_form()

    # return render(request, "create.html")
    return render(request, "delete.html", {'form':form, 'menu':menu})
