Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris@mips.com>) id 1TO8G5-0003Ai-33
	for ltp-list@lists.sourceforge.net; Tue, 16 Oct 2012 14:36:37 +0000
Received: from dns1.mips.com ([12.201.5.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TO8G4-0007ZK-99
	for ltp-list@lists.sourceforge.net; Tue, 16 Oct 2012 14:36:37 +0000
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q9GEIMpe028038
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Oct 2012 07:18:22 -0700
Received: from exchdb01.mips.com (unknown [192.168.36.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mailgate1.mips.com (Postfix) with ESMTP id 2BA8036465A
	for <ltp-list@lists.sourceforge.net>;
	Tue, 16 Oct 2012 07:18:22 -0700 (PDT)
Message-ID: <507D6CAD.1040209@mips.com>
Date: Tue, 16 Oct 2012 07:18:21 -0700
From: Chris Dearman <chris@mips.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] pipe01 should only check the data actually received
 from the pipe
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
Cc: Chris Dearman <chris@mips.com>

The pipe write does not include the string terminator and the way the
test is written it's valid for the writer to send less than the
requested amount and for the reader to read less than the number of
written bytes, so just compare the actual bytes received.

Signed-off-by: Chris Dearman <chris@mips.com>
---
  testcases/kernel/syscalls/pipe/pipe01.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe01.c 
b/testcases/kernel/syscalls/pipe/pipe01.c
index 08cf612..04d1b11 100644
--- a/testcases/kernel/syscalls/pipe/pipe01.c
+++ b/testcases/kernel/syscalls/pipe/pipe01.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
  			}
   			/* are the strings written and read equal */
-			if ((greater = strcmp(rebuf, wrbuf)) != 0) {
+			if ((greater = strncmp(rebuf, wrbuf, red)) != 0) {
  				tst_resm(TFAIL, "Condition #3 test failed");
  				continue;
  			}
@@ -155,4 +155,4 @@ void cleanup()
  	 * print errno log if that option was specified.
  	 */
  	TEST_CLEANUP;
-}
\ No newline at end of file
+}
-- 
1.7.1


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
