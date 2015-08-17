Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1ZRJID-00038i-Fv
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2015 12:13:33 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRJIB-0003CF-AU
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2015 12:13:33 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t7HCDO2Q006266
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2015 12:13:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t7HCDOYp008523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2015 12:13:24 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t7HCDOLR017170
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2015 12:13:24 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 17 Aug 2015 15:13:18 +0300
Message-Id: <1439813598-11524-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1439813598-11524-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1439813598-11524-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/2] containers: allow linking with additional libs
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
Cc: vasily.isaenko@oracle.com

Makefiles in kernel/containers explicitly enumerate all
required libraries in LDLIBS. This avoids linking the
test cases with additional libraries, whereas all other LTP
test cases can be linked this way.

Fixed this by using $(LDLIBS) instead of '-lltp'.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/containers/mountns/Makefile |    2 +-
 testcases/kernel/containers/mqns/Makefile    |    2 +-
 testcases/kernel/containers/pidns/Makefile   |    2 +-
 testcases/kernel/containers/sysvipc/Makefile |    2 +-
 testcases/kernel/containers/userns/Makefile  |    2 +-
 testcases/kernel/containers/utsname/Makefile |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/containers/mountns/Makefile b/testcases/kernel/containers/mountns/Makefile
index f9b6b99..bd42bf4 100644
--- a/testcases/kernel/containers/mountns/Makefile
+++ b/testcases/kernel/containers/mountns/Makefile
@@ -18,6 +18,6 @@ top_srcdir              ?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS                  := -lclone -lltp
+LDLIBS                  := -lclone $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/mqns/Makefile b/testcases/kernel/containers/mqns/Makefile
index ec30e7d..64c3763 100644
--- a/testcases/kernel/containers/mqns/Makefile
+++ b/testcases/kernel/containers/mqns/Makefile
@@ -24,6 +24,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lpthread -lrt -lclone -lltp
+LDLIBS			:= -lpthread -lrt -lclone $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/pidns/Makefile b/testcases/kernel/containers/pidns/Makefile
index 6dfe694..886e397 100644
--- a/testcases/kernel/containers/pidns/Makefile
+++ b/testcases/kernel/containers/pidns/Makefile
@@ -23,6 +23,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lpthread -lrt -lclone -lltp
+LDLIBS			:= -lpthread -lrt -lclone $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/sysvipc/Makefile b/testcases/kernel/containers/sysvipc/Makefile
index c237e92..00b537f 100644
--- a/testcases/kernel/containers/sysvipc/Makefile
+++ b/testcases/kernel/containers/sysvipc/Makefile
@@ -23,6 +23,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lclone -lltp
+LDLIBS			:= -lclone $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/userns/Makefile b/testcases/kernel/containers/userns/Makefile
index 8370bff..8068109 100644
--- a/testcases/kernel/containers/userns/Makefile
+++ b/testcases/kernel/containers/userns/Makefile
@@ -21,6 +21,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lclone -lltp $(CAP_LIBS)
+LDLIBS			:= -lclone $(LDLIBS) $(CAP_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/utsname/Makefile b/testcases/kernel/containers/utsname/Makefile
index 93c558e..5efcbf6 100644
--- a/testcases/kernel/containers/utsname/Makefile
+++ b/testcases/kernel/containers/utsname/Makefile
@@ -23,6 +23,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lclone -lpthread -lrt -lltp
+LDLIBS			:= -lclone -lpthread -lrt $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
