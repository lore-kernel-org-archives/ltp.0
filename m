From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Dec 2020 12:06:16 +0530
Subject: [LTP] [PATCH] module.mk: Remove .mod files as well during make clean
Message-ID: <9dcf930c32cfa30d683e56d368c094367695d733.1608100564.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The .mod files are left as is after a make clean, get rid of them as
well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/mk/module.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/mk/module.mk b/include/mk/module.mk
index 07d8fa89efa6..1b71a28b92a1 100644
--- a/include/mk/module.mk
+++ b/include/mk/module.mk
@@ -45,7 +45,7 @@ MAKE_TARGETS := $(filter-out %.ko, $(MAKE_TARGETS))
 MAKE_TARGETS += $(wildcard *.ko)
 endif
 
-CLEAN_TARGETS += .dep_modules
+CLEAN_TARGETS += .dep_modules *.mod
 
 MODULE_SOURCES := $(patsubst %.ko,%.c,$(filter %.ko, $(MAKE_TARGETS)))
 
-- 
2.25.0.rc1.19.g042ed3e048af

