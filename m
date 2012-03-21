Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1SAIh4-0002vk-DU
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 10:23:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SAIgz-0000lJ-Ld
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 10:23:02 +0000
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q2LAMot1009074
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Mar 2012 18:22:51 +0800
Message-ID: <4F69AC25.5020301@cn.fujitsu.com>
Date: Wed, 21 Mar 2012 18:23:33 +0800
From: lidan <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]testfrmw:disable thread cancelability while output is
 running
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
To: ltp-list@lists.sourceforge.net

Function output can be canceled by pthread_cancel(), which,
maybe, leads to a deadlock as it calls pthread_mutex_lock().
That's catched in case "pthread_join/4-1.c".

So,disable thread cancelability until output finishes.


Signed-off-by: LIDAN<li.dan@cn.fujitsu.com>
---
.../conformance/interfaces/testfrmw/testfrmw.c | 4 ++++
1 files changed, 4 insertions(+), 0 deletions(-)

diff --git
a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
index 034faa9..fb54ee9 100644
---
a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
+++
b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
@@ -28,6 +28,7 @@

#include <time.h>
#include <sys/types.h>
+#include <pthread.h>

/* We use a mutex to avoid conflicts in traces */
static pthread_mutex_t m_trace = PTHREAD_MUTEX_INITIALIZER;
@@ -43,7 +44,9 @@ void output(char *string, ...)
char *ts = "[??:??:??]";
struct tm *now;
time_t nw;
+ int oldstate;

+ pthread_setcancelstate(PTHREAD_CANCEL_DISABLE,&oldstate);
pthread_mutex_lock(&m_trace);
nw = time(NULL);
now = localtime(&nw);
@@ -56,6 +59,7 @@ void output(char *string, ...)
vprintf(string, ap);
va_end(ap);
pthread_mutex_unlock(&m_trace);
+ pthread_setcancelstate(oldstate,NULL);
}

void output_fini(void)
--
1.7.1


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
