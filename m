From: Zorro Lang <zlang@redhat.com>
Date: Fri,  4 Mar 2016 21:25:00 +0800
Subject: [LTP] [PATCH] mmap16: fix ETIMEDOUT error if test device too large
Message-ID: <1457097900-12012-1-git-send-email-zlang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mmap16 will wait DEFAULT_MSEC_TIMEOUT=10000 msec, for parent
process full the test device(-b $DEVICE). But if the device
size is too large, the case will hit ETIMEDOUT error.

For reproduce the bug of mmap16, it don't need too large device.
So I limit the fs size in 100M, for save time.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi maintainers,

This's a demo patch for a problem I meet recently. I always hit mmap16
failed as:

mmap16      0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
mmap16      0  TINFO  :  Formatting /dev/loop0 with ext4 extra opts='-b 1024'
mke2fs 1.41.12 (17-May-2010)
mmap16      1  TBROK  :  tst_checkpoint.c:130: mmap16.c:222: tst_checkpoint_wait(0, 10000): errno=ETIMEDOUT(110): Connection timed out
mmap16      2  TBROK  :  tst_checkpoint.c:130: Remaining cases broken
mmap16      1  TBROK  :  tst_checkpoint.c:143: mmap16.c:124: tst_checkpoint_wake(0, 1, 10000): errno=ETIMEDOUT(110): Connection timed out
mmap16      2  TBROK  :  tst_checkpoint.c:143: Remaining cases broken

I think that's due to my test device LTP_DEV='/dev/loop0'. I use a
1G loop device, sometimes mmap16 will failed as above. If I use a
bigger device, it will failed 100%.

I know that's my test device problem. I should choose a suitable device
for mmap16. But on the other side, I think if mmap16 don't need a large
fs, it can limit the fs size when mkfs.

I thought a lot of idea to make "tst_mkfs()" can support a limited fs
size. But it's difficult for ext4, because ext4's "[fs-size]" parameter
must behind "device". So I can't add a "fs-size" into fs_opts[] simply.

For change the tst_mkfs() function, I thought 3 different ways:
1. Add a new parameter "const char *fssize".
2. Add a new parameter "const *char fs_opts2[]", to store options which
need to behind the dev.
3. As below, use an useless character "|" to separate options need to
behind the dev.

Maybe there're some better ways to fix this problem. And maybe there're
some others cases have the same problem? I try to report this problem, and
submit a V1 patch. I have tested this patch, mmap16 can run normally.

Please help to review. I'm glad to hear your suggestions about how to
deal with this better:)

Thanks,
Zorro

 lib/tst_mkfs.c                          | 11 ++++++++---
 testcases/kernel/syscalls/mmap/mmap16.c |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 5f959a4..2948e25 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -27,6 +27,7 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 	int i, pos = 3;
 	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
 	char fs_opts_str[1024] = "";
+	int tailed = 0;
 
 	if (!fs_type)
 		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
@@ -54,7 +55,11 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 
 	if (fs_opts) {
 		for (i = 0; fs_opts[i]; i++) {
-			argv[pos++] = fs_opts[i];
+			if (!strcmp(fs_opts[i], "|")) {
+				argv[pos++] = dev;
+				tailed = 1;
+			} else
+				argv[pos++] = fs_opts[i];
 
 			if (pos + 2 > OPTS_MAX) {
 				tst_brkm(TBROK, cleanup_fn,
@@ -66,8 +71,8 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 			strcat(fs_opts_str, fs_opts[i]);
 		}
 	}
-
-	argv[pos++] = dev;
+	if (tailed == 0)
+		argv[pos++] = dev;
 	argv[pos] = NULL;
 
 	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index c5828ea..66db447 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -143,7 +143,7 @@ static void do_test(void)
 
 static void setup(void)
 {
-	const char *fs_opts[3] = {"-b", "1024", NULL};
+	const char *fs_opts[5] = {"-b", "1024", "|", "102400", NULL};
 
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	tst_require_root();
-- 
2.5.0

