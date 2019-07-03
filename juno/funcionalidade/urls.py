from django.urls import path

from . import views

urlpatterns = [
    path('', views.funcionalidade, name='funcionalidade'),
    path('contador_aluno_conclui_enfase', views.contador_aluno_conclui_enfase, name='contador_aluno_conclui_enfase'),
    path('alunos_curso', views.alunos_curso, name='alunos_curso'),
    path('alunos_oferecimento', views.alunos_oferecimento, name='alunos_oferecimento'),
    path('notas_alunos', views.notas_alunos, name='notas_alunos'),
    path('prerrequisito', views.prerrequisito, name='prerrequisito'),
    path('nota_de_aluno', views.nota_de_aluno, name='nota_de_aluno'),
    path('media_oferecimento', views.media_oferecimento, name='media_oferecimento'),
    path('formou', views.formou, name='formou'),
]
