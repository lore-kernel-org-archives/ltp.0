From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu,  1 Jul 2021 14:23:51 +0200
Subject: [LTP] [PATCH 2/2] proc01: remove unused lsm_should_work
 (-Wunused-const-variable)
In-Reply-To: <20210701122351.56397-1-krzysztof.kozlowski@canonical.com>
References: <20210701122351.56397-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210701122351.56397-2-krzysztof.kozlowski@canonical.com>
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
 testcases/kernel/fs/proc/proc01.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 282c70e94882..c90e509a3243 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -137,12 +137,7 @@ static const char lsm_should_work[][PATH_MAX] = {
 	"/proc/self/attr/*",
 	"/proc/self/attr/selinux/*",
 	"/proc/self/task/[0-9]*/attr/*",
-	""
-};
-
-/* Place holder for none of LSM is detected. */
-#else
-static const char lsm_should_work[][PATH_MAX] = {
+	"/proc/self/task/[0-9]*/attr/selinux/*",
 	""
 };
 #endif
-- 
2.27.0

