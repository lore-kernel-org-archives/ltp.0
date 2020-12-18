From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 18 Dec 2020 12:28:09 +0530
Subject: [LTP] [PATCH] syscalls: init_module: Print test's name in messages
Message-ID: <049a750ca35c6adc18e8aa6bc1f97d91c05d3429.1608274686.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This was part of the original patch but got dropped while applying, lets
get it back.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/init_module/init_module02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index ff35b35e2321..88917bd7c2ed 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -71,7 +71,8 @@ static void run(unsigned int n)
 	if (tc->exp_errno == EEXIST)
 		tst_module_load(MODULE_NAME, NULL);
 
-	TST_EXP_FAIL(init_module(*tc->buf, *tc->size, tc->param), tc->exp_errno);
+	TST_EXP_FAIL(init_module(*tc->buf, *tc->size, tc->param), tc->exp_errno,
+		     "TestName: %s", tc->name);
 
 	if (tc->exp_errno == EEXIST)
 		tst_module_unload(MODULE_NAME);
-- 
2.25.0.rc1.19.g042ed3e048af

