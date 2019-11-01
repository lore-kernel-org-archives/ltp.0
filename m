From: Jan Stancek <jstancek@redhat.com>
Date: Sat,  2 Nov 2019 00:39:24 +0100
Subject: [LTP] [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
Message-ID: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fill_ac() calculates process creation time from current time as:
   ac->ac_btime = get_seconds() - elapsed

get_seconds() doesn't accumulate nanoseconds as regular time getters.
This creates race for user-space (e.g. LTP acct02), which typically
uses gettimeofday(), because process creation time sometimes appear
to be dated 'in past':

    acct("myfile");
    time_t start_time = time(NULL);
    if (fork()==0) {
        sleep(1);
        exit(0);
    }
    waitpid(NULL);
    acct(NULL);

    // acct.ac_btime == 1572616777
    // start_time == 1572616778

Testing: 10 hours of LTP acct02 on s390x with CONFIG_HZ=100,
         test failed on unpatched kernel in 15 minutes

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Fontana <rfontana@redhat.com>
---
 kernel/acct.c   | 4 +++-
 kernel/tsacct.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 81f9831a7859..991c898160cd 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -417,6 +417,7 @@ static void fill_ac(acct_t *ac)
 	struct pacct_struct *pacct = &current->signal->pacct;
 	u64 elapsed, run_time;
 	struct tty_struct *tty;
+	struct timespec64 ts;
 
 	/*
 	 * Fill the accounting struct with the needed info as recorded
@@ -448,7 +449,8 @@ static void fill_ac(acct_t *ac)
 	}
 #endif
 	do_div(elapsed, AHZ);
-	ac->ac_btime = get_seconds() - elapsed;
+	ktime_get_real_ts64(&ts);
+	ac->ac_btime = ts.tv_sec - elapsed;
 #if ACCT_VERSION==2
 	ac->ac_ahz = AHZ;
 #endif
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 7be3e7530841..4d10854255ab 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -24,6 +24,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	const struct cred *tcred;
 	u64 utime, stime, utimescaled, stimescaled;
 	u64 delta;
+	struct timespec64 ts;
 
 	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
 
@@ -34,7 +35,8 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_etime = delta;
 	/* Convert to seconds for btime */
 	do_div(delta, USEC_PER_SEC);
-	stats->ac_btime = get_seconds() - delta;
+	ktime_get_real_ts64(&ts);
+	stats->ac_btime = ts.tv_sec - delta;
 	if (thread_group_leader(tsk)) {
 		stats->ac_exitcode = tsk->exit_code;
 		if (tsk->flags & PF_FORKNOEXEC)
-- 
1.8.3.1

