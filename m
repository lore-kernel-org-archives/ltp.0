Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NKUiK-0002k1-Ue
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 10:33:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NKUiK-0002xd-14
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 10:33:08 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBFAX1SY004896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Dec 2009 05:33:01 -0500
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id nBFAX1SZ032269
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Dec 2009 05:33:01 -0500
Date: Tue, 15 Dec 2009 05:33:01 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1906840727.360001260873181371.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <88580605.359961260873174827.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14923_607291553.1260873181371"
Subject: [LTP] [PATCH] fix libevent01 testcase
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

------=_Part_14923_607291553.1260873181371
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

I found libevent01 testcase is disabled in testcase/kernel/syscalls/Makefile,
the testscript can't be installed, I got a "FAIL" in testing. Here's the Patch
to fix this problem.

Thanks,
Caspar
------=_Part_14923_607291553.1260873181371
Content-Type: text/x-patch; name=syscalls-libevent01.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=syscalls-libevent01.patch

Hi,

	I found libevent01 testcase is disabled in testcase/kernel/syscalls/Makefile,
	the testscript can't be installed, I got a "FAIL" in testing. Here's the Patch
	to fix this problem.

	Signed-off-by: Caspar Zhang <czhang@redhat.com>

diff -Naur a/runtest/syscalls b/runtest/syscalls
--- a/runtest/syscalls	2009-11-20 15:07:04.000000000 +0800
+++ b/runtest/syscalls	2009-12-15 16:55:33.517261473 +0800
@@ -465,7 +465,7 @@
 lchown02 prep_create_link; lchown02
 lchown02_16 prep_create_link; lchown02_16
 
-libevent01 export LTPROOT; run_libevent.sh
+libevent01 export LTPROOT; libevent/run_libevent.sh
 
 link01 symlink01 -T link01
 link02 link02
diff -Naur a/testcases/kernel/syscalls/libevent/run_libevent.sh b/testcases/kernel/syscalls/libevent/run_libevent.sh
--- a/testcases/kernel/syscalls/libevent/run_libevent.sh	2009-11-20 03:08:36.000000000 +0800
+++ b/testcases/kernel/syscalls/libevent/run_libevent.sh	2009-12-15 16:55:12.750261436 +0800
@@ -31,7 +31,7 @@
 	tst_resm TCONF "You need to be root to run these tests"
 	TST_EXIT=0
 else
-	"$LTPROOT/testcases/bin/tests/test-libevent.sh"
+	"$LTPROOT/testcases/bin/libevent/test/test-libevent.sh"
 	TST_EXIT=$?
 fi
 tst_cleanup
diff -Naur a/testcases/kernel/syscalls/Makefile b/testcases/kernel/syscalls/Makefile
--- a/testcases/kernel/syscalls/Makefile	2009-12-01 17:57:15.000000000 +0800
+++ b/testcases/kernel/syscalls/Makefile	2009-12-15 16:54:46.271261315 +0800
@@ -24,52 +24,42 @@
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-# libevent requires some massaging to get this to work.
-FILTER_OUT_DIRS		:= libevent
 # pcllib is busted as all heck because of libtool
-FILTER_OUT_DIRS		+= pcllib
+FILTER_OUT_DIRS		:= pcllib
 
-# libevent doesn't compile right now... I have no bloody clue what breaks it
-# when doing make clean...
-ifdef DO_NO_COMPILE_ME
+## libevent doesn't compile right now... I have no bloody clue what breaks it
+## when doing make clean...
+# libevent enabled by Caspar Zhang <czhang#redhat.com>
 ifeq ($(wildcard $(abs_srcdir)/libevent/test/Makefile),)
 $(warning libevent/test/Makefile does not exist; skipping to avoid compile errors)
 $(warning Please run "make autotools" and "configure" at the top-level LTP)
 $(warning directory if you want to run this test)
 else
 
-LIBEVENT		:= libevent/lib/libevent.a
-
-LIBEVENT_LINK		:= libevent/libevent.a
+LIBEVENT		:= libevent/libevent.a
 
 CLEAN_DEPS		:= libevent-clean
 
-CLEAN_TARGETS		:= $(LIBEVENT) $(LIBEVENT_LINK)
+CLEAN_TARGETS		:= $(LIBEVENT) 
 
 INSTALL_DEPS		:= libevent-install
 
-INSTALL_TARGETS		:= libevent/run-libevent.sh libevent/test/test-libevent.sh
-
 LIBEVENT_APPS		:= regress test-eof test-init test-time test-weof
 
-MAKE_DEPS		:= libevent-all
+INSTALL_TARGETS		:= libevent/run_libevent.sh libevent/test/test-libevent.sh $(addprefix libevent/test/,$(LIBEVENT_APPS))
 
-MAKE_TARGETS		:= $(addprefix libevent/test/,$(LIBEVENT_APPS))
+MAKE_DEPS		:= $(LIBEVENT) libevent-all
 
-libevent libevent/test: %:
-	mkdir -p "$@"
-
-$(LIBEVENT): $(abs_srcdir)/libevent/Makefile libevent
+$(LIBEVENT): $(abs_srcdir)/libevent/Makefile 
 	$(MAKE) -C libevent -f "$(firstword $^)" libevent.a
 
-libevent-all: $(abs_srcdir)/libevent/test/Makefile | $(LIBEVENT) libevent/test
+libevent-all: $(abs_srcdir)/libevent/test/Makefile 
 	$(MAKE) -C libevent/test -f "$(firstword $^)" $(LIBEVENT_APPS)
 
-libevent-clean libevent-install: libevent-%: $(abs_srcdir)/libevent/test/Makefile | libevent/test
+libevent-clean libevent-install: libevent-%: $(abs_srcdir)/libevent/test/Makefile 
 	$(MAKE) -C libevent/test -f "$(firstword $^)" $*
 
 endif
-endif
 
 ifeq ($(UCLINUX),1)
 FILTER_OUT_DIRS	+= capget capset chmod chown clone fork getcontext llseek \

------=_Part_14923_607291553.1260873181371
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

------=_Part_14923_607291553.1260873181371
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_14923_607291553.1260873181371--

