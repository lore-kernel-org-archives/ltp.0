From: Alexander Gordeev <agordeev@linux.ibm.com>
Date: Fri,  8 May 2020 15:09:02 +0200
Subject: [LTP] [PATCH 1/2] syscalls/kcmp03.c: Extend clone_type type to
 unsigned long
In-Reply-To: <cover.1588942426.git.agordeev@linux.ibm.com>
References: <cover.1588942426.git.agordeev@linux.ibm.com>
Message-ID: <c505358f47c1cdb7cf04032f567aeb3bcec37e7c.1588942426.git.agordeev@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Member clone_type is defined as signed integer type. That
is too small to accomodate CLONE_IO (which conflicts with
the sign bit) and newer clone flags (i.e CLONE_INTO_CGROUP).

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 testcases/kernel/syscalls/kcmp/kcmp03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index 30ac3ec..f36515f 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -31,7 +31,7 @@ static int pid2;
 static void *stack;
 
 static struct tcase {
-	int clone_type;
+	unsigned long clone_type;
 	int kcmp_type;
 } tcases[] = {
 	{CLONE_VM, KCMP_VM},
-- 
1.8.3.1

