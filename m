Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri1qj-0004do-9T
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 10:44:09 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri1qi-0000XB-8p
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 10:44:09 +0000
Message-ID: <4F02DBF1.3090402@imgtec.com>
Date: Tue, 3 Jan 2012 10:44:01 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010005050702050905040705"
Subject: [LTP] [PATCH 06/21] syscalls/unshare02: Replace ((int)NULL) with 0
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

--------------010005050702050905040705
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------010005050702050905040705
Content-Type: text/plain;
	name="0006-syscalls-unshare02-Replace-int-NULL-with-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0006-syscalls-unshare02-Replace-int-NULL-with-0.patch"

From 269402e0cf64392442196ecf6c79d35d9e93c1af Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 11:57:17 +0000
Subject: [PATCH 06/21] syscalls/unshare02: Replace ((int)NULL) with 0

On non-32bit arches, casting a pointer to integer throws a compiler warning
because integers and pointers have different sizes in these arches. Therefore,
we replace the (int)NULL cast with 0 which has the same effect.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/syscalls/unshare/unshare02.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare02.c b/testcases/kernel/syscalls/unshare/unshare02.c
index 9f7b436..1a93932 100644
--- a/testcases/kernel/syscalls/unshare/unshare02.c
+++ b/testcases/kernel/syscalls/unshare/unshare02.c
@@ -181,7 +181,7 @@ int main(int ac, char **av) {
 				tst_brkm(TFAIL|TTERRNO, cleanup,
 					"fork() failed.");
 			} else if (TEST_RETURN == 0) {
-				TEST_RETURN = unshare((int)NULL);
+				TEST_RETURN = unshare(0);
 				if (TEST_RETURN == 0) {
 					tst_resm(TPASS, "Call succeeded");
 					rval = 0;
-- 
1.7.1


--------------010005050702050905040705
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
--------------010005050702050905040705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010005050702050905040705--


