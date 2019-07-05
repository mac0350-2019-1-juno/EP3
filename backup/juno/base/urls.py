from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('create', views.create, name='create'),
    path('retrieval', views.retrieval, name='retrieval'),
    path('update', views.update, name='update'),
    path('delete', views.delete, name='delete')
]
