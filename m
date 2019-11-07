From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 7 Nov 2019 13:32:24 +0100
Subject: [LTP] [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
Message-ID: <20191107123224.GA6315@hirez.programming.kicks-ass.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Nov 02, 2019 at 12:39:24AM +0100, Jan Stancek wrote:
> fill_ac() calculates process creation time from current time as:
>    ac->ac_btime = get_seconds() - elapsed
> 
> get_seconds() doesn't accumulate nanoseconds as regular time getters.
> This creates race for user-space (e.g. LTP acct02), which typically
> uses gettimeofday(), because process creation time sometimes appear
> to be dated 'in past':
> 
>     acct("myfile");
>     time_t start_time = time(NULL);
>     if (fork()==0) {
>         sleep(1);
>         exit(0);
>     }
>     waitpid(NULL);
>     acct(NULL);
> 
>     // acct.ac_btime == 1572616777
>     // start_time == 1572616778
> 

Lets start by saying this accounting stuff is terrible crap and it
deserves to fail and burn.

The only spec I found for what it actually wants in those fields is
Documentation/accounting/taskstats-struct.rst, that states:

	/* The time when a task begins, in [secs] since 1970. */
	__u32   ac_btime;               /* Begin time [sec since 1970] */

	/* The elapsed time of a task, in [usec]. */
	__u64   ac_etime;               /* Elapsed time [usec] */

But that is not really well defined. As implemented etime does not
include suspend time (maybe on purpose, maybe not).

And what does btime want? As implemented it jumps around if you ask the
question twice with an adjtime() call or suspend in between. Of course,
if we take an actual CLOCK_REALTIME timestamp at fork() the value
doesn't change, but then it can be in the future (DST,adjtime()), which
is exactly the reason why CLOCK_REALTIME is absolute shit for timestamps
(logging, accounting, etc.).

And your 'fix' is pretty terible too. Arguably ktime_get_seconds() wants
fixing for not having the ns accumulation and actually differing from
tv_sec, but now you accrue one source of ns while still disregarding
another (also, I friggin hate timespec, it's a terrible interface for
time).

All in all, I'm tempted to just declare this stuff broken and -EWONTFIX,
but if we have to do something, something like the below is at least
internally consistent.

---
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 7be3e7530841..76d6325c2724 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -23,18 +23,31 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 {
 	const struct cred *tcred;
 	u64 utime, stime, utimescaled, stimescaled;
-	u64 delta;
+	u64 mono, real, btime;
 
 	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
 
+	mono = ktime_get_ns();
+	real = ktime_get_real_ns();
+
 	/* calculate task elapsed time in nsec */
-	delta = ktime_get_ns() - tsk->start_time;
+	delta = mono - tsk->start_time;
 	/* Convert to micro seconds */
 	do_div(delta, NSEC_PER_USEC);
 	stats->ac_etime = delta;
-	/* Convert to seconds for btime */
-	do_div(delta, USEC_PER_SEC);
-	stats->ac_btime = get_seconds() - delta;
+
+	/*
+	 * Compute btime by subtracting the elapsed time from the current
+	 * CLOCK_REALTIME.
+	 *
+	 * XXX totally buggered, because it changes results across
+	 * adjtime() calls and suspend/resume.
+	 */
+	delta = mono - tsk->start_time; // elapsed in ns
+	btime = real - delta;		// real ns - elapsed ns
+	do_div(btime, NSEC_PER_SEC);	// truncated to seconds
+	stats->ac_btime = btime;
+
 	if (thread_group_leader(tsk)) {
 		stats->ac_exitcode = tsk->exit_code;
 		if (tsk->flags & PF_FORKNOEXEC)
