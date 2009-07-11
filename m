Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MujQf-0003xJ-SU
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 09:00:25 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MujQZ-0007ia-Ji
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 09:00:25 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0E988125139FE
	for <ltp-list@lists.sourceforge.net>;
	Mon,  5 Oct 2009 10:59:56 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1MujQB-0000Fx-00
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 10:59:55 +0200
Date: Sat, 11 Jul 2009 11:31:00 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u1bknvz5cfnueu@debian>
Subject: [LTP] [PATCH] Two fixes of the utimes01 test
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090711093100.oppUR0OQfTX-yZtvZoaOc5CNGQ34HwA9048OIUUB8o4@z>

 - POSIX specifies utimes returns EPERM, not EACCESS, when there are
   insufficient rights and times is not NULL

 - the timeval structures need to be initialized, because garbage in
   the nanosecond part would cause EINVAL

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/utimes/utimes01.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index 7705269..2fddb99 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -209,7 +209,7 @@ static struct test_case tcase[] = {
                 .m_sec          = 2000,
                 .user           = "nobody",
                 .ret            = -1,
-                .err            = EACCES, // RHEL4U1 + 2.6.18 returns EPERM
+                .err            = EPERM, // RHEL4U1 + 2.6.18 returns EPERM,
         },
         { // case03
                 .ttype          = FILE_NOT_EXIST,
@@ -240,7 +240,7 @@ static int do_test(struct test_case *tc)
 {
         int sys_ret;
         int result = RESULT_OK;
-	struct timeval tv[2];
+        struct timeval tv[2] = { 0 };
         const char *fpath = FNAME;
         int rc, cmp_ok = 1;
         struct stat st;
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
