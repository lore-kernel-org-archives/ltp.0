From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Aug 2020 14:42:16 +0200
Subject: [LTP] [PATCH v2 1/3] syscalls/mq_timed{send|receive}: Add test
 cases for bad address
In-Reply-To: <20200807113950.69052-2-Filip.Bozuta@syrmia.com>
References: <20200807113950.69052-1-Filip.Bozuta@syrmia.com>
 <20200807113950.69052-2-Filip.Bozuta@syrmia.com>
Message-ID: <20200810124216.GB11869@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

I've moved the tst_get_bad_addr() to the setup since that funciton
allocates memory, which would cause failures with large enough -i test
parameter. The diff is:

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index d99538e4b..de0505106 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -17,6 +17,7 @@ static int fd, fd_root, fd_nonblock, fd_maxint = INT_MAX - 1, fd_invalid = -1;
 #include "mq_timed.h"
 
 static struct tst_ts ts;
+static void *bad_addr;
 
 static struct test_case tcase[] = {
 	{
@@ -139,6 +140,8 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	ts.type = tv->type;
 
+	bad_addr = tst_get_bad_addr(NULL);
+
 	setup_common();
 }
 
@@ -173,7 +176,7 @@ static void do_test(unsigned int i)
 		len -= 1;
 
 	if (tc->bad_ts_addr)
-		abs_timeout = tst_get_bad_addr(cleanup_common);
+		abs_timeout = bad_addr;
 	else
 		abs_timeout = tst_ts_get(tc->rq);
 
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index 7e220f297..d72f5d41a 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -17,6 +17,7 @@ static int fd, fd_root, fd_nonblock, fd_maxint = INT_MAX - 1, fd_invalid = -1;
 #include "mq_timed.h"
 
 static struct tst_ts ts;
+static void *bad_addr;
 
 static struct test_case tcase[] = {
 	{
@@ -152,6 +153,8 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	ts.type = tv->type;
 
+	bad_addr = tst_get_bad_addr(cleanup_common);
+
 	setup_common();
 }
 
@@ -184,12 +187,12 @@ static void do_test(unsigned int i)
 	}
 
 	if (tc->bad_msg_addr)
-		msg_ptr = tst_get_bad_addr(cleanup_common);
+		msg_ptr = bad_addr;
 	else
 		msg_ptr = smsg;
 
 	if (tc->bad_ts_addr)
-		abs_timeout = tst_get_bad_addr(cleanup_common);
+		abs_timeout = bad_addr;
 	else
 		abs_timeout = tst_ts_get(tc->rq);
 

-- 
Cyril Hrubis
chrubis@suse.cz
