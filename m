From: Zorro Lang <zlang@redhat.com>
Date: Tue,  8 Mar 2016 21:35:33 +0800
Subject: [LTP] [PATCH 2/2] mmap16: fix ETIMEDOUT error if test device is too
	large
In-Reply-To: <1457444133-5671-1-git-send-email-zlang@redhat.com>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
Message-ID: <1457444133-5671-2-git-send-email-zlang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mmap16 will wait DEFAULT_MSEC_TIMEOUT=10000 msec, for parent
process full the test device(-b $DEVICE). But if the device
size is too large, this case will hit ETIMEDOUT error.

For reproduce the bug of mmap16, it don't need too large device.
So I limit the fs size in 100M.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 testcases/kernel/syscalls/mmap/mmap16.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index c5828ea..f8fbd50 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -143,8 +143,6 @@ static void do_test(void)
 
 static void setup(void)
 {
-	const char *fs_opts[3] = {"-b", "1024", NULL};
-
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	tst_require_root();
 
@@ -158,7 +156,7 @@ static void setup(void)
 	device = tst_acquire_device(cleanup);
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-	tst_mkfs(cleanup, device, fs_type, fs_opts);
+	tst_mkfs(cleanup, device, fs_type, NULL, "100m", "1024");
 
 	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
 	/*
-- 
2.5.0

