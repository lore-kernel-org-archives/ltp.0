From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Aug 2017 13:52:29 +0200
Subject: [LTP] [PATCH 2/2] [COMMITTED] syscalls/setrlimit02: Remove the
	EFAULT test
In-Reply-To: <20170817115229.30598-1-chrubis@suse.cz>
References: <20170817115229.30598-1-chrubis@suse.cz>
Message-ID: <20170817115229.30598-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Glibc has to convert between 32bit and 64bit struct rlimit in some cases (looks
like that happens when prlimit64 is not implemented in the kernel) which causes
this test to SegFault.

See sysdeps/unix/sysv/linux/setrlimit*.c for reference:

...

  if (rlimits->rlim_cur >= RLIM_INFINITY)
    rlimits32.rlim_cur = RLIM_INFINITY;
  else
    rlimits32.rlim_cur = rlimits->rlim_cur;
  if (rlimits->rlim_max >= RLIM_INFINITY)
    rlimits32.rlim_max = RLIM_INFINITY;
  else
    rlimits32.rlim_max = rlimits->rlim_max;

  return __setrlimit (resource, &rlimits32);

...

Hence we remove the EFAULT case from the test in order not to produce false
possitives.

Closes #193

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/setrlimit/setrlimit02.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit02.c b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
index 92cc4f4c6..633279c6c 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit02.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
@@ -32,9 +32,6 @@ static struct tcase {
 	struct rlimit *rlim;
 	int exp_errno;
 } tcases[] = {
-#if !defined(UCLINUX)
-	{RLIMIT_NOFILE, (void *)-1, EFAULT},
-#endif
 	{-1, &rlim, EINVAL},
 	{RLIMIT_NOFILE, &rlim, EPERM}
 };
-- 
2.13.0

