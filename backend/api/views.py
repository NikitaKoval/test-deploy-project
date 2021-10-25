from django.shortcuts import render
from rest_framework.viewsets import ModelViewSet

from . import serializers
from . import models


class PostViewSet(ModelViewSet):
    queryset = models.Post.objects.all().order_by('-timestamp')
    serializer_class = serializers.PostSerializer
