From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu,  1 Jul 2021 07:03:14 +0200
Subject: [LTP] [PATCH 2/2] lib/tests: Rename test to tst_fuzzy_sync03.c
In-Reply-To: <20210701050314.1005067-1-petr.vorel@gmail.com>
References: <20210701050314.1005067-1-petr.vorel@gmail.com>
Message-ID: <20210701050314.1005067-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/.gitignore                       | 2 +-
 lib/newlib_tests/Makefile                         | 4 ++--
 lib/newlib_tests/{test16.c => tst_fuzzy_sync03.c} | 0
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename lib/newlib_tests/{test16.c => tst_fuzzy_sync03.c} (100%)

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 9f53bbb99..b51f6a679 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -13,7 +13,6 @@ test12
 test13
 test14
 test15
-test16
 tst_capability01
 tst_capability02
 tst_cgroup01
@@ -44,3 +43,4 @@ test_macros03
 test_macros04
 tst_fuzzy_sync01
 tst_fuzzy_sync02
+tst_fuzzy_sync03
diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 5bd68e95e..1fbf7649a 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -6,8 +6,8 @@ include $(top_srcdir)/include/mk/env_pre.mk
 CFLAGS			+= -W -Wall
 LDLIBS			+= -lltp
 
-test08 test09 test15 test16 tst_fuzzy_sync01 tst_fuzzy_sync02: CFLAGS += -pthread
-test16 tst_expiration_timer: LDLIBS += -lrt
+test08 test09 test15 tst_fuzzy_sync01 tst_fuzzy_sync02 tst_fuzzy_sync03: CFLAGS += -pthread
+tst_expiration_timer tst_fuzzy_sync03: LDLIBS += -lrt
 
 ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
diff --git a/lib/newlib_tests/test16.c b/lib/newlib_tests/tst_fuzzy_sync03.c
similarity index 100%
rename from lib/newlib_tests/test16.c
rename to lib/newlib_tests/tst_fuzzy_sync03.c
-- 
2.32.0.rc0

