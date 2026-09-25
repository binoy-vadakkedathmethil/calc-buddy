# Keep AndroidX WorkManager classes
-keep class androidx.work.** { *; }

# Keep Room generated database implementations
-keep class androidx.room.** { *; }

# Keep AndroidX Startup initialization
-keep class androidx.startup.** { *; }

# Keep WorkManager database implementation
-keep class androidx.work.impl.WorkDatabase_Impl { *; }