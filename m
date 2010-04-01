Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NxJQp-0001Fk-HG
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 12:23:31 +0000
Received: from out04.sjc.mx.trendmicro.com ([216.99.131.8])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxJQl-00089W-Js
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 12:23:31 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000301cacfac$6663edf0$332bc9d0$@co.jp>
	<20100401065639.GA13796@linux.vnet.ibm.com>
In-Reply-To: <20100401065639.GA13796@linux.vnet.ibm.com>
Date: Thu, 1 Apr 2010 21:21:17 +0900
Message-ID: <000001cad195$d4704420$7d50cc60$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] About mail test
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
To: 'Rishikesh K Rajak' <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

I try to suggest patch again by advice of Rishi.
This patch is for ltp-dev-4837fee8a7c2de6a83c8927a574c792ca6dabe4e.tar.gz .

Signed-off-by : Tomonori Mitani <mitani@ryobi.co.jp>

Index: ./testcases/commands/mail/mail_tests.sh
============
--- ./testcases/commands/mail/mail_tests.sh     2010-04-01
16:15:00.000000000 +0900
+++ ./testcases/commands/mail/mail_tests.sh.new 2010-04-01
20:54:40.000000000 +0900
@@ -77,7 +77,8 @@

 # check if the user mail_test exists on this system.
 # if not add that user mail_test, will removed before exiting test.
-if id -u mail_test >/dev/null 2>&1; then
+id -u mail_test >/dev/null 2>&1
+if [ $? -ne 0 ] ; then
        tst_resm TINFO "INIT: Adding temporary user mail_test"
        useradd -m -s /sbin/nologin mail_test > $LTPTMP/tst_mail.out 2>&1
        if [ $? -ne 0 ]; then
@@ -327,7 +328,7 @@
 tst_resm TINFO "Test #5: blind carbon copy user@domain"

 # send mail to root and carbon copy mail_test
-mail -s "Test" root@localhost -c mail_test@localhost < \
+mail -s "Test" root@localhost -b mail_test@localhost < \
        $LTPTMP/tst_mail.in > $LTPTMP/tst_mail.out 2>&1
 if [ $? -ne 0 ]; then
        tst_res TFAIL $LTPTMP/tst_mail.out \
@@ -344,10 +345,10 @@

        if [ "x$RC1" != x0 -a "x$RC2" != x0 ]; then
                tst_resm TPASS \
-                   "Test #5: Mail was carbon copied to user mail_test"
+                   "Test #5: Mail was blind carbon copied to user
mail_test"
        else
                tst_res TFAIL $LTPTMP/tst_mail.res \
-                   "Test #5: mail failed to carbon copy user mail_test.
Reason:"
+                   "Test #5: mail failed to blind carbon copy user
mail_test. Reason:"
                : $(( TFAILCNT += 1 ))
        fi

============


Thank you--

-Tomonori Mitani



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
