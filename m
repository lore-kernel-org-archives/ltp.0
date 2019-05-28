From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 28 May 2019 22:12:13 +0800
Subject: [LTP] [PATCH v6 3/4] syscalls/swapon/swapon0{1..3}: use helper to
	check support status
In-Reply-To: <20190528141214.18752-1-xzhou@redhat.com>
References: <CAOQ4uxihom9Uw66c0BwuiWHOejZXDJHUe3rHBVRfk0=C-AYnAw@mail.gmail.com>
 <20190528141214.18752-1-xzhou@redhat.com>
Message-ID: <20190528141214.18752-3-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Of swap operations.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/swapon/swapon01.c | 11 ++---------
 testcases/kernel/syscalls/swapon/swapon02.c | 13 +++----------
 testcases/kernel/syscalls/swapon/swapon03.c | 15 ++++-----------
 3 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 32538f82b..f95ce0ab2 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -84,16 +84,9 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
-	make_swapfile(cleanup, "swapfile01");
+	make_swapfile(cleanup, "swapfile01", 0);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 4af5105c6..3d49d0c6b 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -132,18 +132,11 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
 	SAFE_TOUCH(cleanup, "notswap", 0777, NULL);
-	make_swapfile(cleanup, "swapfile01");
-	make_swapfile(cleanup, "alreadyused");
+	make_swapfile(cleanup, "swapfile01", 0);
+	make_swapfile(cleanup, "alreadyused", 0);
 
 	if (ltp_syscall(__NR_swapon, "alreadyused", 0)) {
 		if (fs_type != TST_BTRFS_MAGIC || errno != EINVAL)
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 955ac247b..cef57150c 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -153,7 +153,7 @@ static int setup_swap(void)
 	int j, fd;
 	int status;
 	int res = 0;
-	char filename[15];
+	char filename[FILENAME_MAX];
 	char buf[BUFSIZ + 1];
 
 	/* Find out how many swapfiles (1 line per entry) already exist */
@@ -210,7 +210,7 @@ static int setup_swap(void)
 			}
 
 			/* Create the swapfile */
-			make_swapfile(cleanup, filename);
+			make_swapfile(cleanup, filename, 0);
 
 			/* turn on the swap file */
 			res = ltp_syscall(__NR_swapon, filename, 0);
@@ -246,7 +246,7 @@ static int setup_swap(void)
 
 	/* Create all needed extra swapfiles for testing */
 	for (j = 0; j < testfiles; j++)
-		make_swapfile(cleanup, swap_testfiles[j].filename);
+		make_swapfile(cleanup, swap_testfiles[j].filename, 0);
 
 	return 0;
 
@@ -333,14 +333,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
 	TEST_PAUSE;
 }
-- 
2.21.0

