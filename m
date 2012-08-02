Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Swr52-0006FY-2e
	for ltp-list@lists.sourceforge.net; Thu, 02 Aug 2012 08:48:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Swr4w-0002KW-Su
	for ltp-list@lists.sourceforge.net; Thu, 02 Aug 2012 08:48:28 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q728mE47024559
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Aug 2012 16:48:14 +0800
Message-ID: <501A3EA1.4010902@cn.fujitsu.com>
Date: Thu, 02 Aug 2012 16:47:29 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] pthread_cond_brodcast/1-2.c hung when mem left is not
 enough
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4972954828594627248=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============4972954828594627248==
Content-Type: multipart/alternative;
	boundary="------------060908060303030109000508"

This is a multi-part message in MIME format.
--------------060908060303030109000508
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

pthread_cond_brodcast/1-2.c try to create as many childrens(thread or process)
as possible,however,if current free memoryis exhausted before all childrens are
started,the case will timeout and hung since it's stated with program "t0".
  
The patch adjust count of childrens according tojudgement of size of current free
memory.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
  .../interfaces/pthread_cond_broadcast/1-2.c        | 39 +++++++++++++++++++---
  1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
index f6ad9df..14bda10 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
@@ -48,6 +48,7 @@
  #include <sys/mman.h>
  #include <sys/wait.h>
  #include <semaphore.h>
+#include <sys/sysinfo.h>
  
  #include "../testfrmw/testfrmw.h"
  #include "../testfrmw/testfrmw.c"
@@ -82,8 +83,8 @@
  #endif
  
  /* Do not create more than this amount of children: */
-#define MAX_PROCESS_CHILDREN  (200)
-#define MAX_THREAD_CHILDREN   (1000)
+int max_process_children = 200;
+int max_thread_children = 1000;
  
  #define TIMEOUT  (180)
  
@@ -243,6 +244,34 @@ void *timer(void *arg)
  	return NULL; /* For compiler */
  }
  
+int decide_process_children_count(void)
+{
+	struct sysinfo sysinforma;
+	int ret;
+	int avail_count;
+	unsigned long memper;
+	unsigned long min_stack;
+
+	min_stack = sysconf(_SC_THREAD_STACK_MIN);
+
+	ret = sysinfo(&sysinforma);
+	if (ret != 0)
+		UNRESOLVED(ret, "Failed to get system infomation.");
+
+	memper = min_stack * max_thread_children;
+	if (memper > sysinforma.freeram)
+		UNTESTED("Free ram not enough for test.");
+
+	avail_count = sysinforma.freeram/memper;
+	if (avail_count < 10)
+		UNTESTED("Free ram not enough for test.");
+	
+	max_process_children = (avail_count<max_process_children ?
+					avail_count : max_process_children);
+
+	return 0;
+}
+
  int main(int argc, char *argv[])
  {
  	int ret;
@@ -268,6 +297,8 @@ int main(int argc, char *argv[])
  
  	output_init();
  
+	decide_process_children_count();
+
  	/* check the system abilities */
  	pshared = sysconf(_SC_THREAD_PROCESS_SHARED);
  	cs = sysconf(_SC_CLOCK_SELECTION);
@@ -476,7 +507,7 @@ int main(int argc, char *argv[])
  				} else {
  					ret = errno;
  				}
-			} while ((ret == 0) && (child_count < MAX_THREAD_CHILDREN));
+			} while ((ret == 0) && (child_count < max_thread_children));
  			#if VERBOSE > 2
  			output("[parent] Created %i children threads\n", child_count);
  			#endif
@@ -504,7 +535,7 @@ int main(int argc, char *argv[])
  				} else {
  					ret = errno;
  				}
-			} while ((ret == 0) && (child_count < MAX_PROCESS_CHILDREN));
+			} while ((ret == 0) && (child_count < max_process_children));
  			#if VERBOSE > 2
  			output("[parent] Created %i children processes\n", child_count);
  			#endif
-- 
1.7.11.rc0


