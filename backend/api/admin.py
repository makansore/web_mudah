from django.contrib import admin
from .models import *

admin.site.register(UserProfile)
admin.site.register(UserFriend)
admin.site.register(WorkoutCategory)
admin.site.register(Exercise)
admin.site.register(WorkoutPlan)
admin.site.register(WorkoutPlanExercise)
admin.site.register(UserWorkoutSchedule)
admin.site.register(WorkoutSession)
admin.site.register(WorkoutSessionExercise)
admin.site.register(StepsTracking)
admin.site.register(WeightLog)
admin.site.register(Achievement)
admin.site.register(UserAchievementProgress)
admin.site.register(DailyQuest)
admin.site.register(UserDailyQuest)
admin.site.register(UserNotification)
