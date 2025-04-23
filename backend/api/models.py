from django.db import models
from authentication.models import User
from django.core.validators import MinValueValidator

class UserProfile(models.Model):
    """
    Additional profile information for users
    """
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    current_weight = models.FloatField(null=True, blank=True, validators=[MinValueValidator(0)])
    goal_weight = models.FloatField(null=True, blank=True, validators=[MinValueValidator(0)])
    daily_calorie_goal = models.PositiveIntegerField(null=True, blank=True)
    profile_picture = models.ImageField(upload_to='profile_pics/', null=True, blank=True)
    bio = models.TextField(blank=True)

    GENDER_CHOICES = [
        ('male', 'Male'),
        ('female', 'Female'),
    ]
    
    gender = models.CharField(max_length=10, choices=GENDER_CHOICES, default='Male')
    profile_picture = models.ImageField(upload_to="profile_icon/", null=True, blank=True)

    def get_profile_picture_url(self):
        if self.profile_picture:
            return self.profile_picture.url
        return f"/media/profile_icon/default/{self.gender}_default.png"  # Use default profile icons
    
    def __str__(self):
        return f"{self.user.username}'s Profile"
    
class UserFriend(models.Model):
    """
    Tracks user's friend relationships
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='added_friends')
    friend = models.ForeignKey(User, on_delete=models.CASCADE, related_name='added_by')
    added_at = models.DateTimeField(auto_now_add=True)
    is_visible = models.BooleanField(default=True)

    class Meta:
        unique_together = ('user', 'friend')

    def __str__(self):
        return f"{self.user.username} - {self.friend.username}"
    
class WorkoutCategory(models.Model):
    """
    Categories for workout types
    """
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True)
    icon = models.CharField(max_length=50, blank=True)

    def __str__(self):
        return self.name

class Exercise(models.Model):
    """
    Individual exercises within workout categories
    """
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    category = models.ForeignKey(WorkoutCategory, on_delete=models.SET_NULL, null=True, related_name='exercises')
    base_xp_reward = models.PositiveIntegerField(default=10)
    image_url = models.URLField(blank=True, null=True)
    video_url = models.URLField(blank=True, null=True)

    def __str__(self):
        return self.name

class WorkoutPlan(models.Model):
    """
    Predefined or user-created workout plans
    """
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    creator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='created_workout_plans')
    is_public = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class WorkoutPlanExercise(models.Model):
    """
    Exercises within a workout plan
    """
    workout_plan = models.ForeignKey(WorkoutPlan, on_delete=models.CASCADE, related_name='plan_exercises')
    exercise = models.ForeignKey(Exercise, on_delete=models.CASCADE)
    order_position = models.PositiveIntegerField()
    sets = models.PositiveIntegerField()
    reps = models.PositiveIntegerField()
    duration_seconds = models.PositiveIntegerField(null=True, blank=True)
    weight = models.FloatField(null=True, blank=True)

    class Meta:
        ordering = ['order_position']

class UserWorkoutSchedule(models.Model):
    """
    Scheduled workouts for users
    """
    STATUS_CHOICES = [
        ('scheduled', 'Scheduled'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled')
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='workout_schedules')
    workout_plan = models.ForeignKey(WorkoutPlan, on_delete=models.CASCADE)
    scheduled_time = models.DateTimeField()
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='scheduled')
    notification_preference = models.CharField(max_length=50, blank=True)

class WorkoutSession(models.Model):
    """
    Actual workout session completed by a user
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='workout_sessions')
    workout_plan = models.ForeignKey(WorkoutPlan, on_delete=models.SET_NULL, null=True)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    total_xp_earned = models.PositiveIntegerField(default=0)
    completion_status = models.CharField(max_length=50)
    notes = models.TextField(blank=True)

