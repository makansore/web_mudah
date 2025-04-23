from django.urls import path, include
from rest_framework.routers import DefaultRouter
from authentication.views import UserViewSet

router = DefaultRouter()
router.register(r'users', UserViewSet)  # Creates /auth/users/ endpoint

urlpatterns = [
    path('', include(router.urls)),
]