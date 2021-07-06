From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Tue,  6 Jul 2021 10:21:14 -0300
Subject: [LTP] [PATCH] shmget02: fix EPERM test when RLIMIT_MEMLOCK is large
 enough
Message-ID: <20210706132114.204443-1-cascardo@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

shmget(..., SHM_HUGETLB) will not fail with EPERM if there is enough space
for RLIMIT_MEMLOCK. If the limit is 0, it will fail with EPERM as expected
when a not enough privileged user calls it.

Set RLIMIT_MEMLOCK to 0 for all calls, as this is the only one which will
fail because of that limit, unless we are talking about very old kernels
(before 2.6.9).

Fixes: 4dc493b44a85 ("syscalls/shmget*: Convert into new api")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 testcases/kernel/syscalls/ipc/shmget/shmget02.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 6be8d8157999..8857207cfd3d 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -64,6 +64,7 @@ static void do_test(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	pid_t pid;
+	struct rlimit rl = { 0, 0 };
 
 	if (tc->exp_user == 0 && tc->exp_group == 0) {
 		TST_EXP_FAIL2(shmget(*tc->shmkey, tc->size, tc->flags), tc->exp_err,
@@ -78,6 +79,7 @@ static void do_test(unsigned int n)
 			SAFE_SETGID(pw->pw_gid);
 		}
 		SAFE_SETUID(pw->pw_uid);
+		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &rl);
 		TST_EXP_FAIL2(shmget(*tc->shmkey, tc->size, tc->flags), tc->exp_err,
 			"shmget(%i, %lu, %i)", *tc->shmkey, tc->size, tc->flags);
 		exit(0);
-- 
2.30.2

