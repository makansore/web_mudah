from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import *

# Create a router and register our viewsets with it
router = DefaultRouter()
router.register(r'user_profiles', UserProfileViewSet)
router.register(r'user_friends', UserFriendViewSet)
router.register(r'workout_categories', WorkoutCategoryViewSet)
router.register(r'exercises', ExerciseViewSet)
router.register(r'workout_plans', WorkoutPlanViewSet)
router.register(r'workout_plan_exercises', WorkoutPlanExerciseViewSet)
router.register(r'user_workout_schedules', UserWorkoutScheduleViewSet)
router.register(r'workout_sessions', WorkoutSessionViewSet)
router.register(r'workout_session_exercises', WorkoutSessionExerciseViewSet)
router.register(r'steps_tracking', StepsTrackingViewSet)
router.register(r'weight_logs', WeightLogViewSet)
router.register(r'achievements', AchievementViewSet)
router.register(r'user_achievement_progress', UserAchievementProgressViewSet)
router.register(r'daily_quests', DailyQuestViewSet)
router.register(r'user_daily_quests', UserDailyQuestViewSet)
router.register(r'user_notifications', UserNotificationViewSet)

# The API URLs are now determined automatically by the router
urlpatterns = [
    path('', include(router.urls)),
]