From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Tue, 31 Aug 2021 10:00:29 +0800
Subject: [LTP] [PATCH] test_macros05: Add TST_EXP_VAL_* test
Message-ID: <20210831020029.12897-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/lib/newlib_tests/test_macros05.c b/lib/newlib_tests/test_macros05.c
index a164f23ac..fda1410a2 100644
--- a/lib/newlib_tests/test_macros05.c
+++ b/lib/newlib_tests/test_macros05.c
@@ -26,6 +26,9 @@ static int fail_fn_should_not_be_seen_in_output(void)

 static void do_test(void)
 {
+	TST_EXP_VAL(MACRO_FAIL(), -2);
+	TST_EXP_VAL_SILENT(MACRO_FAIL(), -2);
+
 	TST_EXP_FAIL(MACRO_FAIL(), EINVAL);
 	TST_EXP_FAIL2(MACRO_FAIL(), EINVAL);

--
2.20.1



