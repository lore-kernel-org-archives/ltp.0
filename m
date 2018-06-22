From: Alistair Strachan <astrachan@google.com>
Date: Fri, 22 Jun 2018 14:57:08 -0700
Subject: [LTP] [PATCH] ksm05: Fix build warning/error with -Wnull-dereference
In-Reply-To: <20180622215710.126661-1-astrachan@google.com>
References: <20180622215710.126661-1-astrachan@google.com>
Message-ID: <20180622215710.126661-2-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using the Android clang build, which uses -Werror -Wnull-dereference,
the following error is seen:

testcases/kernel/mem/ksm/ksm05.c:81:3: error: indirection of
non-volatile null pointer will be deleted, not trap
[-Werror,-Wnull-dereference]
  *(char *)NULL = 0;      /* SIGSEGV occurs as expected. */
  ^~~~~~~~~~~~~
testcases/kernel/mem/ksm/ksm05.c:81:3: note: consider using
__builtin_trap() or qualifying pointer with 'volatile'
1 error generated.

Change it to "volatile char *" which avoids this build issue, without
negatively affecting the test.

Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 testcases/kernel/mem/ksm/ksm05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index f3bfbf4fa..7c3530b28 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -78,7 +78,7 @@ static void test_ksm(void)
 		ptr = SAFE_MEMALIGN(ps, ps);
 		if (madvise(ptr, ps, MADV_MERGEABLE) < 0)
 			tst_brk(TBROK | TERRNO, "madvise");
-		*(char *)NULL = 0;	/* SIGSEGV occurs as expected. */
+		*(volatile char *)NULL = 0; /* SIGSEGV occurs as expected. */
 	}
 	SAFE_WAITPID(pid, &status, WUNTRACED | WCONTINUED);
 	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
