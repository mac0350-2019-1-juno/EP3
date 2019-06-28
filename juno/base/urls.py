from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('create', views.create, name='create'),
    path('retrival', views.retrival, name='retrival'),
    path('update', views.update, name='update'),
    path('delete', views.delete, name='delete')
]
