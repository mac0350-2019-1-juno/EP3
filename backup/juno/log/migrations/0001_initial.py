# Generated by Django 2.2.2 on 2019-07-03 04:10

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.IntegerField(default=0, primary_key=True, serialize=False)),
                ('email', models.CharField(max_length=128)),
                ('senha', models.CharField(max_length=128)),
            ],
        ),
    ]