Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WFl7l-0000BY-FA
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 13:54:13 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WFl7k-0002QG-5o
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 13:54:13 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1IDs5s5017076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 13:54:06 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1IDs4fZ027205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 13:54:05 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s1IDs4OV016068
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 13:54:04 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 18 Feb 2014 17:53:36 +0400
Message-Id: <1392731616-25514-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] lib/tst_res.c: synchronize access to tst_res functions
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

The patch adds synchronization mechanism which is required (tst_res.c
uses global variables e.g. T_exitval, tst_count, T_out, ...) when tst_res
functions are used in multi-threaded tests.
Note: it will only work if test is linked with pthread library, also some
functions include each other that is why recursive mutex is used (can be
locked several times by the same thread).

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 lib/tst_res.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index 2a3eff6..8faa5a9 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -93,6 +93,7 @@
 
 #define _GNU_SOURCE		/* for asprintf */
 
+#include <pthread.h>
 #include <assert.h>
 #include <errno.h>
 #include <stdio.h>
@@ -138,6 +139,8 @@ pid_t spawned_program_pid;
 	assert(strlen(buf) > 0);		\
 } while (0)
 
+static pthread_mutex_t tmutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
+
 /*
  * Define local function prototypes.
  */
@@ -226,6 +229,8 @@ const char *strttype(int ttype)
  */
 void tst_res(int ttype, const char *fname, const char *arg_fmt, ...)
 {
+	pthread_mutex_lock(&tmutex);
+
 	char tmesg[USERMESG];
 	int ttype_result = TTYPE_RESULT(ttype);
 
@@ -286,6 +291,7 @@ void tst_res(int ttype, const char *fname, const char *arg_fmt, ...)
 		tst_count++;
 	}
 
+	pthread_mutex_unlock(&tmutex);
 }
 
 /*
@@ -351,6 +357,8 @@ static void tst_condense(int tnum, int ttype, const char *tmesg)
  */
 void tst_flush(void)
 {
+	pthread_mutex_lock(&tmutex);
+
 #if DEBUG
 	printf("IN tst_flush\n");
 	fflush(stdout);
@@ -365,6 +373,8 @@ void tst_flush(void)
 	}
 
 	fflush(T_out);
+
+	pthread_mutex_unlock(&tmutex);
 }
 
 /*
@@ -537,6 +547,8 @@ static void check_env(void)
  */
 void tst_exit(void)
 {
+	pthread_mutex_lock(&tmutex);
+
 #if DEBUG
 	printf("IN tst_exit\n");
 	fflush(stdout);
@@ -568,10 +580,13 @@ pid_t tst_vfork(void)
  */
 int tst_environ(void)
 {
+	pthread_mutex_lock(&tmutex);
+	int ret = 0;
 	if ((T_out = fdopen(dup(fileno(stdout)), "w")) == NULL)
-		return -1;
-	else
-		return 0;
+		ret = -1;
+
+	pthread_mutex_unlock(&tmutex);
+	return ret;
 }
 
 /*
@@ -586,6 +601,8 @@ static int tst_brk_entered = 0;
  */
 void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_fmt, ...)
 {
+	pthread_mutex_lock(&tmutex);
+
 	char tmesg[USERMESG];
 	int ttype_result = TTYPE_RESULT(ttype);
 
@@ -633,6 +650,7 @@ void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_
 	if (tst_brk_entered == 0)
 		tst_exit();
 
+	pthread_mutex_unlock(&tmutex);
 }
 
 /*
@@ -659,6 +677,8 @@ void tst_resm(int ttype, const char *arg_fmt, ...)
  */
 void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt, ...)
 {
+	pthread_mutex_lock(&tmutex);
+
 	char tmesg[USERMESG];
 
 #if DEBUG
@@ -692,6 +712,8 @@ void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt,
 			pmesg = tmesg;
 		}
 	}
+
+	pthread_mutex_unlock(&tmutex);
 }
 
 /*
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
