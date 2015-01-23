# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('workshops', '0042_auto_20150119_2109'),
    ]

    operations = [
        migrations.AlterField(
            model_name='person',
            name='active',
            field=models.BooleanField(default=True, help_text=b'Are we currently allowed to contact this person?'),
            preserve_default=True,
        ),
    ]
