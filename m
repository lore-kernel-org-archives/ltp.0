Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OxwKQ-0006gJ-Qh
	for ltp-list@lists.sourceforge.net; Tue, 21 Sep 2010 06:27:46 +0000
Received: from out20.sjc.mx.trendmicro.com ([216.99.131.77])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OxwKP-0005kZ-D8
	for ltp-list@lists.sourceforge.net; Tue, 21 Sep 2010 06:27:46 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.131])
	by out20.sjc.mx.trendmicro.com (Postfix) with ESMTP id 449D7980437
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Sep 2010 06:27:39 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 94016114B837
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Sep 2010 06:27:38 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Sep 2010 15:27:35 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 21 Sep 2010 15:27:35 +0900
Message-ID: <000101cb5956$14a99a30$3dfcce90$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] [PATCH] fix "sysctl03" test
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

I noticed that "sysctl03" failed from about August 17.
"PASS" is indicated in the log file of "runltp -l", but "TFAIL" is 
indicated in console log:

------------(runltp -l)
sysctl03                       PASS       0
------------

------------(console log)
sysctl03    1  TPASS  :  Got expected error: TEST_ERRNO=EPERM(1): Operation
not permitted
sysctl03    2  TFAIL  :  Got expected error: TEST_ERRNO=EPERM(1): Operation
not permitted
sysctl03    1  TPASS  :  Got expected error: TEST_ERRNO=EPERM(1): Operation
not permitted
------------

"sysctl03" changed in following revision:
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=commit;h=b
49b375167eade5cb2f05678bc60fc5b2d231af9

This revision patch is as followings:
------------
@@ -114,13 +139,10 @@ int main(int ac, char **av)
 		} else {
 			TEST_ERROR_LOG(TEST_ERRNO);
 
-			if (TEST_ERRNO != EPERM) {
-				tst_resm(TFAIL,
-					 "Expected EPERM (%d), got %d: %s",
-					 EPERM, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+			if (TEST_ERRNO == exp_eno) {
+				tst_resm(TPASS|TTERRNO, "Got expected
error");
 			} else {
-				tst_resm(TPASS, "Got expected EPERM error");
+				tst_resm(TFAIL|TTERRNO, "Got unexpected
error");
 			}
 		}
 
@@ -147,12 +169,12 @@ int main(int ac, char **av)
 			} else {
 				TEST_ERROR_LOG(TEST_ERRNO);
 
-				if (TEST_ERRNO != EPERM) {
-					tst_resm(TFAIL, "Expected EPERM, got
"
-						 "%d", TEST_ERRNO);
+				if (TEST_ERRNO == exp_eno) {
+					tst_resm(TFAIL|TTERRNO,   -------->
This will be "TPASS".
+						"Got expected error");
 				} else {
-					tst_resm(TPASS, "Got expected EPERM
"
-						 "error");
+					tst_resm(TPASS|TTERRNO,   -------->
This will be "TFAIL".
+						"Got unexpected error");
 				}
 			}
------------

I suggest to change "TFAIL" <-> "TPASS" in above revision.

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
============
--- a/testcases/kernel/syscalls/sysctl/sysctl03.c	2010-09-11
01:05:02.000000000 +0900
+++ b/testcases/kernel/syscalls/sysctl/sysctl03.c	2010-09-14
17:52:12.000000000 +0900
@@ -170,10 +170,10 @@
 				TEST_ERROR_LOG(TEST_ERRNO);
 
 				if (TEST_ERRNO == exp_eno) {
-					tst_resm(TFAIL|TTERRNO,
+					tst_resm(TPASS|TTERRNO,
 						"Got expected error");
 				} else {
-					tst_resm(TPASS|TTERRNO,
+					tst_resm(TFAIL|TTERRNO,
 						"Got unexpected error");
 				}
 			}
============


Thanks--

-Tomonori Mitani



------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
