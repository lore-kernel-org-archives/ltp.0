From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 28 May 2019 12:39:28 +0800
Subject: [LTP] [PATCH v5 3/4] syscalls/swapon/swapon0{1..3}: use helper to
	check support status
In-Reply-To: <20190528043929.19671-1-xzhou@redhat.com>
References: <20190523135518.GF30616@rei.lan>
 <20190528043929.19671-1-xzhou@redhat.com>
Message-ID: <20190528043929.19671-3-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Of swap operations.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/swapon/swapon01.c |  9 +--------
 testcases/kernel/syscalls/swapon/swapon02.c |  9 +--------
 testcases/kernel/syscalls/swapon/swapon03.c | 11 ++---------
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 32538f82b..082a21f72 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -84,14 +84,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "swapon", "./tstswap");
 
 	make_swapfile(cleanup, "swapfile01");
 }
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 4af5105c6..14bf4905d 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -132,14 +132,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "swapon", "./tstswap");
 
 	SAFE_TOUCH(cleanup, "notswap", 0777, NULL);
 	make_swapfile(cleanup, "swapfile01");
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 955ac247b..62e67d677 100644
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
+	is_swap_supported(cleanup, "swapon", "./tstswap");
 
 	TEST_PAUSE;
 }
-- 
2.21.0

