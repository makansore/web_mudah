from rest_framework import viewsets
from .models import *

from .serializers import *

class UserProfileViewSet(viewsets.ModelViewSet):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer

class UserFriendViewSet(viewsets.ModelViewSet):
    queryset = UserFriend.objects.all()
    serializer_class = UserFriendSerializer

class WorkoutCategoryViewSet(viewsets.ModelViewSet):
    queryset = WorkoutCategory.objects.all()
    serializer_class = WorkoutCategorySerializer

class ExerciseViewSet(viewsets.ModelViewSet):
    queryset = Exercise.objects.all()
    serializer_class = ExerciseSerializer

class WorkoutPlanViewSet(viewsets.ModelViewSet):
    queryset = WorkoutPlan.objects.all()
    serializer_class = WorkoutPlanSerializer

class WorkoutPlanExerciseViewSet(viewsets.ModelViewSet):
    queryset = WorkoutPlanExercise.objects.all()
    serializer_class = WorkoutPlanExerciseSerializer

class UserWorkoutScheduleViewSet(viewsets.ModelViewSet):
    queryset = UserWorkoutSchedule.objects.all()
    serializer_class = UserWorkoutScheduleSerializer

class WorkoutSessionViewSet(viewsets.ModelViewSet):
    queryset = WorkoutSession.objects.all()
    serializer_class = WorkoutSessionSerializer

class WorkoutSessionExerciseViewSet(viewsets.ModelViewSet):
    queryset = WorkoutSessionExercise.objects.all()
    serializer_class = WorkoutSessionExerciseSerializer

class StepsTrackingViewSet(viewsets.ModelViewSet):
    queryset = StepsTracking.objects.all()
    serializer_class = StepsTrackingSerializer

class WeightLogViewSet(viewsets.ModelViewSet):
    queryset = WeightLog.objects.all()
    serializer_class = WeightLogSerializer

class AchievementViewSet(viewsets.ModelViewSet):
    queryset = Achievement.objects.all()
    serializer_class = AchievementSerializer

class UserAchievementProgressViewSet(viewsets.ModelViewSet):
    queryset = UserAchievementProgress.objects.all()
    serializer_class = UserAchievementProgressSerializer

class DailyQuestViewSet(viewsets.ModelViewSet):
    queryset = DailyQuest.objects.all()
    serializer_class = DailyQuestSerializer

class UserDailyQuestViewSet(viewsets.ModelViewSet):
    queryset = UserDailyQuest.objects.all()
    serializer_class = UserDailyQuestSerializer

class UserNotificationViewSet(viewsets.ModelViewSet):
    queryset = UserNotification.objects.all()
    serializer_class = UserNotificationSerializer
