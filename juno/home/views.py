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
    # if not request.user.is_authenticated:
    #     return HttpResponseRedirect('/acesso')
    return render(request, "home.html", {'content': ""})
