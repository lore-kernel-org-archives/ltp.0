Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cebbert.lkml@gmail.com>) id 1XX42X-00080j-Ty
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 08:04:37 +0000
Received: from mail-oi0-f46.google.com ([209.85.218.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XX42W-0008UG-TI
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 08:04:37 +0000
Received: by mail-oi0-f46.google.com with SMTP id x69so1435513oia.5
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Sep 2014 01:04:31 -0700 (PDT)
Date: Thu, 25 Sep 2014 03:04:26 -0500
From: Chuck Ebbert <cebbert.lkml@gmail.com>
Message-ID: <20140925030426.6cb63a6b@as>
MIME-Version: 1.0
Subject: [LTP] [PATCH] recvfrom01: Fix broken "invalid flags" test
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

The recv tests were making invalid assumptions about how flags are
checked by the kernel. (It makes no explicit tests for invalid flags
or combinations of flags.) [1]

Replace the bogus test for invalid flags with two new tests that check
return codes for invalid MSG_OOB and MSG_ERRQUEUE flags.

Note that this introduces a failure on kernels before 3.17, which has
a bug fix for MSG_ERRQUEUE flag handling. This failure is a legitimate
bug on these older kernels.

Additional test cases for invalid flags could be added after these two.
And the recv01 and recvmsg01 tests need still need to be fixed, assuming
this is the right solution.

[Patch is on top of "Fix wrong args in recvfrom syscall testcase"
 patch I sent yesterday.]

[1] http://marc.info/?t=141148149900006&r=1&w=2

--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -115,9 +115,14 @@
 		    -1, EFAULT, setup1, cleanup1, "invalid recv buffer"},
 /* 6 */
 	{
-	PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), -1,
+	PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), MSG_OOB,
 		    (struct sockaddr *)&from, &fromlen,
-		    -1, EINVAL, setup1, cleanup1, "invalid flags set"},};
+		    -1, EINVAL, setup1, cleanup1, "invalid MSG_OOB flag set"},
+/* 7 */
+	{
+	PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), MSG_ERRQUEUE,
+		    (struct sockaddr *)&from, &fromlen,
+		    -1, EAGAIN, setup1, cleanup1, "invalid MSG_ERRQUEUE flag set"},};
 
 int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
 

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
