Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cebbert.lkml@gmail.com>) id 1XX7hE-0001T1-Ar
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 11:58:52 +0000
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XX7hD-00086o-43
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 11:58:52 +0000
Received: by mail-ob0-f174.google.com with SMTP id m8so7964161obr.19
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Sep 2014 04:58:43 -0700 (PDT)
Date: Thu, 25 Sep 2014 06:58:38 -0500
From: Chuck Ebbert <cebbert.lkml@gmail.com>
Message-ID: <20140925065838.7faf7cef@as>
MIME-Version: 1.0
Subject: [LTP] [PATCH V2] recvfrom01: Fix invalid flags in testcase 4
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

The recv testcases had reported failures on 3.17-rc. [1]

Three of those failures were invalid assumptions about kernel behavior
with every possible flag set. [2]

The fourth failure is because recfrom01 testcase 4 has invalid message
flags in addition to its invalid address length, making it equivalent
to test 6 (because the flags get checked  first).

Remove the invalid flags, and change the text so it's more clear what
is being tested.

Also fix indentation that made it harder to spot this bug.

Version 2: Add better text and remove an erroneous change to the
buffer length spotted by Jan Stancek.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1145325
[2] http://marc.info/?t=141148149900006&r=1&w=2

Signed-off-by: Chuck Ebbert <cebbert.lkml@gmail.com>

--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -105,9 +105,9 @@
 		    0, ENOTSOCK, setup1, cleanup1, "invalid socket buffer"},
 /* 4 */
 	{
-	PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), -1,
+	PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), 0,
 		    (struct sockaddr *)&from, &fromlen,
-		    -1, EINVAL, setup2, cleanup1, "invalid socket length"},
+		    -1, EINVAL, setup2, cleanup1, "invalid socket addr length"},
 /* 5 */
 	{
 	PF_INET, SOCK_STREAM, 0, (void *)-1, sizeof(buf), 0,
@@ -115,7 +115,7 @@
 		    -1, EFAULT, setup1, cleanup1, "invalid recv buffer"},
 /* 6 */
 	{
-PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), -1,
+	PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), -1,
 		    (struct sockaddr *)&from, &fromlen,
 		    -1, EINVAL, setup1, cleanup1, "invalid flags set"},};
 

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
