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

def home(request):
    if not request.user.is_authenticated:
        return HttpResponseRedirect('/acesso')
    return render(request, "home.html", {'content': ""})


'''
def login(request):
    if request.user.is_authenticated:
        return render(request, "acesso.html", {'content': ""})
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = Log_form(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            with connections['juno_access'].cursor() as cursor:
                cursor.execute("SELECT * FROM retrieve_usuario_by_email_senha(%s, %s)", [form.cleaned_data['email'], form.cleaned_data['senha']])
                result = cursor.fetchone()

                if result == None:
                    content = "Ocorreu um erro ao tentar logar."
                else:
                    user = authenticate_dj(username=result[0], email=result[1], password=result[2])
                    if user is None:
                        user = User_dj.objects.create_user(username=result[0], email=result[1], password=result[2])
                        user.save()
                    user = authenticate_dj(username=result[0], email=result[1], password=result[2])
                    login_dj(request, user)
                    content = "Logado com sucesso."
            # redirect to a new URL:
            return render(request, "acesso.html", {'content':content})

    # if a GET (or any other method) we'll create a blank form
    else:
        form = Log_form()

    return render(request, "login.html", {'form':form})
'''
