from django.urls import path

from . import views

urlpatterns = [
    path('', views.funcionalidade, name='funcionalidade'),
    path('contador_aluno_conclui_enfase', views.contador_aluno_conclui_enfase, name='contador_aluno_conclui_enfase'),
    path('alunos_curso', views.alunos_curso, name='alunos_curso'),
    path('alunos_oferecimento', views.alunos_oferecimento, name='alunos_oferecimento'),
    path('notas_alunos', views.notas_alunos, name='notas_alunos'),
]