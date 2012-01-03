Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri4Mi-0006GH-W4
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:25:20 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri4Md-0003Xs-Mw
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:25:20 +0000
Message-ID: <4F0301B5.7090006@imgtec.com>
Date: Tue, 3 Jan 2012 13:25:09 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090205080004000306060206"
Subject: [LTP] [PATCH 20/21] nfs/nfsstress/make_tree: Replace integer cast
 to pointer with 0
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

--------------090205080004000306060206
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------090205080004000306060206
Content-Type: text/plain;
	name="0020-nfs-nfsstress-make_tree-Replace-integer-cast-to-poin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0020-nfs-nfsstress-make_tree-Replace-integer-cast-to-poin.pa";
	filename*1="tch"

From ff5db5fee1bff9a29aca9cdeaf5fbe00b806d4ea Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 15:18:25 +0000
Subject: [PATCH 20/21] nfs/nfsstress/make_tree: Replace integer cast to pointer with 0

Because pointers are 64-bit on x86_64 architectures, casting a pointer to
integer makes the compiler complain about casting pointer to integer of
different size. We can easily fix this warning by simple replace (int)NULL with
0.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/network/nfs/nfsstress/make_tree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfsstress/make_tree.c b/testcases/network/nfs/nfsstress/make_tree.c
index c51e75e..c0b4d22 100644
--- a/testcases/network/nfs/nfsstress/make_tree.c
+++ b/testcases/network/nfs/nfsstress/make_tree.c
@@ -771,7 +771,7 @@ main(int	argc,		/* number of input parameters		      */
         switch(c)
         {
             case 'd':		/* specify how deep the tree needs to grow    */
-	        if ((num_dirs = atoi(optarg)) == (int)NULL)
+	        if ((num_dirs = atoi(optarg)) == 0)
 		    OPT_MISSING(argv[0], optopt);
                 else
                 if (num_dirs < 0)
@@ -782,7 +782,7 @@ main(int	argc,		/* number of input parameters		      */
                 }
 		break;
             case 'f':		/* how many ".c" files in each directory.     */
-		if ((num_files = atoi(optarg)) == (int)NULL)
+		if ((num_files = atoi(optarg)) == 0)
                     OPT_MISSING(argv[0], optopt);
                 else
 	        if (num_files < 0)
@@ -796,7 +796,7 @@ main(int	argc,		/* number of input parameters		      */
                 usage(argv[0]);
                 break;
             case 't':
-		if ((num_thrd = atoi(optarg)) == (int)NULL)
+		if ((num_thrd = atoi(optarg)) == 0)
 	            OPT_MISSING(argv[0], optopt);
                 else
                 if (num_thrd < 0)
-- 
1.7.1


--------------090205080004000306060206
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
--------------090205080004000306060206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090205080004000306060206--


