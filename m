From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 17 Dec 2020 09:56:20 +0530
Subject: [LTP] [PATCH] module.mk: Remove build-in.a files as well during
 make clean
Message-ID: <a7007a68b6a11f84f6551d253563da2f37319e55.1608179175.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove build-in.a files as well during make clean and also add it to
.gitignore.

Reported-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .gitignore           | 1 +
 include/mk/module.mk | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 769d4be8873e..199445292c52 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,6 +12,7 @@ lib*.a
 .cache.mk
 *.dwo
 *.mod
+build-in.a
 
 /aclocal.m4
 autom4te.cache
diff --git a/include/mk/module.mk b/include/mk/module.mk
index 1b71a28b92a1..dad293276fb8 100644
--- a/include/mk/module.mk
+++ b/include/mk/module.mk
@@ -45,7 +45,7 @@ MAKE_TARGETS := $(filter-out %.ko, $(MAKE_TARGETS))
 MAKE_TARGETS += $(wildcard *.ko)
 endif
 
-CLEAN_TARGETS += .dep_modules *.mod
+CLEAN_TARGETS += .dep_modules *.mod build-in.a
 
 MODULE_SOURCES := $(patsubst %.ko,%.c,$(filter %.ko, $(MAKE_TARGETS)))
 
-- 
2.25.0.rc1.19.g042ed3e048af

