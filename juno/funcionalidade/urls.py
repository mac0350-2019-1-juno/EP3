from django.urls import path

from . import views

urlpatterns = [
    path('', views.funcionalidade, name='funcionalidade'),
    path('contador_aluno_conclui_enfase', views.contador_aluno_conclui_enfase, name='contador_aluno_conclui_enfase'),
]
