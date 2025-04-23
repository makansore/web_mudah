from rest_framework import serializers
from .models import *

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = '__all__'

class UserFriendSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserFriend
        fields = '__all__'

class WorkoutCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkoutCategory
        fields = '__all__'

class ExerciseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Exercise
        fields = '__all__'

class WorkoutPlanSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkoutPlan
        fields = '__all__'

class WorkoutPlanExerciseSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkoutPlanExercise
        fields = '__all__'

class UserWorkoutScheduleSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserWorkoutSchedule
        fields = '__all__'

class WorkoutSessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkoutSession
        fields = '__all__'

class WorkoutSessionExerciseSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkoutSessionExercise
        fields = '__all__'

class StepsTrackingSerializer(serializers.ModelSerializer):
    class Meta:
        model = StepsTracking
        fields = '__all__'

class WeightLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = WeightLog
        fields = '__all__'

class AchievementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Achievement
        fields = '__all__'

class UserAchievementProgressSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserAchievementProgress
        fields = '__all__'

class DailyQuestSerializer(serializers.ModelSerializer):
    class Meta:
        model = DailyQuest
        fields = '__all__'

class UserDailyQuestSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserDailyQuest
        fields = '__all__'

class UserNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserNotification
        fields = '__all__'