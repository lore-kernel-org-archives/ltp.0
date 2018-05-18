From: Yixin Zhang <yixin.zhang@intel.com>
Date: Sat, 19 May 2018 04:22:08 +0800
Subject: [LTP] [PATCH ltp] Add .cache.mk and *.dwo into clean target and
	.gitignore
Message-ID: <20180518202208.5752-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These files are generated during build, so and them into clean target
and .gitignore

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 .gitignore             | 2 ++
 include/mk/env_post.mk | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index a7e65633f..b838efd59 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,6 +8,8 @@ core
 .gdb_history
 .gdbinit
 lib*.a
+.cache.mk
+*.dwo
 
 /aclocal.m4
 autom4te.cache
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 4c57fffe4..59ebebb03 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -54,7 +54,7 @@ MAKE_TARGETS			?= $(notdir $(patsubst %.c,%,$(wildcard $(abs_srcdir)/*.c)))
 
 MAKE_TARGETS			:= $(filter-out $(FILTER_OUT_MAKE_TARGETS),$(MAKE_TARGETS))
 
-CLEAN_TARGETS			+= $(MAKE_TARGETS) *.o *.pyc
+CLEAN_TARGETS			+= $(MAKE_TARGETS) *.o *.pyc .cache.mk .*.dwo
 
 # Majority of the files end up in testcases/bin...
 INSTALL_DIR			?= testcases/bin
-- 
2.14.1

