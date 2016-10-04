From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Tue,  4 Oct 2016 10:26:02 +0200
Subject: [LTP]  [PATCH v2] Fix typos in assignments to the field tid
Message-ID: <1475569562-8681-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1 -> v2:
	- mad a clean patch, without the unnecessary changes in llistxattr03.c

llistxattr02 -> llistxattr03
sokcetpair01 -> socketpair01
madvice05 -> madvise05

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 testcases/kernel/syscalls/llistxattr/llistxattr03.c | 2 +-
 testcases/kernel/syscalls/madvise/madvise05.c       | 2 +-
 testcases/kernel/syscalls/socketpair/socketpair01.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index 5513019..a371632 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -89,7 +89,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "llistxattr02",
+	.tid = "llistxattr03",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_llistxattr,
diff --git a/testcases/kernel/syscalls/madvise/madvise05.c b/testcases/kernel/syscalls/madvise/madvise05.c
index 612c967..4f8718f 100644
--- a/testcases/kernel/syscalls/madvise/madvise05.c
+++ b/testcases/kernel/syscalls/madvise/madvise05.c
@@ -55,7 +55,7 @@ static void verify_madvise(void)
 }
 
 static struct tst_test test = {
-	.tid = "madvice05",
+	.tid = "madvise05",
 	.min_kver = "3.9.0",
 	.test_all = verify_madvise,
 };
diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index 63c2030..f7833a4 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -102,7 +102,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "sokcetpair01",
+	.tid = "socketpair01",
 	.tcnt = ARRAY_SIZE(tdat),
 	.setup = setup,
 	.test = verify_socketpair
-- 
1.9.1