--------------060908060303030109000508
Content-Transfer-Encoding: 7bit
Content-Type: text/html; charset=ISO-8859-1

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <pre>pthread_cond_brodcast/1-2.c try to create as many childrens(thread or process) 
as possible,however,if current free memory <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1"><span style="color: rgb(0, 0, 0); font-family: Arial; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 20px; orphans: 2; text-align: -webkit-auto; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline !important; float: none; ">is exhaust</span>ed before all childrens are
started,the case will timeout and hung since it's stated with program "t0".
&nbsp;
The patch adjust count of childrens according to <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">judgement of size of current free
memory.

Signed-off-by: DAN LI <a class="moz-txt-link-rfc2396E" href="mailto:li.dan@cn.fujitsu.com">&lt;li.dan@cn.fujitsu.com&gt;</a>
---
 .../interfaces/pthread_cond_broadcast/1-2.c        | 39 +++++++++++++++++++---
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
index f6ad9df..14bda10 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
@@ -48,6 +48,7 @@
 #include &lt;sys/mman.h&gt;
 #include &lt;sys/wait.h&gt;
 #include &lt;semaphore.h&gt;
+#include &lt;sys/sysinfo.h&gt;
 
 #include "../testfrmw/testfrmw.h"
 #include "../testfrmw/testfrmw.c"
@@ -82,8 +83,8 @@
 #endif
 
 /* Do not create more than this amount of children: */
-#define MAX_PROCESS_CHILDREN  (200)
-#define MAX_THREAD_CHILDREN   (1000)
+int max_process_children = 200;
+int max_thread_children = 1000;
 
 #define TIMEOUT  (180)
 
@@ -243,6 +244,34 @@ void *timer(void *arg)
 	return NULL; /* For compiler */
 }
 
+int decide_process_children_count(void)
+{
+	struct sysinfo sysinforma;
+	int ret;
+	int avail_count;
+	unsigned long memper;
+	unsigned long min_stack;
+
+	min_stack = sysconf(_SC_THREAD_STACK_MIN);
+
+	ret = sysinfo(&amp;sysinforma);
+	if (ret != 0)
+		UNRESOLVED(ret, "Failed to get system infomation.");
+
+	memper = min_stack * max_thread_children;
+	if (memper &gt; sysinforma.freeram)
+		UNTESTED("Free ram not enough for test.");
+
+	avail_count = sysinforma.freeram/memper;
+	if (avail_count &lt; 10) 
+		UNTESTED("Free ram not enough for test.");
+	
+	max_process_children = (avail_count&lt;max_process_children ?
+					avail_count : max_process_children);
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int ret;
@@ -268,6 +297,8 @@ int main(int argc, char *argv[])
 
 	output_init();
 
+	decide_process_children_count();
+
 	/* check the system abilities */
 	pshared = sysconf(_SC_THREAD_PROCESS_SHARED);
 	cs = sysconf(_SC_CLOCK_SELECTION);
@@ -476,7 +507,7 @@ int main(int argc, char *argv[])
 				} else {
 					ret = errno;
 				}
-			} while ((ret == 0) &amp;&amp; (child_count &lt; MAX_THREAD_CHILDREN));
+			} while ((ret == 0) &amp;&amp; (child_count &lt; max_thread_children));
 			#if VERBOSE &gt; 2
 			output("[parent] Created %i children threads\n", child_count);
 			#endif
@@ -504,7 +535,7 @@ int main(int argc, char *argv[])
 				} else {
 					ret = errno;
 				}
-			} while ((ret == 0) &amp;&amp; (child_count &lt; MAX_PROCESS_CHILDREN));
+			} while ((ret == 0) &amp;&amp; (child_count &lt; max_process_children));
 			#if VERBOSE &gt; 2
 			output("[parent] Created %i children processes\n", child_count);
 			#endif
-- 
1.7.11.rc0

</pre>
  </body>
</html>

--------------060908060303030109000508--


--===============4972954828594627248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============4972954828594627248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4972954828594627248==--

