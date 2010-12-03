Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1POS4t-0004ES-2B
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 09:37:19 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1POS4r-0001Uk-TD
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 09:37:19 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oB39IpWC002602
	for <ltp-list@lists.sourceforge.net>; Fri, 3 Dec 2010 04:18:51 -0500
Date: Fri, 3 Dec 2010 04:18:51 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <569790189.1177001291367931467.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1374950848.1176971291367928709.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_65564_1636424874.1291367931466"
Subject: [LTP] [PATCH] cpuset01: fix LIBNUMA.
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
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_65564_1636424874.1291367931466
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This should apply after,
http://marc.info/?l=ltp-list&m=129111276531987&w=2

---
 testcases/kernel/mem/cpuset/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
index 65d3aab..822e783 100644
--- a/testcases/kernel/mem/cpuset/Makefile
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -22,4 +22,4 @@ top_srcdir              ?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-LDLIBS 			+= -lnuma -lm
+LDLIBS 			+= $(NUMA_LIBS) -lm
-- 
1.7.1
------=_Part_65564_1636424874.1291367931466
Content-Type: text/x-patch; name=0001-cpuset01-fix-LIBNUMA.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0001-cpuset01-fix-LIBNUMA.patch

From 2600faf2f9cf0013d72c74844bf7b0d89b6d2340 Mon Sep 17 00:00:00 2001
From: CAI Qian <caiqian@redhat.com>
Date: Fri, 3 Dec 2010 16:59:43 +0800
Subject: [PATCH] cpuset01: fix LIBNUMA.

---
 testcases/kernel/mem/cpuset/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
index 65d3aab..822e783 100644
--- a/testcases/kernel/mem/cpuset/Makefile
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -22,4 +22,4 @@ top_srcdir              ?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-LDLIBS 			+= -lnuma -lm
+LDLIBS 			+= $(NUMA_LIBS) -lm
-- 
1.7.1


------=_Part_65564_1636424874.1291367931466
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
------=_Part_65564_1636424874.1291367931466
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_65564_1636424874.1291367931466--

