from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('mysite/', views.mysite, name='mysite')
]
