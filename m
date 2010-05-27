Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHUJq-00044t-53
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:03:42 +0000
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHUJo-0004MT-Oz
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:03:42 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R43U35002298
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:33:30 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R43UiT766164
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:33:30 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R43UZD031873
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:03:30 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:33:22 +0530
Message-Id: <1274933006-4754-2-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 1/5] realtime: code cleanup on pi-test 0
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
To: Linux Test Project <ltp-list@lists.sourceforge.net>
Cc: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

This patch cleans up the test so as to follow C coding style standards.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: John Stultz <johnstul@us.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-0.c |   67 ++++++++++++++------------
 1 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-0.c b/testcases/realtime/func/pi-tests/testpi-0.c
index 3c56588..cf0a24d 100644
--- a/testcases/realtime/func/pi-tests/testpi-0.c
+++ b/testcases/realtime/func/pi-tests/testpi-0.c
@@ -30,6 +30,7 @@
  *
  *
  * HISTORY
+ *      2010-04-22 Code cleanup by Gowrishankar (gowrishankar.m@in.ibm.com)
  *
  *
  *****************************************************************************/
@@ -45,53 +46,57 @@
 
 void usage(void)
 {
-        rt_help();
-        printf("testpi-0 specific options:\n");
-        printf("testpi-0 doesn't require any commandline options\n");
+	rt_help();
+	printf("testpi-0 specific options:\n");
+	printf("testpi-0 doesn't require any commandline options\n");
 }
 
 int parse_args(int c, char *v)
 {
 
-        int handled = 1;
-        switch (c) {
-                case 'h':
-                        usage();
-                        exit(0);
-                default:
-                        handled = 0;
-                        break;
-        }
-        return handled;
+	int handled = 1;
+	switch (c) {
+	case 'h':
+		usage();
+		exit(0);
+	default:
+		handled = 0;
+		break;
+	}
+	return handled;
 }
 
 /*
  * Test pthread creation at different thread priorities.
  */
-int main(int argc, char* argv[])
+int main(int argc, char *argv[])
 {
-  char *pathbuf; size_t n;
+	char *pathbuf; size_t n;
 
-  rt_init("h",parse_args,argc,argv);
+	rt_init("h", parse_args, argc, argv);
 
-  n = confstr(_CS_GNU_LIBC_VERSION, NULL, (size_t)0);
-  if ((pathbuf = malloc(n)) == NULL) abort();
-  confstr(_CS_GNU_LIBC_VERSION, pathbuf, n);
+	n = confstr(_CS_GNU_LIBC_VERSION, NULL, (size_t)0);
+	pathbuf = malloc(n);
+	if (!pathbuf)
+		abort();
+	confstr(_CS_GNU_LIBC_VERSION, pathbuf, n);
 
-  printf("LIBC_VERSION: %s\n", pathbuf);
-  free(pathbuf);
+	printf("LIBC_VERSION: %s\n", pathbuf);
+	free(pathbuf);
 
-  n = confstr(_CS_GNU_LIBPTHREAD_VERSION, NULL, (size_t)0);
-  if ((pathbuf = malloc(n)) == NULL) abort();
-  confstr(_CS_GNU_LIBPTHREAD_VERSION, pathbuf, n);
+	n = confstr(_CS_GNU_LIBPTHREAD_VERSION, NULL, (size_t)0);
+	pathbuf = malloc(n);
+	if (!pathbuf)
+		abort();
+	confstr(_CS_GNU_LIBPTHREAD_VERSION, pathbuf, n);
 
-  printf("LIBPTHREAD_VERSION: %s\n", pathbuf);
-  free(pathbuf);
+	printf("LIBPTHREAD_VERSION: %s\n", pathbuf);
+	free(pathbuf);
 
-  if (sysconf(_SC_THREAD_PRIO_INHERIT) == -1) {
-	printf("No Prio inheritance support\n");
-  }
-  printf("Prio inheritance support present\n");
+	if (sysconf(_SC_THREAD_PRIO_INHERIT) == -1)
+		printf("No Prio inheritance support\n");
 
-  return 0;
+	printf("Prio inheritance support present\n");
+
+	return 0;
 }
-- 
1.7.1


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
