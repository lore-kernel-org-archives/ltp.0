From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 11 May 2021 16:26:44 +0800
Subject: [LTP] [PATCH v2] kernel/syscalls: Modify incorrect use of
 TERRNO/TTERRNO
Message-ID: <20210511082644.110124-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

modify some incorrect use of TERRNO/TTERRNO in kernel/syscalls;

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Remove the modification of safe_macros, as these two would be better to put 2 commits.

 testcases/kernel/syscalls/bpf/bpf_map01.c                     | 2 +-
 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c | 2 +-
 testcases/kernel/syscalls/dup/dup03.c                         | 4 ++--
 testcases/kernel/syscalls/execve/execve02.c                   | 4 ++--
 testcases/kernel/syscalls/ioctl/ioctl04.c                     | 4 ++--
 testcases/kernel/syscalls/ioperm/ioperm01.c                   | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
index 122b18f25..94f9b7873 100644
--- a/testcases/kernel/syscalls/bpf/bpf_map01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_map01.c
@@ -82,7 +82,7 @@ void run(unsigned int n)
 			if (i < VAL_SZ)
 				tst_res(TPASS, "Preallocated array map lookup");
 		} else {
-			tst_res(TFAIL | TERRNO, "Prellocated array map lookup");
+			tst_res(TFAIL | TTERRNO, "Prellocated array map lookup");
 		}
 	break;
 	}
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 516ab50f1..382497918 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -208,7 +208,7 @@ static void do_test(unsigned int i)
 		return;
 	}

-	tst_res(TPASS | TERRNO, "clock_nanosleep() failed with");
+	tst_res(TPASS | TTERRNO, "clock_nanosleep() failed with");
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index caef078b2..0e99813f4 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -30,9 +30,9 @@ static void run(void)

 	if (TST_RET == -1) {
 		if (TST_ERR == EMFILE)
-			tst_res(TPASS | TERRNO, "dup() failed as expected");
+			tst_res(TPASS | TTERRNO, "dup() failed as expected");
 		else
-			tst_res(TFAIL | TERRNO, "dup() failed unexpectedly");
+			tst_res(TFAIL | TTERRNO, "dup() failed unexpectedly");
 		return;
 	}

diff --git a/testcases/kernel/syscalls/execve/execve02.c b/testcases/kernel/syscalls/execve/execve02.c
index d9fb5b919..0574f5c8b 100644
--- a/testcases/kernel/syscalls/execve/execve02.c
+++ b/testcases/kernel/syscalls/execve/execve02.c
@@ -49,9 +49,9 @@ static void do_child(void)
 		tst_brk(TFAIL, "execve() passed unexpectedly");

 	if (TST_ERR != EACCES)
-		tst_brk(TFAIL | TERRNO, "execve() failed unexpectedly");
+		tst_brk(TFAIL | TTERRNO, "execve() failed unexpectedly");

-	tst_res(TPASS | TERRNO, "execve() failed expectedly");
+	tst_res(TPASS | TTERRNO, "execve() failed expectedly");

 	exit(0);
 }
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index 353114cc0..d9ddb8e59 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -47,11 +47,11 @@ static void verify_ioctl(void)
 	}

 	if (TST_ERR == EACCES) {
-		tst_res(TPASS | TERRNO, "Mounting RO device RW failed");
+		tst_res(TPASS | TTERRNO, "Mounting RO device RW failed");
 		goto next;
 	}

-	tst_res(TFAIL | TERRNO,
+	tst_res(TFAIL | TTERRNO,
 		"Mounting RO device RW failed unexpectedly expected EACCES");

 next:
diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
index fc5754be9..6c50a0b75 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm01.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
@@ -64,7 +64,7 @@ static void cleanup(void)
 	 * Reset I/O privileges for the specified port.
 	 */
 	if ((ioperm(io_addr, NUM_BYTES, 0)) == -1)
-		tst_brk(TBROK | TTERRNO, "ioperm() cleanup failed");
+		tst_brk(TBROK | TERRNO, "ioperm() cleanup failed");
 }

 static struct tst_test test = {
--
2.17.1

