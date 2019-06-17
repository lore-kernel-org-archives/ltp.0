From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Jun 2019 17:06:40 +0200
Subject: [LTP] [PATCH v4] syscalls/sync_file_range: add partial file
 sync test-cases
In-Reply-To: <1560161596-30156-1-git-send-email-sumit.garg@linaro.org>
References: <1560161596-30156-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190617150640.GD16831@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with following modifications, thanks.

With these modification the test was stable and worked fine for more
than 100 iterations for me. It still fails for FUSE based filesystems
but that is to be expected since FUSE does not implement sync_file_range
yet.

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index 9454a560a..d4c29f9c2 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -36,6 +36,7 @@ struct testcase {
 	size_t exp_sync_size;
 	off64_t write_off;
 	size_t write_size_mb;
+	const char *desc;
 };
 
 static void verify_sync_file_range(struct testcase *tc)
@@ -61,20 +62,34 @@ static void verify_sync_file_range(struct testcase *tc)
 
 	written = tst_dev_bytes_written(tst_device->dev);
 
+	fsync(fd);
+

> Let's make sure there are no outstanding writes schedulled, fixes
> running the test with -i 10

 	SAFE_CLOSE(fd);
 
 	if ((written >= tc->exp_sync_size) &&
 	    (written <= (tc->exp_sync_size + tc->exp_sync_size/10)))
-		tst_res(TPASS, "Test file range synced to device");
+		tst_res(TPASS, "%s", tc->desc);
 	else
-		tst_res(TFAIL, "Synced %li, expected %li", written,
-			tc->exp_sync_size);
+		tst_res(TFAIL, "%s: Synced %li, expected %li", tc->desc,
+		        written, tc->exp_sync_size);
 }

 static struct testcase testcases[] = {
-	{ FNAME1, 0, FILE_SZ, FILE_SZ, 0, FILE_SZ_MB },
-	{ FNAME2, FILE_SZ/4, FILE_SZ/2, FILE_SZ/2, 0, FILE_SZ_MB },
-	{ FNAME3, FILE_SZ/4, FILE_SZ/2, FILE_SZ/4, FILE_SZ/2, FILE_SZ_MB/4 },
+	{FNAME1,
+	 0, FILE_SZ,
+	 FILE_SZ,
+	 0, FILE_SZ_MB,
+	 "Sync equals write"},
+	{FNAME2,
+	 FILE_SZ/4, FILE_SZ/2,
+	 FILE_SZ/2,
+	 0, FILE_SZ_MB,
+	 "Sync inside of write"},
+	{FNAME3,
+	 FILE_SZ/4, FILE_SZ/2,
+	 FILE_SZ/4,
+	 FILE_SZ/2, FILE_SZ_MB/4,
+	 "Sync overlaps with write"},
 };

> This simply adds test description so that it's clear which subtest
> failed.
 
 static void run(unsigned int i)
@@ -87,10 +102,17 @@ static void setup(void)
 	if (!check_sync_file_range())
 		tst_brk(TCONF, "sync_file_range() not supported");
 
+	/*
+	 * Fat does not support sparse files, we have to pre-fill the file so
+	 * that the zero-filled start of the file has been written to disk
+	 * before the test starts.
+	 */
 	if (!strcmp(tst_device->fs_type, "vfat")) {
 		tst_res(TINFO, "Pre-filling file");
 		tst_fill_file(FNAME3, 0, TST_MB, FILE_SZ_MB);
-		sync();
+		int fd = SAFE_OPEN(FNAME3, O_RDONLY);
+		fsync(fd);
+		SAFE_CLOSE(fd);
 	}

> Strangely doing sync(); here failed for me, that may be actually a
> kernel bug however there is no need for using the big hammer and sync
> everything in the system anyways.

 }

-- 
Cyril Hrubis
chrubis@suse.cz
