from django.urls import path

from . import views

urlpatterns = [
    path('', views.funcionalidade, name='funcionalidade'),
    path('contador_aluno_conclui_enfase', views.contador_aluno_conclui_enfase, name='contador_aluno_conclui_enfase'),
    path('alunos_curso', views.alunos_curso, name='alunos_curso'),
]
