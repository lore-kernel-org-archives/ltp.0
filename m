Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri2GS-0005dd-Is
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:10:44 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri2GR-0005Mz-Q0
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:10:44 +0000
Message-ID: <4F02E22D.3020802@imgtec.com>
Date: Tue, 3 Jan 2012 11:10:37 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070408000209000009070509"
Subject: [LTP] [PATCH 10/21] lib/parse_opts: Multiple fixes
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

--------------070408000209000009070509
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------070408000209000009070509
Content-Type: text/plain; name="0010-lib-parse_opts-Multiple-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0010-lib-parse_opts-Multiple-fixes.patch"

From a1e992a25a19b7465c7a16dc317e10a104495b41 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Mon, 21 Nov 2011 16:24:00 +0000
Subject: [PATCH 10/21] lib/parse_opts: Multiple fixes

- Fix TEST_RETURN definition
- drop undefined TIMING option
- Add missing argument for parse_opts when UNIT_TEST marco is used

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 lib/parse_opts.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index 8a235b1..aa2433f 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -834,14 +834,13 @@ char *ptr;
 
 struct usc_errno_t TEST_VALID_ENO[USC_MAX_ERRNO];
 
-int TEST_RETURN;
+long TEST_RETURN;
 int TEST_ERRNO;
 
 /* for test specific parse_opts options */
 option_t Options[] = {
         { "help",  &Help2, NULL },      /* -help option */
         { "h",  &Help, NULL },          /* -h option */
- 	{ TIMING, NULL, NULL},		/* disable -timing option */
 
 #if INVALID_TEST_CASES
  	{ "missingflag", NULL, &ptr },  /* error */
@@ -858,7 +857,7 @@ int main(int argc, char **argv)
     struct timeval t;
     int cnt;
 
-    if ((msg = parse_opts(argc, argv, Options)) != NULL) {
+    if ((msg = parse_opts(argc, argv, Options, NULL)) != NULL) {
 	printf("ERROR: %s\n", msg);
 	exit(1);
     }
-- 
1.7.1


--------------070408000209000009070509
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
--------------070408000209000009070509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070408000209000009070509--


