class Timer {
  int timer_length, continue_time, start_time;
  boolean reverse_mode, running;

  Timer(int Timer_length) {
    this.reverse_mode = false;
    this.running = false;

    this.timer_length = Timer_length;
    this.continue_time = 0;
    this.start_time = millis();
  }

  Timer(int Timer_length, int Continue_time) {
    this.reverse_mode = false;
    this.running = false;

    this.timer_length = Timer_length;
    this.continue_time = Continue_time;
    this.start_time = millis();
  }

  void start() {
    if (this.running) return;
    this.start_time = millis();
    this.running = true;
  }

  void stop() {
    if (!this.running) return;
    this.continue_time = this.getElapsedTime();
    this.running = false;
  }
  
  void reset() {
    this.start_time = millis();
  }

  void reverse() {
    this.continue_time = this.getElapsedTime();
    this.reverse_mode = !this.reverse_mode;
    this.start_time = millis();
  }
  
  void setTimerLength(int Timer_length) {
    this.timer_length = Timer_length;
  }
  
  void setElapsedTime(int Continue_time) {
    this.continue_time = Continue_time;
  }

  boolean isRunning() {
    return this.running;
  }

  boolean isReverse() {
    return this.reverse_mode;
  }

  boolean isCompleat() {
    if (this.reverse_mode) {
      if (this.getElapsedTime() < 0) {
        return true;
      }
    } else {
      if (this.getElapsedTime() > this.timer_length) {
        return true;
      }
    }

    return false;
  }

  int getTimerLength() {
    return this.timer_length;
  }

  int getElapsedTime() {
    if (!this.running) this.start_time = millis();

    if (this.reverse_mode) {
      return this.continue_time - (millis() - this.start_time);
    } else {
      return millis() - this.start_time + this.continue_time;
    }
  }

  float getProgress() {
    float rate = float(this.getElapsedTime()) / float(this.getTimerLength());
    if (rate < 0) rate = 0;
    if (rate > 1) rate = 1;

    return rate;
  }
}
