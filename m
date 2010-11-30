Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PNLMO-0003Nf-Pv
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 08:14:48 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PNLMM-0002NU-O0
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 08:14:48 +0000
Message-ID: <4CF4B26F.3030000@cn.fujitsu.com>
Date: Tue, 30 Nov 2010 16:14:39 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX[PATCH]Fix the bug of generate-makefiles.sh
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

Script generate-makefiles.sh has a bug, it can cause run.sh miss some tests.
For exemple, this is the makefile of conformance/interfaces/sched_getparam:

INSTALL_TARGETS+=       4-1.run-test 5-1.sh
MAKE_TARGETS+=          4-1.run-test

INSTALL_TARGETS+=       2-1.run-test 1-1.run-test 3-1.run-test 6-1.run-test
MAKE_TARGETS+=          2-1.run-test 1-1.run-test 3-1.run-test 6-1.run-test

... snip ...

run.sh:
        @echo '#/bin/sh' > $@
        @echo "$(top_srcdir)/bin/run-tests.sh $(subdir) 4-1.run-test 5-1.sh" >> $@
        @chmod +x run.sh

So what about the following patch?

----------------------------------------------------------------------------------

If there are some source files at the child directory, generate_makefile will
be invoked twice, then run.sh will miss some tests.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../scripts/generate-makefiles.sh                  |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
index 536d407..ed6406f 100755
--- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
+++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
@@ -152,11 +152,11 @@ EOF
 
 	fi
 
-	if [ "$tests" != "" ] && ! grep -q '^run.sh' "$makefile.3"; then
+	if ! grep -q '^run.sh' "$makefile.3"; then
 		cat >> "$makefile.3" <<EOF
 run.sh:
 	@echo '#/bin/sh' > \$@
-	@echo "\$(top_srcdir)/bin/run-tests.sh \$(subdir) $tests" >> \$@
+	@echo "\$(top_srcdir)/bin/run-tests.sh \$(subdir) \$(INSTALL_TARGETS)" >> \$@
 	@chmod +x run.sh
 
 EOF
-- 
1.7.0.4



-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
