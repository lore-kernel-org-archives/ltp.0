Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1SCnMd-0004uu-Le
	for ltp-list@lists.sourceforge.net; Wed, 28 Mar 2012 07:32:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SCnMb-00014S-71
	for ltp-list@lists.sourceforge.net; Wed, 28 Mar 2012 07:32:15 +0000
Message-ID: <4F72BE67.6010602@cn.fujitsu.com>
Date: Wed, 28 Mar 2012 15:31:51 +0800
From: lidan <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F72AB56.2090209@cn.fujitsu.com>
	<4F72ACF5.1090101@casparzhang.com>
In-Reply-To: <4F72ACF5.1090101@casparzhang.com>
Subject: [LTP]  [PATCHv2]pthread_join:4-1.c: clean up code
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net


sorry for using old version checkpatch.pl.

code cleanup for pthread_join/4-1.c

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 .../conformance/interfaces/pthread_join/4-1.c      |  159 ++++++--------------
 1 file changed, 43 insertions(+), 116 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
index baf0992..fb8c8d3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
@@ -1,7 +1,7 @@
 /*
 * Copyright (c) 2005, Bull S.A..  All rights reserved.
 * Created by: Sebastien Decugis
-
+*
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as
 * published by the Free Software Foundation.
@@ -13,27 +13,23 @@
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write the Free Software Foundation, Inc., 59
 * Temple Place - Suite 330, Boston MA 02111-1307, USA.
-
+*
 * This sample test aims to check the following assertion:
 *
-* If the thread calling pthread_join is canceled, the joined thread remains joinable.
-
+* If the thread calling pthread_join is canceled, the joined thread
+* remains joinable.
+*
 * The steps are:
 * -> create a thread blocked on a mutex.
 * -> create another thread which tries and join the first thread.
 * -> cancel the 2nd thread.
 * -> unblock the semaphore then join the 1st thread
-
 * The test fails if the main thread is unable to join the 1st thread.
-
 */
 
 /* We are testing conformance to IEEE Std 1003.1, 2003 Edition */
 #define _POSIX_C_SOURCE 200112L
 
-/********************************************************************************************/
-/****************************** standard includes *****************************************/
-/********************************************************************************************/
 #include <pthread.h>
 #include <stdarg.h>
 #include <stdio.h>
@@ -41,82 +37,37 @@
 #include <string.h>
 #include <unistd.h>
 #include <semaphore.h>
-
 #include <errno.h>
 
-/********************************************************************************************/
-/******************************   Test framework   *****************************************/
-/********************************************************************************************/
 #include "../testfrmw/testfrmw.h"
 #include "../testfrmw/testfrmw.c"
-/* This header is responsible for defining the following macros:
- * UNRESOLVED(ret, descr);
- *    where descr is a description of the error and ret is an int (error code for example)
- * FAILED(descr);
- *    where descr is a short text saying why the test has failed.
- * PASSED();
- *    No parameter.
- *
- * Both three macros shall terminate the calling process.
- * The testcase shall not terminate in any other maneer.
- *
- * The other file defines the functions
- * void output_init()
- * void output(char * string, ...)
- *
- * Those may be used to output information.
- */
-
-/********************************************************************************************/
-/********************************** Configuration ******************************************/
-/********************************************************************************************/
 #ifndef VERBOSE
 #define VERBOSE 1
 #endif
 
-/********************************************************************************************/
-/***********************************     Helper     *****************************************/
-/********************************************************************************************/
 #include "../testfrmw/threads_scenarii.c"
-/* this file defines:
-* scenarii: array of struct __scenario type.
-* NSCENAR : macro giving the total # of scenarii
-* scenar_init(): function to call before use the scenarii array.
-* scenar_fini(): function to call after end of use of the scenarii array.
-*/
-
-/********************************************************************************************/
-/***********************************    Test case   *****************************************/
-/********************************************************************************************/
 
 pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
 
 /* 1st thread function */
-void * threaded (void * arg)
+void *threaded(void *arg)
 {
 	int ret = 0;
 
 	/* Try and lock the mutex, then exit */
-
 	ret = pthread_mutex_lock(&mtx);
-
 	if (ret != 0)
-	{
 		UNRESOLVED(ret, "Failed to lock mutex");
-	}
 
 	ret = pthread_mutex_unlock(&mtx);
-
 	if (ret != 0)
-	{
 		UNRESOLVED(ret, "Failed to unlock mutex");
-	}
 
 	return NULL;
 }
 
 /* Canceled thread */
