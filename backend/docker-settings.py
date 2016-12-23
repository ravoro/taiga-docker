import os
from .common import *

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "taiga",
        "HOST": "postgres",
        "USER": "taiga",
        "PASSWORD": "thisisthetaigapassword",
    }
}
