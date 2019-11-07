From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 7 Nov 2019 13:46:15 +0100
Subject: [LTP] [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
 <20191107123224.GA6315@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
Message-ID: <20191107124615.GG4131@hirez.programming.kicks-ass.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 07, 2019 at 01:40:47PM +0100, Thomas Gleixner wrote:
> Typing real_start_time makes me really cringe.

I have a patch fixing that...

---
Subject: kernel: Rename tsk->real_start_time
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Nov  7 11:07:58 CET 2019

Since it stores CLOCK_BOOTTIME, not, as the name suggests,
CLOCK_REALTIME, let's rename real_start_time.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1132,7 +1132,7 @@ static int de_thread(struct task_struct
 		 * also take its birthdate (always earlier than our own).
 		 */
 		tsk->start_time = leader->start_time;
-		tsk->real_start_time = leader->real_start_time;
+		tsk->start_boottime = leader->start_boottime;
 
 		BUG_ON(!same_thread_group(leader, tsk));
 		BUG_ON(has_group_leader_pid(tsk));
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -533,7 +533,7 @@ static int do_task_stat(struct seq_file
 	nice = task_nice(task);
 
 	/* convert nsec -> ticks */
-	start_time = nsec_to_clock_t(task->real_start_time);
+	start_time = nsec_to_clock_t(task->start_boottime);
 
 	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
 	seq_puts(m, " (");
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -879,7 +879,7 @@ struct task_struct {
 	u64				start_time;
 
 	/* Boot based time in nsecs: */
-	u64				real_start_time;
+	u64				start_boottime;
 
 	/* MM fault and swap info: this can arguably be seen as either mm-specific or thread-specific: */
 	unsigned long			min_flt;
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2130,7 +2130,7 @@ static __latent_entropy struct task_stru
 	 */
 
 	p->start_time = ktime_get_ns();
-	p->real_start_time = ktime_get_boottime_ns();
+	p->start_boottime = ktime_get_boottime_ns();
 
 	/*
 	 * Make it visible to the rest of the system, but dont wake it up yet.
