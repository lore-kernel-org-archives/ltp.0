Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Wa1ec-0006tv-3X
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 11:35:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wa1ea-00039S-Ai
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 11:35:54 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3FBZIvx018413
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Apr 2014 19:35:18 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 15 Apr 2014 19:33:21 +0800
Message-ID: <1397561602-18935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] runltp: fix errors when using getenv(3) to get
	environment variable LTP_BIG_DEV or LTP_BIG_DEV_FS_TYPE
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

Make runltp export LTP_BIG_DEV and LTP_BIG_DEV_FS_TYPE only when they have a non-zero
value. We do this to make getenv("LTP_BIG_DEV") or getenv("LTP_BIG_DEV_FS_TYPE")
return NULL, if user does not specify a big block device. Because users usually write
such code:
	device = getenv("LTP_BIG_DEV");
	if (device == NULL) {
		tst_brkm(TCONF, NULL,
			 "you must specify a big blockdevice(>1.2G)");
	} else {
		tst_mkfs(NULL, device, "ext3", NULL);
	}

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runltp | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/runltp b/runltp
index 9cb5fe8..ea328f0 100755
--- a/runltp
+++ b/runltp
@@ -81,9 +81,7 @@ setup()
     export PATH="${PATH}:${LTPROOT}/testcases/bin"
 
     export LTP_DEV=""
-    export LTP_BIG_DEV=""
     export LTP_DEV_FS_TYPE="ext2"
-    export LTP_BIG_DEV_FS_TYPE="ext2"
 
     [ -d "$LTPROOT/testcases/bin" ] ||
     {
@@ -433,7 +431,7 @@ main()
         b) DEVICE=$OPTARG;;
         B) LTP_DEV_FS_TYPE=$OPTARG;;
         z) BIG_DEVICE=$OPTARG;;
-        Z) LTP_BIG_DEV_FS_TYPE=$OPTARG;;
+        Z) BIG_DEVICE_FS_TYPE=$OPTARG;;
         \?) usage;;
         esac
     done
@@ -696,7 +694,12 @@ main()
         echo "Tests which require a big block device are disabled."
         echo "You can specify it with option -z"
     else
-        LTP_BIG_DEV=$BIG_DEVICE
+        export LTP_BIG_DEV=$BIG_DEVICE
+        if [ -z "$BIG_DEVICE_FS_TYPE" ];then
+            export LTP_BIG_DEV_FS_TYPE="ext2"
+        else
+            export LTP_BIG_DEV_FS_TYPE=$BIG_DEVICE_FS_TYPE
+        fi
     fi
 
     if [ $RUN_REPEATED -gt 1 ]; then # You need to specify at least more than 1 sequential run, else it runs default
-- 
1.8.2.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
