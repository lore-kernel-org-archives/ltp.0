Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri4JT-0001pb-8T
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:21:59 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri4JP-000879-CK
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:21:59 +0000
Message-ID: <4F0300EC.7040201@imgtec.com>
Date: Tue, 3 Jan 2012 13:21:48 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000709080208060409010901"
Subject: [LTP] [PATCH 16/21] kernel/vma: Add missing return statement for
 non-void functions
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

--------------000709080208060409010901
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------000709080208060409010901
Content-Type: text/plain;
	name="0016-kernel-vma-Add-missing-return-statement-for-non-void.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0016-kernel-vma-Add-missing-return-statement-for-non-void.pa";
	filename*1="tch"

From b5bec4470a937d9d63b05798d34c0c33c19348d4 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 15:04:50 +0000
Subject: [PATCH 16/21] kernel/vma: Add missing return statement for non-void functions

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/mem/vma/vma01.c |    2 ++
 testcases/kernel/mem/vma/vma02.c |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index 398d7a1..14c0525 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -151,6 +151,8 @@ static void *get_end_addr(void *addr_s, char *mapfile)
 	}
 	fclose(fp);
 	tst_brkm(TBROK, cleanup, "no matched s = %p found.", addr_s);
+
+	return NULL;
 }
 
 static void check_status(int status)
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index a1c8f24..fe7cff6 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -152,6 +152,9 @@ int main(int argc, char** argv)
 			tst_brkm(TWARN|TERRNO, NULL, "munmap");
 	}
 	tst_exit();
+
+	/* We should never be here */
+	return 0;
 }
 
 void usage(void)
@@ -166,5 +169,7 @@ int main(void) {
 #else /* no NUMA */
 int main(void) {
 	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+	/* We should never be here */
+	return 0;
 }
 #endif
-- 
1.7.1


--------------000709080208060409010901
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
--------------000709080208060409010901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000709080208060409010901--


