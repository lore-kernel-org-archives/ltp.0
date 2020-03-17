From: Zou Wei <zou_wei@huawei.com>
Date: Tue, 17 Mar 2020 15:33:20 +0800
Subject: [LTP] [PATCH] open_posix_testsuite: Enable the testsuite
Message-ID: <1584430400-47359-1-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Enable open posix testsuite compilation by default

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 testcases/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/testcases/Makefile b/testcases/Makefile
index b04e630..ae1cafc 100644
--- a/testcases/Makefile
+++ b/testcases/Makefile
@@ -30,10 +30,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
 #    run).
 FILTER_OUT_DIRS		:= kdump

-ifneq ($(WITH_OPEN_POSIX_TESTSUITE),yes)
-FILTER_OUT_DIRS		+= open_posix_testsuite
-endif
-
 ifneq ($(WITH_REALTIME_TESTSUITE),yes)
 FILTER_OUT_DIRS		+= realtime
 endif
--
2.6.2

