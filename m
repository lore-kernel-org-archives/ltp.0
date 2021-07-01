From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu,  1 Jul 2021 15:14:27 +0200
Subject: [LTP] [PATCH v2 2/2] proc01: remove unused lsm_should_work
 (-Wunused-const-variable)
In-Reply-To: <20210701131427.72574-1-krzysztof.kozlowski@canonical.com>
References: <20210701131427.72574-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210701131427.72574-2-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Recent refactoring made the "lsm_should_work" unused without
libselinux-dev:

    proc01.c:142:19: warning: ?lsm_should_work? defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Fixup part of #1 patch.
---
 testcases/kernel/fs/proc/proc01.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 6ddb6682f38b..c90e509a3243 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -140,12 +140,6 @@ static const char lsm_should_work[][PATH_MAX] = {
 	"/proc/self/task/[0-9]*/attr/selinux/*",
 	""
 };
-
-/* Place holder for none of LSM is detected. */
-#else
-static const char lsm_should_work[][PATH_MAX] = {
-	""
-};
 #endif
 
 /* Known files that does not honor O_NONBLOCK, so they will hang
-- 
2.27.0

