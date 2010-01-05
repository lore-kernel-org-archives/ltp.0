Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NS4ok-0004FZ-9k
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 08:31:06 +0000
Received: from out02.sjc.mx.trendmicro.com ([216.99.131.6])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NS4oi-000762-SL
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 08:31:06 +0000
Received: from relay04.sjc.mx.trendmicro.com (unknown [10.30.239.5])
	by out02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 9F59958C52A
	for <ltp-list@lists.sourceforge.net>;
	Tue,  5 Jan 2010 08:30:55 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay04.sjc.mx.trendmicro.com (Postfix) with ESMTP id F11241D7834
	for <ltp-list@lists.sourceforge.net>;
	Tue,  5 Jan 2010 08:30:54 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 17:30:53 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 5 Jan 2010 17:30:52 +0900
Message-ID: <000601ca8de1$64d04810$2e70d830$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] quotactl01 testcases problem
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

I tried "quotactl01" testcases, and found two problems.
Second one occurred after first one's revise.

1) In the result of "quotactl01", "Success" are displayed in spite of
   failing in the test:

------------
quotactl01    1  TFAIL  :  cmd=0x800002: TEST_ERRNO=???(0): Success
quotactl01    2  TFAIL  :  cmd=0x800003: TEST_ERRNO=???(0): Success
quotactl01    3  TFAIL  :  cmd=0x800007: TEST_ERRNO=???(0): Success
quotactl01    4  TFAIL  :  cmd=0x800008: TEST_ERRNO=???(0): Success
quotactl01    5  TFAIL  :  cmd=0x800005: TEST_ERRNO=???(0): Success
quotactl01    6  TFAIL  :  cmd=0x800006: TEST_ERRNO=???(0): Success
quotactl01    7  TFAIL  :  cmd=0x800004: TEST_ERRNO=???(0): Success
quotactl01    8  TFAIL  :  cmd=0x800001: TEST_ERRNO=???(0): Success
------------

This problem occurred because the return value of system-call 
"(syscall(__NR_quotactl, cmd[i], ...))" is not judged correctly 
in "${LTPROOT}/testcases/kernel/syscalls/quotactl/quotactl01.c".
Above errors are caused by TFAIL and messages are printed by TTERRNO.
And there is only one place (Line 206) which uses TFAIL in "quotactl01.c"

The following patch can fix this problem:

============
--- quotactl01.c	2009-12-20 09:36:35.000000000 +0900
+++ quotactl01.c.new	2010-01-04 17:11:17.000000000 +0900
@@ -177,7 +177,6 @@
 	int id = getuid();
 	int newtid = -1;
 	int result;
-	int ret;
 	int i;
 	int lc;				 /* loop counter */
 	char *msg;			  /* message returned from
parse_opts */
@@ -199,10 +198,10 @@
 
 			for (i = 0; i <= 7; i++){
 
-				ret = syscall(__NR_quotactl, cmd[i],
+				TEST(syscall(__NR_quotactl, cmd[i],
 						(const char *)NULL, id,
-						(caddr_t)NULL);
-				if (ret != 0) {
+						(caddr_t)NULL));
+				if (TEST_RETURN != 0) {
 					tst_resm(TFAIL|TTERRNO, "cmd=0x%x",
cmd[i]);
 				} else {
 					tst_resm(TPASS, "quotactl call
succeeded");
============


However, new problem occurred after applying above patch.

2) The test failed with the following error in my system:

------------
quotactl01    1  TFAIL  :  cmd=0x800002: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    2  TFAIL  :  cmd=0x800003: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    3  TFAIL  :  cmd=0x800007: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    4  TFAIL  :  cmd=0x800008: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    5  TFAIL  :  cmd=0x800005: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    6  TFAIL  :  cmd=0x800006: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    7  TFAIL  :  cmd=0x800004: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    8  TFAIL  :  cmd=0x800001: TEST_ERRNO=EFAULT(14): Bad address
------------

"EFAULT" means that there is an error in "addr".
The format of "quotactl" is following:
------------
int quotactl(int cmd, const char *special, int id, caddr_t addr);
------------

Therefore, "EFAULT" means that 4th argument of "quotactl()" has problem.

In "${LTPROOT}/testcases/kernel/syscalls/quotactl/quotactl01.c", 4th 
argument of "quotactl()" is "NULL":
Is it right?


I'm glad if I get your help.


Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
