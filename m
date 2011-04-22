Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QDAac-0005cB-HU
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 07:15:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QDAab-0001pD-LB
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 07:15:42 +0000
From: Caspar Zhang <czhang@redhat.com>
Date: Fri, 22 Apr 2011 15:15:21 +0800
Message-Id: <06352e949d1cb1a9b4cc6c6e1593360f377705e3.1303456355.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] ftrace: fix memory allocation size computation
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
To: LTP List <ltp-list@lists.sourceforge.net>
Cc: Jiri Olsa <jolsa@redhat.com>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


The issue with ftrace_buffer_size.sh is that it allocates 10% of
server's memory. However the tracing ring buffer is implemented using
separate buffers for each CPU in the system. And putting new value to
the buffer_size_kb file increases each CPU buffer with new value. Now
having system with more than 10 CPUs we will get out of memory sooner or
later.

The patch makes sure the memory size is divided by number of CPUs in the
system.

Signed-off-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 .../ftrace_stress/ftrace_buffer_size.sh            |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-ftrace-fix-memory-allocation-size-computation.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-ftrace-fix-memory-allocation-size-computation.patch"

diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
index af5a98e..b8f129d 100755
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
+++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
@@ -17,7 +17,9 @@ LOOP=200
 
 # Use up to 10% of free memory
 free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
-step=$(( $free_mem / 10 / $LOOP ))
+cpus=`cat /proc/cpuinfo | egrep "^processor.*:" | wc -l`
+step=$(( $free_mem / 10 / $LOOP / $cpus ))
+
 if [ $step -eq 0 ]; then
 	$step=1
 	LOOP=50
@@ -40,4 +42,3 @@ for ((; ;))
 
 	sleep 1
 }
-

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Fulfilling the Lean Software Promise
Lean software platforms are now widely adopted and the benefits have been 
demonstrated beyond question. Learn why your peers are replacing JEE 
containers with lightweight application servers - and what you can gain 
from the move. http://p.sf.net/sfu/vmware-sfemails
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