class WorkoutSessionExercise(models.Model):
    """
    Specific exercises performed in a workout session
    """
    workout_session = models.ForeignKey(WorkoutSession, on_delete=models.CASCADE, related_name='session_exercises')
    exercise = models.ForeignKey(Exercise, on_delete=models.CASCADE)
    sets_completed = models.PositiveIntegerField()
    reps_completed = models.PositiveIntegerField()
    weight_used = models.FloatField(null=True, blank=True)
    duration_seconds = models.PositiveIntegerField(null=True, blank=True)
    xp_earned = models.PositiveIntegerField(default=0)

class StepsTracking(models.Model):
    """
    Daily steps tracking for users
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='steps_tracking')
    tracking_day = models.DateField()
    step_count = models.PositiveIntegerField()
    distance_km = models.FloatField()
    calories_burned = models.PositiveIntegerField()
    data_source = models.CharField(max_length=100)

    class Meta:
        unique_together = ('user', 'tracking_day')

class WeightLog(models.Model):
    """
    User's weight tracking
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='weight_logs')
    log_date = models.DateField()
    weight = models.FloatField()

    class Meta:
        unique_together = ('user', 'log_date')

class Achievement(models.Model):
    """
    Achievements with tiered progression
    """
    TIER_CHOICES = [
        ('bronze', 'Bronze'),
        ('silver', 'Silver'),
        ('gold', 'Gold')
    ]

    name = models.CharField(max_length=200)
    description = models.TextField()
    icon = models.CharField(max_length=50)
    requirement_type = models.CharField(max_length=100)
    requirement_value = models.PositiveIntegerField()
    tier = models.CharField(max_length=20, choices=TIER_CHOICES)
    xp_reward = models.PositiveIntegerField()
    previous_tier_achievement = models.ForeignKey('self', on_delete=models.SET_NULL, null=True, blank=True)

    def __str__(self):
        return f"{self.name} - {self.tier}"

class UserAchievementProgress(models.Model):
    """
    Tracks user's progress on achievements
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='achievement_progress')
    achievement = models.ForeignKey(Achievement, on_delete=models.CASCADE)
    current_progress = models.PositiveIntegerField(default=0)
    is_completed = models.BooleanField(default=False)
    completed_date = models.DateTimeField(null=True, blank=True)
    is_claimed = models.BooleanField(default=False)

    class Meta:
        unique_together = ('user', 'achievement')

class DailyQuest(models.Model):
    """
    Daily quests for users to complete
    """
    QUEST_TYPES = [
        ('steps', 'Steps'),
        ('exercise', 'Exercise'),
        ('workout', 'Workout')
    ]

    name = models.CharField(max_length=200)
    description = models.TextField()
    quest_type = models.CharField(max_length=50, choices=QUEST_TYPES)
    target_value = models.PositiveIntegerField()
    xp_reward = models.PositiveIntegerField()
    available_from = models.DateField(null=True, blank=True)
    available_until = models.DateField(null=True, blank=True)
    recurrence_pattern = models.CharField(max_length=50, blank=True)

    def __str__(self):
        return self.name

class UserDailyQuest(models.Model):
    """
    User's progress on daily quests
    """
    STATUS_CHOICES = [
        ('not_started', 'Not Started'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed')
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='daily_quests')
    daily_quest = models.ForeignKey(DailyQuest, on_delete=models.CASCADE)
    assigned_date = models.DateField()
    current_progress = models.PositiveIntegerField(default=0)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='not_started')
    xp_claimed = models.BooleanField(default=False)

    class Meta:
        unique_together = ('user', 'daily_quest', 'assigned_date')

class UserNotification(models.Model):
    """
    Notifications for users
    """
    NOTIFICATION_TYPES = [
        ('achievement', 'Achievement'),
        ('quest', 'Quest'),
        ('workout', 'Workout'),
        ('friend', 'Friend')
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
    title = models.CharField(max_length=200)
    message = models.TextField()
    notification_type = models.CharField(max_length=50, choices=NOTIFICATION_TYPES)
    created_at = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)
    action_url = models.URLField(blank=True, null=True)

    class Meta:
        ordering = ['-created_at']