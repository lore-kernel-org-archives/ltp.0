From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Thu, 24 Jun 2021 11:14:59 +0300
Subject: [LTP] [PATCH 1/2] lib/tst_test: setup TCID earlier in do_setup()
Message-ID: <20210624081500.11715-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

TCID can be NULL in tst_tmpdir() because it is set after do_setup():

    tst_run_tcases()
        do_setup()
            ...
            tid = get_tid();
            ...
            tst_tmpdir()  /* using TCID here */
        TCID = tid;

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 lib/tst_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 36a4809c7..55449c80b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -915,7 +915,7 @@ static void do_setup(int argc, char *argv[])
 
 	assert_test_fn();
 
-	tid = get_tid(argv);
+	TCID = tid = get_tid(argv);
 
 	if (tst_test->sample)
 		tst_test = tst_timer_test_setup(tst_test);
@@ -1412,8 +1412,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	do_setup(argc, argv);
 
-	TCID = tid;
-
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
-- 
2.25.1

