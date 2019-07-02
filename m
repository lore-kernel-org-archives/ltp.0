From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Jul 2019 16:41:29 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/futex_cmp_requeue01.c: Add new
 test
In-Reply-To: <1561114271-8351-1-git-send-email-ice_yangxiao@163.com>
References: <1561114271-8351-1-git-send-email-ice_yangxiao@163.com>
Message-ID: <20190702144129.GA20468@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with following changes, thanks.

There was no point to repeat the numbers in the test structure three
times, so I simplified the code with:

diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index cdd59a15c..f5264c2ba 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -25,17 +25,14 @@ static struct tcase {
 	int num_waiters;
 	int set_wakes;
 	int set_requeues;
-	int exp_ret;
-	int exp_wakes;
-	int exp_requeues;
 } tcases[] = {
-	{10, 3, 7, 10, 3, 7},
-	{10, 0, 10, 10, 0, 10},
-	{10, 2, 6, 8, 2, 6},
-	{100, 50, 50, 100, 50, 50},
-	{100, 0, 70, 70, 0, 70},
-	{1000, 100, 900, 1000, 100, 900},
-	{1000, 300, 500, 800, 300, 500},
+	{10, 3, 7},
+	{10, 0, 10},
+	{10, 2, 6},
+	{100, 50, 50},
+	{100, 0, 70},
+	{1000, 100, 900},
+	{1000, 300, 500},
 };
 
 static void do_child(void)
@@ -56,6 +53,7 @@ static void verify_futex_cmp_requeue(unsigned int n)
 	int i, status;
 	struct tcase *tc = &tcases[n];
 	int pid[tc->num_waiters];
+	int exp_ret = tc->set_wakes + tc->set_requeues;
 
 	for (i = 0; i < tc->num_waiters; i++) {
 		pid[i] = SAFE_FORK();
@@ -68,9 +66,9 @@ static void verify_futex_cmp_requeue(unsigned int n)
 
 	TEST(futex_cmp_requeue(&futexes[0], futexes[0], &futexes[1],
 	     tc->set_wakes, tc->set_requeues, 0));
-	if (TST_RET != tc->exp_ret) {
+	if (TST_RET != exp_ret) {
 		tst_res(TFAIL, "futex_cmp_requeue() returned %ld, expected %d",
-			TST_RET, tc->exp_ret);
+			TST_RET, exp_ret);
 	}
 
 	num_requeues = futex_wake(&futexes[1], tc->num_waiters, 0);
@@ -88,24 +86,24 @@ static void verify_futex_cmp_requeue(unsigned int n)
 		return;
 	}
 
-	if (num_requeues != tc->exp_requeues) {
+	if (num_requeues != tc->set_requeues) {
 		tst_res(TFAIL,
 			"futex_cmp_requeue() requeues %d waiters, expected %d",
-			num_requeues, tc->exp_requeues);
+			num_requeues, tc->set_requeues);
 		return;
 	}
 
-	if (tc->num_waiters - num_requeues - num_waits != tc->exp_wakes) {
+	if (tc->num_waiters - num_requeues - num_waits != tc->set_wakes) {
 		tst_res(TFAIL,
 			"futex_cmp_requeue() woke up %d waiters, expected %d",
 			tc->num_waiters - num_requeues - num_waits,
-			tc->exp_wakes);
+			tc->set_wakes);
 		return;
 	}
 
 	tst_res(TPASS,
 		"futex_cmp_requeue() woke up %d waiters and requeued %d waiters",
-		tc->exp_wakes, tc->exp_requeues);
+		tc->set_wakes, tc->set_requeues);
 }
 
 static void setup(void)

-- 
Cyril Hrubis
chrubis@suse.cz