-void * joiner_func(void * arg)
+void *joiner_func(void *arg)
 {
 	(void) pthread_join(*(pthread_t *) arg, NULL);
 
@@ -139,116 +90,92 @@ int main(int argc, char *argv[])
 	/* Initialize thread attribute objects */
 	scenar_init();
 
-	for (sc = 0; sc < NSCENAR; sc++)
-	{
+	for (sc = 0; sc < NSCENAR; sc++) {
 #if VERBOSE > 0
 		output("-----\n");
-		output("Starting test with scenario (%i): %s\n", sc, scenarii[ sc ].descr);
+		output("Starting test with scenario (%i): %s\n",
+		       sc, scenarii[sc].descr);
 #endif
 
 		/* Lock the mutex */
 		ret = pthread_mutex_lock(&mtx);
-
 		if (ret != 0)
-		{
 			UNRESOLVED(ret, "failed to lock the mutex");
-		}
 
-		ret = pthread_create(&child, &scenarii[ sc ].ta, threaded, NULL);
+		ret = pthread_create(&child, &scenarii[sc].ta,
+				     threaded, NULL);
 
-		switch (scenarii[ sc ].result)
-		{
-				case 0:                                       /* Operation was expected to succeed */
+		switch (scenarii[sc].result) {
+		/* Operation was expected to succeed */
+		case 0:
 
-				if (ret != 0)
-				{
-					UNRESOLVED(ret, "Failed to create this thread");
-				}
-
-				break;
-
-				case 1:                                       /* Operation was expected to fail */
+			if (ret != 0)
+				UNRESOLVED(ret, "Failed to create this thread");
 
-				if (ret == 0)
-				{
-					UNRESOLVED(-1, "An error was expected but the thread creation succeeded");
-				}
+			break;
+		/* Operation was expected to fail */
+		case 1:
 
-				break;
+			if (ret == 0)
+				UNRESOLVED(-1, "An error was expected "
+					   "but the thread creation succeeded");
 
-				case 2:                                       /* We did not know the expected result */
-				default:
+			break;
+		/* We did not know the expected result */
+		case 2:
+		default:
 #if VERBOSE > 0
 
-				if (ret == 0)
-				{
-					output("Thread has been created successfully for this scenario\n");
-				}
-				else
-				{
-					output("Thread creation failed with the error: %s\n", strerror(ret));
-				}
+			if (ret == 0)
+				output("Thread has been created "
+				       "successfully for this scenario\n");
+			else
+				output("Thread creation failed with the error: "
+				       "%s\n", strerror(ret));
 
 #endif
 
 		}
-
-		if (ret == 0)                                       /* The new thread is running */
-		{
-
+		/* The new thread is running */
+		if (ret == 0) {
 			/* Now create the joiner thread */
-			ret = pthread_create(&joiner, NULL, joiner_func, &child);
+			ret = pthread_create(&joiner, NULL,
+					     joiner_func, &child);
 
 			if (ret != 0)
-			{
-				UNRESOLVED(ret, "Failed to create the joiner thread");
-			}
+				UNRESOLVED(ret, "Failed to create the "
+					   "joiner thread");
 
 			/* Let it enter pthread_join */
 			sched_yield();
 
 			/* Cancel the joiner thread */
 			ret = pthread_cancel(joiner);
-
 			if (ret != 0)
-			{
 				UNRESOLVED(ret, "Failed to cancel the thread");
-			}
 
 			/* Join the canceled thread */
 			ret = pthread_join(joiner, NULL);
-
 			if (ret != 0)
-			{
-				UNRESOLVED(ret, "Failed to join the canceled thread");
-			}
+				UNRESOLVED(ret, "Failed to join the "
+					   "canceled thread");
 
 			/* Unblock the child thread */
 			ret = pthread_mutex_unlock(&mtx);
-
 			if (ret != 0)
-			{
 				UNRESOLVED(ret, "Failed to unlock the mutex");
-			}
 
 			/* Check the first thread is still joinable */
 			ret = pthread_join(child, NULL);
-
-			if (ret != 0)
-			{
+			if (ret != 0) {
 				output("Error returned: %d\n");
 				FAILED("The thread is no more joinable");
 			}
 
-		}
-		else
-		{
+		} else {
 			ret = pthread_mutex_unlock(&mtx);
-
 			if (ret != 0)
-			{
 				UNRESOLVED(ret, "Failed to unlock the mutex");
-			}
 		}
 	}
 
-- 
1.7.10.rc1

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
