Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <s.ikarashi@jp.fujitsu.com>) id 1Mmz4l-0004g5-NA
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2009 00:05:47 +0000
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mmz4g-0004Tm-3N
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2009 00:05:47 +0000
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n8E05XIt005728 for <ltp-list@lists.sourceforge.net> (envelope-from
	s.ikarashi@jp.fujitsu.com); Mon, 14 Sep 2009 09:05:34 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 902122AFA14
	for <ltp-list@lists.sourceforge.net>;
	Mon, 14 Sep 2009 09:05:33 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4D1D41F7042
	for <ltp-list@lists.sourceforge.net>;
	Mon, 14 Sep 2009 09:05:33 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0480F1DB803A
	for <ltp-list@lists.sourceforge.net>;
	Mon, 14 Sep 2009 09:05:33 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 84337E18003
	for <ltp-list@lists.sourceforge.net>;
	Mon, 14 Sep 2009 09:05:32 +0900 (JST)
Received: from m105.css.fujitsu.com (m105 [127.0.0.1])
	by m105.s.css.fujitsu.com (Postfix) with ESMTP id 06CD95D8003
	for <ltp-list@lists.sourceforge.net>;
	Mon, 14 Sep 2009 09:05:32 +0900 (JST)
Received: from dune.soft.fujitsu.com (dune.soft.fujitsu.com [10.124.100.185])
	by m105.s.css.fujitsu.com (Postfix) with ESMTP id 998555D8002
	for <ltp-list@lists.sourceforge.net>;
	Mon, 14 Sep 2009 09:05:31 +0900 (JST)
Message-ID: <4AAD88CB.8090403@jp.fujitsu.com>
Date: Mon, 14 Sep 2009 09:05:31 +0900
From: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080408030305050701030904"
Subject: [LTP] [PATCH] build rule for t0 in open_posix_testsuite
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

This is a multi-part message in MIME format.
--------------080408030305050701030904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I propose two patches (two patterns of fix) for an issue of open_posix_testsuite.
I hope either one of them (or more better one someone will write) is committed.

You need to do three steps below in order to run execute.sh of open_posix_testsuite:
 1) make build-tests
 2) cc -O2 -o t0 t0.c
 3) ./execute.sh

I think it's better to include step 2 into step 1 or 3 for convenience.
So I wrote two different patches for these cases.

Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>

Regards,

--------------080408030305050701030904
Content-Type: text/x-patch;
 name="into1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="into1.patch"

Index: ltp/testcases/open_posix_testsuite/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/open_posix_testsuite/Makefile,v
retrieving revision 1.25
diff -u -r1.25 Makefile
--- ltp/testcases/open_posix_testsuite/Makefile	23 Oct 2008 07:36:28 -0000	1.25
+++ ltp/testcases/open_posix_testsuite/Makefile	13 Sep 2009 23:58:41 -0000
@@ -76,7 +76,7 @@
 # Rule to run a build test
 # If the .o doesn't export main, then we don't need to link
 .PRECIOUS: %.test
-%.test: %.o
+%.test: %.o $(top_builddir)/t0
 	@COMPLOG=$(LOGFILE).$$$$; \
 	[ -f $< ] || exit 0; \
 	{ nm -g $< | grep -q ' T main\| D main'; } || \
@@ -96,7 +96,7 @@
 # Rule to run an executable test
 # If it is only a build test, then the binary exist, so we don't need to run
 .PHONY: %.run-test
-%.run-test: %.test $(top_builddir)/t0 $(top_builddir)/t0.val
+%.run-test: %.test $(top_builddir)/t0.val
 	@COMPLOG=$(LOGFILE).$$$$; \
 	[ -f $< ] || exit 0; \
 	$(TIMEOUT) $< > $$COMPLOG 2>&1; \
@@ -144,7 +144,7 @@
 $(top_builddir)/t0.val: $(top_builddir)/t0
 	echo `$(top_builddir)/t0 0; echo $$?` > $(top_builddir)/t0.val
 	
-%.run-test: %.sh $(top_builddir)/t0 $(top_builddir)/t0.val
+%.run-test: %.sh $(top_builddir)/t0.val
 	@COMPLOG=$(LOGFILE).$$$$; \
 	chmod +x $<; \
 	$(TIMEOUT) $< > $$COMPLOG 2>&1; \

--------------080408030305050701030904
Content-Type: text/x-patch;
 name="into3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="into3.patch"

Index: ltp/testcases/open_posix_testsuite/execute.sh
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/open_posix_testsuite/execute.sh,v
retrieving revision 1.3
diff -u -r1.3 execute.sh
--- ltp/testcases/open_posix_testsuite/execute.sh	4 Aug 2009 10:50:07 -0000	1.3
+++ ltp/testcases/open_posix_testsuite/execute.sh	13 Sep 2009 23:58:41 -0000
@@ -166,8 +166,11 @@
 # Maximum five minutes waiting time period to execute a test. If it exceeds, the test case will go into the 'HUNG' category.
 TIMEOUT_VAL=300
 
-# if gcc available then remove the below line comment else put the t0 in posixtestsuite directory.
-#gcc -o t0 t0.c
+if [ ! -x t0 ]
+then
+      cc -O2 -o t0 t0.c
+fi
+
 ./t0 0 > /dev/null 2>&1
 TIMEVAL_RET=$?
 

--------------080408030305050701030904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------080408030305050701030904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080408030305050701030904--

