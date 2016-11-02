From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed,  2 Nov 2016 12:57:02 +0100
Subject: [LTP] [PATCH 1/3] sched_xxx: TCONF instead of TFAIL if user is not
	root
In-Reply-To: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1478087824-31577-2-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tests sched_rr_get_interval01, sched_rr_get_interval02,
sched_rr_get_interval03, sched_setparam02 and sched_setparam03
break with TFAIL if they are not ran as root. This is because
they all require setting scheduling policy to SCHED_RR or other
requiring super user privileges.
This was changed so that tests break with TCONF reporting the
appropriate message to the user if he is not root.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 .../kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c     | 1 +
 .../kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c     | 1 +
 .../kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c     | 1 +
 testcases/kernel/syscalls/sched_setparam/sched_setparam02.c             | 1 +
 testcases/kernel/syscalls/sched_setparam/sched_setparam03.c             | 2 ++
 5 files changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 7527c43..b6084f6 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -115,6 +115,7 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root();
 	/*
 	 * Initialize scheduling parameter structure to use with
 	 * sched_setscheduler()
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 5410176..6bf743f 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -119,6 +119,7 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root();
 	/*
 	 * Initialize scheduling parameter structure to use with
 	 * sched_setscheduler()
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index c9686ad..56f2fcf 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -142,6 +142,7 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root();
 	/*
 	 * Initialize scheduling parameter structure to use with
 	 * sched_setscheduler()
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
index 9321a4e..132cc9d 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
@@ -145,6 +145,7 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root();
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
index 127a74f..50caecb 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
@@ -150,6 +150,8 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root();
+
 	struct sched_param p = { 1 };
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
-- 
1.9.1

