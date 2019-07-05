from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.

def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")

def index2(request, database=None, function=None):
    return HttpResponse(
        f"Hello, world. You're at the polls index. {database} {function} {request.POST} {request.GET.get('param', '')}")

