Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Obw7d-0006vW-14
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 13:47:37 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id B9FE294430
	for <ltp-list@lists.sourceforge.net>;
	Thu, 22 Jul 2010 15:15:46 +0200 (CEST)
Date: Thu, 22 Jul 2010 15:31:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100722133111.GA30090@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix pthread_mutex_getprioceiling testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
As pointed out by Cheng Shun Xia <csxia@novell.com> the
pthread_mutex_getprioceiling() works only on mutexes initalized with
PTHREAD_PRIO_PROTECT. Also calling perror() after pthread_* fuctions is
meaningless as they return error number directly, this is common mistake
in pthread tests in openposix testsuite and should go to the ltp TODO.

Patch attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--opJtzjQTFsWo+cga
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="pthread_mutex_getprioceiling.patch"

Index: ltp-dev-local/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
===================================================================
--- ltp-dev-local.orig/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
+++ ltp-dev-local/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
@@ -18,42 +18,55 @@
 #include <pthread.h>
 #include <stdio.h>
 #include <sched.h>
+#include <string.h>
 #include "posixtest.h"
 
-int main()
+static void print_error(const char *msg, int ret)
 {
-	
-	/* Make sure there is prioceiling capability. */ 
-	/* #ifndef _POSIX_PRIORITY_SCHEDULING
-	  fprintf(stderr,"prioceiling attribute is not available for testing\n");
-	  return PTS_UNRESOLVED;	
-	#endif */
+	fprintf(stderr, "Errror at %s(): %s\n", msg, strerror(ret));
+}
 
+int main(void)
+{
+	pthread_mutexattr_t ma;
 	pthread_mutex_t mutex;
-	int prioceiling, max_prio, min_prio;
-	
+	int prioceiling, max_prio, min_prio, ret;
+
+	/* Initalize mutex attribut */
+	if ((ret = pthread_mutexattr_init(&ma)) != 0) {
+		print_error("pthread_mutexattr_init", ret);
+		return PTS_UNRESOLVED;
+	}
+
+	/* Initalize mutex protocol */
+	ret = pthread_mutexattr_setprotocol(&ma, PTHREAD_PRIO_PROTECT);
+	if (ret != 0) {
+		print_error("pthread_mutexattr_setprotocol", ret);
+		return PTS_UNRESOLVED;
+	}
+
 	/* Initialize a mutex object */
-	if(pthread_mutex_init(&mutex, NULL) != 0)
-	{
-		perror("Error at pthread_mutex_init()\n");
+	if ((ret = pthread_mutex_init(&mutex, &ma)) != 0) {
+		print_error("pthread_mutex_init", ret);
 		return PTS_UNRESOLVED;
 	}
-	
-	/* Get the prioceiling of the mutex. */
-	if(pthread_mutex_getprioceiling(&mutex, &prioceiling) != 0)
-	{
-		printf("Test FAILED: Error obtaining the priority ceiling\n");
+
+	/* Get the prioceiling of the mutex */
+	if ((ret = pthread_mutex_getprioceiling(&mutex, &prioceiling)) != 0) {
+		fprintf(stderr, "Test FAILED: Error obtaining the priority"
+		                "ceiling: %s\n", strerror(ret));
 		return PTS_FAIL;
 	}
-	
-	/* Get the max and min prio according to SCHED_FIFO (posix scheduling policy) */
+
+	/* Get the max and min according to SCHED_FIFO */
 	max_prio = sched_get_priority_max(SCHED_FIFO);
 	min_prio = sched_get_priority_min(SCHED_FIFO);
 
-	/* Make sure that prioceiling is withing the legal SCHED_FIFO boundries. */
-	if((prioceiling < min_prio) || (prioceiling > max_prio))
-	{
-		printf("Test FAILED: Default prioceiling %d is not compliant with SCHED_FIFO boundry. \n", prioceiling);
+	/* Make sure that prioceiling is in the legal SCHED_FIFO boundries */
+	if ((prioceiling < min_prio) || (prioceiling > max_prio)) {
+		fprintf(stderr, "Test FAILED: Default prioceiling %d is not "
+		                "compliant with SCHED_FIFO boundry.\n",
+		                prioceiling);
 		return PTS_FAIL;
 	}
 

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--opJtzjQTFsWo+cga
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--opJtzjQTFsWo+cga--

