Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WSk5j-0001Al-MJ
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 09:25:47 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WSk5i-0007N4-JE
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 09:25:47 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2Q9Pb8p029545
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 17:25:37 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 26 Mar 2014 17:23:45 +0800
Message-Id: <1395825825-22165-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2] lib/tst_mkfs.c: fix a bug when calling tst_mkfs()
	with extra mkfs options
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

When we use tst_mkfs() to build a file system with extra mkfs options, like that:
    tst_mkfs(NULL, device, "ext4", "-b 1024"); /* device is /dev/loop0 */

It will output some error message, like that:
    TINFO  :  Formatting /dev/loop0 with ext4 extra opts='-b 1024'
    mke2fs 1.42.7 (21-Jan-2013)
    mkfs.ext4: invalid blocks '/dev/loop0' on device 'ext4'

In tst_mkfs()'s implementations:
   argv is defined as below statments:
       const char *argv[] = {"mkfs", "-t", fs_type, NULL, NULL, NULL, NULL};
   So in the above mkfs case,
       the argv's value will be {"mkfs", "-t", "ext4", "-b 1024", "/dev/loop0", NULL};
   then when finally calling execvp(argv[0], (char *const *)argv), the number of
arguments is 5. It's like that we call (mkfs -t ext4 "-b 1024" /dev/loop0) in shell,
but the right command shoule be (mkfs -t ext4 -b 1024 /dev/loop0 # 6 args).
Of course, the true reason is that we didn't assign correct arguments to argv array
towards extra mkfs options.

With this patch, if user wants to pass extra mkfs options, he should do like below:
	const char *const opts[] = { "-b", "1024", NULL };
	tst_mkfs(NULL, device, "ext4", opts);

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h |  2 +-
 lib/tst_mkfs.c | 26 +++++++++++++++++---------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/test.h b/include/test.h
index 32b9680..cf00e63 100644
--- a/include/test.h
+++ b/include/test.h
@@ -269,7 +269,7 @@ void tst_run_cmd(void (cleanup_fn)(void),
  * @fs_opts: extra mkfs options
  */
 void tst_mkfs(void (cleanup_fn)(void), const char *dev,
-              const char *fs_type, const char *fs_opts);
+	      const char *fs_type, const char *const fs_opts[]);
 
 /* lib/tst_fill_file.c
  *
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index cee04dd..46483e7 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -19,17 +19,17 @@
 #include "test.h"
 
 void tst_mkfs(void (cleanup_fn)(void), const char *dev,
-              const char *fs_type, const char *fs_opts)
+	      const char *fs_type, const char *const fs_opts[])
 {
-	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
-	        dev, fs_type, fs_opts ? fs_opts : "");
+	int i, pos = 3;
+
+	/* here I think 1024 is enough for argv and fs_opts_str. */
+	const char *argv[1024] = {"mkfs", "-t", fs_type};
+	char fs_opts_str[1024] = "";
 
 	if (!fs_type)
 		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
 
-	const char *argv[] = {"mkfs", "-t", fs_type, NULL, NULL, NULL, NULL};
-	int pos = 3;
-
 	/*
 	 * mkfs.xfs and mkfs.btrfs aborts if it finds a filesystem
 	 * superblock on the device, which is the case here as we
@@ -40,10 +40,18 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 		argv[pos++] = "-f";
 	}
 
-	if (fs_opts)
-		argv[pos++] = fs_opts;
+	if (fs_opts) {
+		for (i = 0; fs_opts[i]; i++) {
+			argv[pos++] = fs_opts[i];
+			strcat(fs_opts_str, " ");
+			strcat(fs_opts_str, fs_opts[i]);
+		}
+	}
 
-	argv[pos] = dev;
+	argv[pos++] = dev;
+	argv[pos] = NULL;
 
+	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
+		 dev, fs_type, fs_opts ? fs_opts_str : "");
 	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL);
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
