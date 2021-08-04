From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Aug 2021 16:05:26 +0200
Subject: [LTP] [PATCH v3] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <20210715050812.1950884-1-lkml@jv-coder.de>
References: <20210715050812.1950884-1-lkml@jv-coder.de>
Message-ID: <YQqepmX0gmdpSqn5@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

Apart from removing the needs_tmpdir I've also changed the TPASS message
to something more meaningful and move the TINFO message to setup so that
it's not printed on each iteration.

Full diff:

diff --git a/testcases/kernel/fs/squashfs/squashfs01.c b/testcases/kernel/fs/squashfs/squashfs01.c
index f02c91f83..502de419d 100644
--- a/testcases/kernel/fs/squashfs/squashfs01.c
+++ b/testcases/kernel/fs/squashfs/squashfs01.c
@@ -51,6 +51,8 @@ static void setup(void)
 {
 	int i;
 
+	tst_res(TINFO, "Test squashfs sanity check regressions");
+
 	SAFE_MKDIR(DATA_DIR, 0777);
 
 	for (i = 0; i < 2048; ++i) {
@@ -85,8 +87,6 @@ static void setup(void)
 
 static void run(void)
 {
-	tst_res(TINFO, "Test squashfs sanity check regressions");
-
 	if (mount(tst_device->dev, MOUNT_DIR, "squashfs", 0, NULL) != 0)
 		tst_brk(TFAIL | TERRNO, "Mount failed");
 	mounted = 1;
@@ -94,7 +94,7 @@ static void run(void)
 	SAFE_UMOUNT("mnt");
 	mounted = 0;
 
-	tst_res(TPASS, "Test passed");
+	tst_res(TPASS, "Regression not detected");
 }
 
 static struct tst_test test = {
@@ -117,5 +117,4 @@ static struct tst_test test = {
 		{"linux-git", "8b44ca2b634"},
 		{}
 	},
-	.needs_tmpdir = 1,
 };

-- 
Cyril Hrubis
chrubis@suse.cz
