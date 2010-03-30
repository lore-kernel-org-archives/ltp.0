Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NwQiN-0001eX-Mx
	for ltp-list@lists.sourceforge.net; Tue, 30 Mar 2010 01:57:59 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NwQiL-00083o-HY
	for ltp-list@lists.sourceforge.net; Tue, 30 Mar 2010 01:57:59 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.26])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 8FFC821132A
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Mar 2010 01:57:51 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id EB4773DD022
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Mar 2010 01:57:50 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Mar 2010 10:57:49 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 30 Mar 2010 10:57:49 +0900
Message-ID: <000301cacfac$6663edf0$332bc9d0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About mail test
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

Hi,

I found two problems in mail test.
(${LTPROOT}/testcases/commands/mail/mail_tests.sh)
They are simple mistakes, I think.

1) About judgment for making a user name
In line 80 of "mail_tests.sh", there is following sentence.
------------
if id -u mail_test >/dev/null 2>&1; then
------------
This control sentence is going to judge whether the result of 
"id -u mail_test" command is normal or not, I think.
But this sentence is not effective.
Therefore the user name "make_test" cannot be made when this user name
isn't exist.


2) About "blind carbon copy" option
In "mail_tests.sh", there are 5 tests about mail.
5th is "blind carbon copy" test.
However, this test doesn't use "-b" option but uses "-c" option.


Please consider the following revision.
============
--- ./testcases/commands/mail/mail_tests.sh     2010-03-23
17:56:21.000000000 +0900
+++ ./testcases/commands/mail/mail_tests.sh.new 2010-03-30
10:39:40.000000000 +0900
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
