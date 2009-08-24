Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MfR5t-00028Q-0Y
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 04:23:45 +0000
Received: from smtp108.biz.mail.re2.yahoo.com ([206.190.52.47])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MfR5n-0007Wv-Ih
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 04:23:44 +0000
Date: Mon, 24 Aug 2009 12:00:51 +0800 (CST)
Message-Id: <20090824.120051.112612549.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/3] Check unshare Function
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

This patch set fixes several problems for unshare tests. The first one
is to add a build-time checking for unshare function. The second one is
to fix unshare01 test,

* deal with no unshare implementation in both glibc and kernel.
* simplify logic.
* fix coding style.

The final one is to fix unshare02 test,

* deal with no unshare implementation in both glibc and kernel.
* fix an incorrect expected result and simplify logic.
* fix coding style.

Signed-off-by: CAI Qian <caiqian@cclom.cn>

 configure.ac      |    1 +
 m4/ltp-unshare.m4 |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index aa7bef4..ca8adc5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -18,6 +18,7 @@ sys/inotify.h \
 LTP_CHECK_SYSCALL_EVENTFD
 LTP_CHECK_SYSCALL_MODIFY_LDT
 LTP_CHECK_SYSCALL_SIGNALFD
+LTP_CHECK_SYSCALL_UNSHARE
 LTP_CHECK_SELINUX
 LTP_CHECK_CRYPTO
 LTP_CHECK_TASKSTATS
diff --git a/m4/ltp-unshare.m4 b/m4/ltp-unshare.m4
new file mode 100644
index 0000000..6476141
--- /dev/null
+++ b/m4/ltp-unshare.m4
@@ -0,0 +1,2 @@
+AC_DEFUN([LTP_CHECK_SYSCALL_UNSHARE],
+AC_CHECK_FUNCS_ONCE(unshare))

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
