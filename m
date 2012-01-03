Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri0md-0006DN-74
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:35:51 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri0ma-0000tG-NF
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:35:51 +0000
Message-ID: <4F02CBDE.70400@imgtec.com>
Date: Tue, 3 Jan 2012 09:35:26 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030801070400010100090300"
Subject: [LTP] [PATCH 02/21] lib/self_exec: Remove extra argument from
 tst_resm function call
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--------------030801070400010100090300
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------030801070400010100090300
Content-Type: text/plain;
	name="0002-lib-self_exec-Remove-extra-argument-from-tst_resm-fu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-lib-self_exec-Remove-extra-argument-from-tst_resm-fu.pa";
	filename*1="tch"

From 84228a0a49b1d2bbb256f71bd532ef3572b88b3a Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 10:43:19 +0000
Subject: [PATCH 02/21] lib/self_exec: Remove extra argument from tst_resm function call

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 lib/self_exec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/self_exec.c b/lib/self_exec.c
index a457468..c918e70 100644
--- a/lib/self_exec.c
+++ b/lib/self_exec.c
@@ -86,7 +86,7 @@ maybe_run_child(void (*child)(), char *fmt, ...)
 
 	child_dir = strtok(args, ",");
 	if (strlen(child_dir) == 0) {
-	    tst_resm(TBROK, NULL, "Could not get directory from -C option");
+	    tst_resm(TBROK, "Could not get directory from -C option");
 	    tst_exit();
 	}
 
-- 
1.7.1


--------------030801070400010100090300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------030801070400010100090300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030801070400010100090300--


