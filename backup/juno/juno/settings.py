"""
Django settings for juno project.

Generated by 'django-admin startproject' using Django 2.2.2.

For more information on this file, see
https://docs.djangoproject.com/en/2.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/2.2/ref/settings/
"""

import os

# Nao altere a posicao da proxima linha!!!!!
senha_postgres = 'c'

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/2.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'bi1q1#u^m=ghd#zs)lw0w=u_zhx5bb-f6bex$49^^jj%%fmy)p'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['*']


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'instituto.apps.institutoConfig',
    'log.apps.logConfig',
    'home.apps.homeConfig',
    'departamento.apps.departamentoConfig',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'juno.urls'
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'juno.wsgi.application'


# Database
# https://docs.djangoproject.com/en/2.2/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'juno_people',
        'USER': 'postgres',
        'PASSWORD': senha_postgres,
        'HOST': '',
        'PORT': ''
    },
    'juno_people': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'juno_people',
        'USER': 'postgres',
        'PASSWORD': senha_postgres,
        'HOST': '',
        'PORT': ''
    },
    'juno_access': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'juno_access',
        'USER': 'postgres',
        'PASSWORD': senha_postgres,
        'HOST': '',
        'PORT': ''
    },
    'juno_access_people': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'juno_access_people',
        'USER': 'postgres',
        'PASSWORD': senha_postgres,
        'HOST': '',
        'PORT': ''
    },
    'juno_curriculum': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'juno_curriculum',
        'USER': 'postgres',
        'PASSWORD': senha_postgres,
        'HOST': '',
        'PORT': ''
    },
    'juno_people_curriculum': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'juno_people_curriculum',
        'USER': 'postgres',
        'PASSWORD': senha_postgres,
        'HOST': '',
        'PORT': ''
    }
}


# Password validation
# https://docs.djangoproject.com/en/2.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/2.2/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/2.2/howto/static-files/

STATIC_URL = '/static/'
