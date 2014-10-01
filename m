Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cebbert.lkml@gmail.com>) id 1XZS6b-0005wA-TJ
	for ltp-list@lists.sourceforge.net; Wed, 01 Oct 2014 22:10:41 +0000
Received: from mail-ob0-f170.google.com ([209.85.214.170])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XZS6b-0003fQ-1E
	for ltp-list@lists.sourceforge.net; Wed, 01 Oct 2014 22:10:41 +0000
Received: by mail-ob0-f170.google.com with SMTP id uz6so1204862obc.1
	for <ltp-list@lists.sourceforge.net>;
	Wed, 01 Oct 2014 15:10:35 -0700 (PDT)
Received: from as ([159.118.19.211])
	by mx.google.com with ESMTPSA id f8sm1234802oev.4.2014.10.01.15.10.34
	for <ltp-list@lists.sourceforge.net>
	(version=SSLv3 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 01 Oct 2014 15:10:35 -0700 (PDT)
Date: Wed, 1 Oct 2014 17:10:32 -0500
From: Chuck Ebbert <cebbert.lkml@gmail.com>
Message-ID: <20141001171032.698f1356@as>
MIME-Version: 1.0
Subject: [LTP] recvfrom01: fix test for invalid message flags
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
or combinations of flags.) [1] So the current method of setting every
possible flag and checking for a specific error is not valid.

Before kernel 3.17 we were effectively just testing having the MSG_OOB
flag set with no out-of-band data available. With 3.17 and later we
were testing having MSG_ERRQUEUE set with no error data available,
which returns a different error (and causes the existing test to fail).

Replace the bogus test for invalid flags with two new tests that check
return codes for invalid MSG_OOB and MSG_ERRQUEUE flags.

Note that this introduces a failure on kernels before 3.17, which has
a bug fix for MSG_ERRQUEUE flag handling. This failure is a legitimate
bug on these older kernels. (They should not be returning success with
no data available.)

[1] http://marc.info/?t=141148149900006&r=1&w=2

---

Additional test cases for invalid flags could be added after these two.
And the recv01 and recvmsg01 tests need still need to be fixed, assuming
this is the right solution.

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
