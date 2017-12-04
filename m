From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:53 +0000
Subject: [LTP] [PATCH v3 10/12] getdtablesize01: Handle ENFILE errno
In-Reply-To: <20171204163655.8838-1-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
Message-ID: <20171204163655.8838-11-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

getdtablesize01 testcase attempts to open RLIMIT_NOFILE-1 (Maximum open
files for a process) file descriptors. However if we hit an
ENFILE (system wide limit of maximum number of open files) we should
break the test, rather than failing. This is more relevant for runs on
VMs where the rootfs could be a 9p fs or any other emulated fs.

While at it also drop a hunk that spuriously closes a single file.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/syscalls/getdtablesize/getdtablesize01.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
index 7ee231adf..3b319d91b 100644
--- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
+++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
@@ -54,7 +54,7 @@ int TST_TOTAL = 1;
 
 int main(void)
 {
-	int table_size, loop, fd, count = 0;
+	int table_size, loop, fd = 0, count = 0;
 	int max_val_opfiles;
 	struct rlimit rlp;
 
@@ -80,15 +80,16 @@ int main(void)
 
 	tst_resm(TINFO,
 		 "Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1");
-	for (loop = 1; loop <= max_val_opfiles; loop++) {
+	for (loop = 0; ; loop++) {
 		fd = open("/etc/hosts", O_RDONLY);
+
+		if (fd == -1)
+			break;
+		count = fd;
+
 #ifdef DEBUG
 		printf("Opened file num %d\n", fd);
 #endif
-		if (fd == -1)
-			break;
-		else
-			count = fd;
 	}
 
 //Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
@@ -97,6 +98,8 @@ int main(void)
 		close(count);
 	if (count == (max_val_opfiles - 1))
 		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
+	else if (fd < 0 && errno == ENFILE)
+		tst_brkm(TBROK, cleanup, "Reached maximum number of open files for the system");
 	else
 		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));
 
-- 
2.15.0

