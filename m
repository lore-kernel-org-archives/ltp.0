From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 26 Mar 2021 16:05:30 +0800
Subject: [LTP] [PATCH] syscalls/clock_adjtime: fix some mistakes for commit
 135affca95dca84bc9ce6b1e2238e6db6e6b0f56
Message-ID: <20210326080530.11211-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- change TTERRNO to TERRNO after the safe_macros interface is not used;
- delete the unnecessary tst_res(TFAIL | TTERRNO, ...), which has been
  determined in the previous logic.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c | 7 +------
 testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
index 061b2bb22..aff374a2c 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
@@ -174,11 +174,6 @@ static void verify_clock_adjtime(unsigned int i)
 			tc[i].modes);
 	}

-	if (TST_RET < 0) {
-		tst_res(TFAIL | TTERRNO, "clock_adjtime(): mode=%x, returned "
-				"error", tc[i].modes);
-	}
-
 	tst_res(TPASS, "clock_adjtime(): success (mode=%x)", tc[i].modes);
 }

@@ -201,7 +196,7 @@ static void setup(void)

 	if (rval != TIME_OK && rval != TIME_ERROR) {
 		timex_show("SAVE_STATUS", &saved);
-		tst_brk(TBROK | TTERRNO, "clock has on-going leap changes, "
+		tst_brk(TBROK | TERRNO, "clock has on-going leap changes, "
 				"returned: %i", rval);
 	}

diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
index 8ef4dadb6..2df9099d5 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
@@ -209,7 +209,7 @@ static void setup(void)

 	if (rval != TIME_OK && rval != TIME_ERROR) {
 		timex_show("SAVE_STATUS", &saved);
-		tst_brk(TBROK | TTERRNO, "clock has on-going leap changes, "
+		tst_brk(TBROK | TERRNO, "clock has on-going leap changes, "
 				"returned: %i", rval);
 	}

--
2.17.1

