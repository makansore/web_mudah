from django.conf import settings
from django.conf.urls.static import static
from django.urls import path, include
from django.contrib import admin  

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),  # Include API URLs
    path('auth/', include('authentication.urls')),  # Include Authentication URLs
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
