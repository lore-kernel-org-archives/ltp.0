From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 29 Jun 2016 21:11:40 +0200 (CEST)
Subject: [LTP] [lkp] [signal] 98ea270c46: ltp.float_exp_log.fail
In-Reply-To: <alpine.DEB.2.11.1606292100510.3707@nanos>
References: <20160628030304.GJ19084@yexl-desktop>
 <20160628085608.GA31668@rei.suse.de>
 <alpine.DEB.2.11.1606292100510.3707@nanos>
Message-ID: <alpine.DEB.2.11.1606292110520.3707@nanos>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On Wed, 29 Jun 2016, Thomas Gleixner wrote:

> On Tue, 28 Jun 2016, Cyril Hrubis wrote:
> > Looking at the test it creates a separate thread to handle signals which
> > sleeps in sigwait() which is implemented in glibc via the sigtimedwait
> > syscall with NULL timeout.
> > 
> > Looking at the patch the ktime_t timeout is initialized to 0 instead of
> > MAX_SCHEDULE_TIMEOUT now so I guess that the call with NULL timeout does
> > poll instead of sleeping in kernel waiting for signals to arrive. That
> > should be fixed.
> 
> You're right. I misread the code...
> 

Fix below. I pushed it also out to the WIP.timers branch

Thanks,

	tglx

8<-------

commit 503d9c9ac9f98f403da0acbc9ba6e42185b952e2
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Jun 29 21:03:58 2016 +0200

    signal: Handle the case where no timeout is handed in
    
    Needs to be folded back.
    
    Fixes: 98ea270c46b4: "signal: Use hrtimer for sigtimedwait"
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/kernel/signal.c b/kernel/signal.c
index 50fdf540d035..af21afc00d08 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2753,8 +2753,8 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 		    const struct timespec *ts)
 {
+	ktime_t *to = NULL, timeout = { .tv64 = KTIME_MAX };
 	struct task_struct *tsk = current;
-	ktime_t timeout = { .tv64 = 0 };
 	sigset_t mask = *which;
 	int sig, ret = 0;
 
@@ -2762,6 +2762,7 @@ int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 		if (!timespec_valid(ts))
 			return -EINVAL;
 		timeout = timespec_to_ktime(*ts);
+		to = &timeout;
 	}
 
 	/*
@@ -2785,8 +2786,7 @@ int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 		spin_unlock_irq(&tsk->sighand->siglock);
 
 		__set_current_state(TASK_INTERRUPTIBLE);
-		ret = freezable_schedule_hrtimeout_range(&timeout,
-							 tsk->timer_slack_ns,
+		ret = freezable_schedule_hrtimeout_range(to, tsk->timer_slack_ns,
 							 HRTIMER_MODE_REL);
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
