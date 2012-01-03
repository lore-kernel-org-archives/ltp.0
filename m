Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri2Ai-0005Od-C8
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:04:48 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri2Ah-00057G-K2
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:04:48 +0000
Message-ID: <4F02E0C6.3090308@imgtec.com>
Date: Tue, 3 Jan 2012 11:04:38 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010408060507080105070709"
Subject: [LTP] [PATCH 08/21] syscalls/remap_file_pages: unsigned int is
 always greater to zero
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

--------------010408060507080105070709
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------010408060507080105070709
Content-Type: text/plain;
	name="0008-syscalls-remap_file_pages-unsigned-int-is-always-gre.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0008-syscalls-remap_file_pages-unsigned-int-is-always-gre.pa";
	filename*1="tch"

From 91f35a787627ef3bfb77dd0f0dc5e8993016b0b5 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 13:05:58 +0000
Subject: [PATCH 08/21] syscalls/remap_file_pages: unsigned int is always greater to zero

getpagesize() returns an integer value ( which can be negative in case of
an error ). However, when a negative value is assigned to unsigned int, the
result is a much greater integer (2's complement), therefore the expression
page_sz > 0 is always true. A getpagesize() error won't be noticed in this case

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 .../syscalls/remap_file_pages/remap_file_pages01.c |    6 +++---
 .../syscalls/remap_file_pages/remap_file_pages02.c |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
index 01fd291..fa1bdca 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
@@ -231,11 +231,11 @@ void setup()
 	TEST_PAUSE;
 
 	/* Get page size */
-	if ((page_sz = getpagesize()) < 0) {
+	if (getpagesize() < 0) {
 		tst_brkm(TFAIL, cleanup,
 			 "getpagesize() fails to get system page size");
 	}
-
+	page_sz = getpagesize();
 	page_words = (page_sz / sizeof(char));
 
 	/* Set the cache size */
@@ -287,4 +287,4 @@ void cleanup(char *data)
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
index c30abe8..c70bfe8 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
@@ -281,11 +281,11 @@ void setup()
 	tst_tmpdir();
 
 	/* Get page size */
-	if ((page_sz = getpagesize()) < 0) {
+	if (getpagesize() < 0) {
 		tst_brkm(TFAIL, cleanup,
 			 "getpagesize() fails to get system page size");
 	}
-
+	page_sz = getpagesize();
 	page_words = (page_sz / sizeof(char));
 
 	/* Set the cache size */
-- 
1.7.1


--------------010408060507080105070709
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
--------------010408060507080105070709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010408060507080105070709--


