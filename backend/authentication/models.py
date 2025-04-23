from django.contrib.auth.models import AbstractUser, Group, Permission, User
from django.db import models
import uuid

class User(AbstractUser):
    """
    Custom User model extending AbstractUser for authentication
    """
    current_level = models.PositiveIntegerField(default=1)
    current_xp = models.PositiveIntegerField(default=0)
    auth_provider = models.CharField(max_length=50, blank=True, null=True)
    auth_provider_id = models.CharField(max_length=255, blank=True, null=True)
    join_date = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(null=True, blank=True)
    verification_status = models.CharField(max_length=20, default='unverified')
    reset_token = models.CharField(max_length=255, blank=True, null=True)
    friend_id = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)

    # Fix conflicts by specifying unique related_name values
    groups = models.ManyToManyField(Group, related_name="custom_user_set", blank=True)
    user_permissions = models.ManyToManyField(Permission, related_name="custom_user_permissions_set", blank=True)

    def __str__(self):
        return self.username