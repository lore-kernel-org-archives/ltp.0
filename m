Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1W5VGI-00053O-70
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 06:56:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W5VGG-0007Ed-FI
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 06:56:38 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0L6uRie025493
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jan 2014 14:56:27 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 21 Jan 2014 14:55:17 +0800
Message-Id: <1390287317-18512-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] lib/tst_mkfs.c: fix a bug when calling tst_mkfs()
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

When we used tst_mkfs() to build a file system with extra mkfs options, like that:
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

   Here we use system(3) to avoid this problem. We only pass the command string
to system(3), avoid parsing extra mkfs options and assigning them to argv array ourselvs.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 lib/tst_mkfs.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index bacf976..c6e90ba 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -21,14 +21,17 @@
 void tst_mkfs(void (cleanup_fn)(void), const char *dev,
               const char *fs_type, const char *fs_opts)
 {
+	int ret;
+	void *old_handler;
+	char command[BUFSIZ];
+
 	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
 	        dev, fs_type, fs_opts ? fs_opts : "");
 
 	if (!fs_type)
 		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
 
-	const char *argv[] = {"mkfs", "-t", fs_type, NULL, NULL, NULL, NULL};
-	int pos = 3;
+	ret = sprintf(command, "mkfs -t %s", fs_type);
 
 	/*
 	 * The mkfs.xfs aborts if it finds a filesystem superblock
@@ -37,13 +40,21 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 	 */
 	if (!strcmp(fs_type, "xfs")) {
 		tst_resm(TINFO, "Appending '-f' force flag to mkfs.xfs");
-		argv[pos++] = "-f";
+		ret += sprintf(command + ret, " -f");
 	}
 
 	if (fs_opts)
-		argv[pos++] = fs_opts;
+		ret += sprintf(command + ret, " %s", fs_opts);
+
+	ret += sprintf(command + ret, " %s", dev);
+	/* we ignore stdout, keep stderr */
+	ret += sprintf(command + ret, " > /dev/null");
+
+	old_handler = signal(SIGCHLD, SIG_DFL);
 
-	argv[pos] = dev;
+	ret = system(command);
+	if (ret)
+		tst_brkm(TBROK, cleanup_fn, "failed to exec cmd '%s'", command);
 
-	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL);
+	signal(SIGCHLD, old_handler);
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
