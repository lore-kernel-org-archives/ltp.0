Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PnSCy-0002bH-MI
	for ltp-list@lists.sourceforge.net; Thu, 10 Feb 2011 08:49:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PnSCx-00030M-Gt
	for ltp-list@lists.sourceforge.net; Thu, 10 Feb 2011 08:49:00 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p1A8mrGY029022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Feb 2011 03:48:53 -0500
Received: from hpt.nay.redhat.com (dhcp-65-65.nay.redhat.com [10.66.65.65])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id p1A8moQE007232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Feb 2011 03:48:52 -0500
Received: from hpt.nay.redhat.com (localhost.localdomain [127.0.0.1])
	by hpt.nay.redhat.com (8.14.4/8.14.4) with ESMTP id p1A8qXqD009301
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Feb 2011 16:52:33 +0800
Received: (from hpt@localhost)
	by hpt.nay.redhat.com (8.14.4/8.14.4/Submit) id p1A8qWWT009299
	for ltp-list@lists.sourceforge.net; Thu, 10 Feb 2011 16:52:32 +0800
Date: Thu, 10 Feb 2011 16:52:32 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110210085232.GA9285@hpt.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] Fix build of cpuset_syscall_test
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

cpuset_syscall_test now depends on numa lib:

make[1]: Entering directory `/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/root/ltp/testcases/kernel/include -I../../../../../include -I../../../../../include   -L/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib -L/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../../libcontrollers -L../../../../../lib  cpuset_syscall_test.c   -lltp -lcpu_set -lcontrollers -lltp -o cpuset_syscall_test
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib/libcpu_set.a(libcpuset.o): In function `cpuset_addr2node':
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c:3455: undefined reference to `get_mempolicy'
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib/libcpu_set.a(libcpuset.o): In function `cpuset_membind':
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c:3439: undefined reference to `set_mempolicy'
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib/libcpu_set.a(libcpuset.o): In function `cpuset_unpin':
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c:3752: undefined reference to `set_mempolicy'
collect2: ld returned 1 exit status
make[1]: *** [cpuset_syscall_test] Error 1
make[1]: Leaving directory `/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test'
make: *** [all] Error 2

This patch fixes this problem

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 .../cpuset/cpuset_syscall_test/Makefile            |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
index edc6265..17331fb 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
@@ -25,3 +25,5 @@ top_srcdir              ?= ../../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+LDLIBS                  += $(NUMA_LIBS)
-- 
1.7.1

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
