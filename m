Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri0it-00063m-98
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:31:59 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri0ir-0000go-0W
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:31:59 +0000
Message-ID: <4F02C765.5030408@imgtec.com>
Date: Tue, 3 Jan 2012 09:16:21 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090703040806060303030008"
Subject: [LTP] [PATCH 01/21] lib/parse_opts: STD_LP_sbrk and STD_start_break
 should only be defined when UCLINUX=0
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

--------------090703040806060303030008
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Please review the attached patch.

-- 
markos

--------------090703040806060303030008
Content-Type: text/plain;
	name="0001-lib-parse_opts-STD_LP_sbrk-and-STD_start_break-shoul.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-lib-parse_opts-STD_LP_sbrk-and-STD_start_break-shoul.pa";
	filename*1="tch"

From 73d72d74229c0598b2e1d5e070418c5855159373 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 10:36:35 +0000
Subject: [PATCH 01/21] lib/parse_opts: STD_LP_sbrk and STD_start_break should only be defined when UCLINUX=0

These variables are only used when the UCLINUX macro is not defined therefore it
is better to declare them conditionally.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 lib/parse_opts.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index 358106e..8a235b1 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -139,8 +139,10 @@ static int  STD_LP_shmem=0; 	/* flag to do shmem_puts and gets during TEST_LOOPI
 static int  STD_LD_recfun=0;	/* do recressive function calls in loop delay */
 static int  STD_LP_recfun=0;	/* do recressive function calls in TEST_LOOPING */
 static int  STD_TP_sbrk=0;	/* do sbrk in TEST_PAUSE */
+#ifndef UCLINUX
 static int  STD_LP_sbrk=0;	/* do sbrk in TEST_LOOPING */
 static char *STD_start_break=0; /* original sbrk size */
+#endif
 static int  Debug=0;
 
 struct std_option_t {
-- 
1.7.1


--------------090703040806060303030008
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
--------------090703040806060303030008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090703040806060303030008--


