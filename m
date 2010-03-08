Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <y_yao@ryobi.co.jp>) id 1NoYLk-0002Rk-Qi
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 08:30:04 +0000
Received: from out02.sjc.mx.trendmicro.com ([216.99.131.6])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NoYLj-00017j-88
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 08:30:04 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.28])
	by out02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 26A3658C46F
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Mar 2010 08:29:55 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 767F5114B84E
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Mar 2010 08:29:54 +0000 (UTC)
Received: from 5108637 ([10.113.10.201]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Mar 2010 17:29:52 +0900
From: "Yuki Yao" <y_yao@ryobi.co.jp>
Date: Mon, 8 Mar 2010 17:29:52 +0900
Message-ID: <007e01cabe99$8669b9f0$933d2dd0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] mail_tests.sh : a small mistake
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

I found a small mistake about "mail" test.

When mail reception error occurred in "Test #3", this test displays
"Test #2" not "Test #3".

Signed-off-by: Yuki Yao<y_yao@ryobi.co.jp>

Index: ./testcases/commands/mail/mail_tests.sh
==============================
--- ./testcases/commands/mail/mail_tests.sh.orig        2010-03-08
16:00:56.000000000 +0900
+++ ./testcases/commands/mail/mail_tests.sh     2010-03-08
16:01:34.000000000 +0900
@@ -257,7 +257,7 @@
     if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
     then
         $LTPBIN/tst_res TFAIL $LTPTMP/tst_mail.res \
-        "Test #2: No new mail for root. Reason:"
+        "Test #3: No new mail for root. Reason:"
         TFAILCNT=$(( $TFAILCNT+1 ))
     else
         if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne 0 ]


Thanks,
-Yuki Yao



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
