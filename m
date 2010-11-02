Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PDCrQ-00027n-OW
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 09:08:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PDCrO-0008CZ-Qw
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 09:08:56 +0000
Message-ID: <4CCFD4C8.8060007@cn.fujitsu.com>
Date: Tue, 02 Nov 2010 17:07:20 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH]pthread_mutex_getprioceiling should return
 EINVAl when mutex's protocol is PTHREAD_PRIO_NONE.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

The default value of the mutex's protocol shall be PTHREAD_PRIO_NONE, 
so pthread_mutex_getprioceiling should return EINVAL.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../interfaces/pthread_mutex_getprioceiling/1-1.c  |   30 ++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
index d9251e6..65c8c6b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
@@ -18,6 +18,7 @@
 #include <pthread.h>
 #include <stdio.h>
 #include <sched.h>
+#include <errno.h>
 #include "posixtest.h"
 
 int main()
@@ -29,6 +30,7 @@ int main()
 	  return PTS_UNRESOLVED;	
 	#endif */
 
+	pthread_mutexattr_t mattr;
 	pthread_mutex_t mutex;
 	int prioceiling, max_prio, min_prio;
 	
@@ -40,6 +42,34 @@ int main()
 	}
 	
 	/* Get the prioceiling of the mutex. */
+	if(pthread_mutex_getprioceiling(&mutex, &prioceiling) != EINVAL)
+	{
+		printf("Test FAILED: Default, the protocol attribute of mutex "
+		       "is PTHREAD_PRIO_NONE, so pthread_mutex_getprioceiling "
+		       "should return EINVAL\n");
+		return PTS_FAIL;
+	}
+
+	if (pthread_mutexattr_init(&mattr) != 0)
+	{
+		perror("Error at pthread_mutexattr_init()\n");
+		return PTS_UNRESOLVED;
+	}
+
+	if (pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_PROTECT) != 0)
+	{
+		perror("Error at pthread_mutexattr_setprotocol()\n");
+		return PTS_UNRESOLVED;
+	}
+
+	/* Initialize a mutex object */
+	if(pthread_mutex_init(&mutex, &mattr) != 0)
+	{
+		perror("Error at pthread_mutex_init()\n");
+		return PTS_UNRESOLVED;
+	}
+	
+	/* Get the prioceiling of the mutex. */
 	if(pthread_mutex_getprioceiling(&mutex, &prioceiling) != 0)
 	{
 		printf("Test FAILED: Error obtaining the priority ceiling\n");
-- 
1.7.0.4



-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
