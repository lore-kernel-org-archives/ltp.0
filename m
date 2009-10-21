Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1N41KQ-0006aa-GY
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 23:56:22 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N41KJ-0006EG-R7
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 23:56:22 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4509B1352040D
	for <ltp-list@lists.sourceforge.net>;
	Sat, 31 Oct 2009 00:56:10 +0100 (CET)
Received: from [83.208.36.163] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314) id 1N41KE-0003hZ-00
	for ltp-list@lists.sourceforge.net; Sat, 31 Oct 2009 00:56:10 +0100
Date: Wed, 21 Oct 2009 02:02:00 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u2m3nzm5cfnueu@debian>
Subject: [LTP] [PATCH] Fix expected output in ar01 testcase
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
Message-ID: <20091021000200.7KmzUygbjRPW0Rjur-z41nQ4ezUsOeLOYR5Hauifuh0@z>

Hello,

 According to POSIX, the verbose output of "ar -tv" should not contain
 the leading zero in day-of-month (its format should be equivalent to
 %e specifier of date) [source: man(1posix)]

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/commands/ade/ar/ar01 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/commands/ade/ar/ar01 b/testcases/commands/ade/ar/ar01
index 926be1c..c8f85eb 100755
--- a/testcases/commands/ade/ar/ar01
+++ b/testcases/commands/ade/ar/ar01
@@ -573,7 +573,7 @@ rm -rf $TCtmp/lib.a;cd $TCdat $TCtmp/lib.a.exp *out
 ar -cr $TCtmp/lib.a file1.in file2.in file3.in
 crtest
 
-ls -ln --time-style=+%b" "%d" "%H:%M file1.in file2.in file3.in |
+ls -ln --time-style=+%b" "%e" "%H:%M file1.in file2.in file3.in |
 while
 read permissions link uid gid size month day time file_name
 do
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
