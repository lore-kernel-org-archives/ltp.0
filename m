From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Jun 2021 14:15:17 +0200
Subject: [LTP] [PATCH] [COMMITTED] Revert "lib/{newlib_,
 }tests: Fix build dependency on lib"
Message-ID: <20210611121517.6136-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This reverts commit 90c6b2eb31106f0766ab2b8e90c97472e4ac3c78.

Unfortunately this change may cause an infinite loop when library
rebuild is triggered from a test directory. E.g.:

$ cd ltp
$ make clean
...
$ cd testcases/kernel/syscalls/abort
$ make
...
make -C "/foo/bar/ltp/lib" -f "/foo/bar/ltp/lib/Makefile" all
make -C "/foo/bar/ltp/lib" -f "/foo/bar/ltp/lib/Makefile" all
make -C "/foo/bar/ltp/lib" -f "/foo/bar/ltp/lib/Makefile" all
make -C "/foo/bar/ltp/lib" -f "/foo/bar/ltp/lib/Makefile" all
make -C "/foo/bar/ltp/lib" -f "/foo/bar/ltp/lib/Makefile" all
make -C "/foo/bar/ltp/lib" -f "/foo/bar/ltp/lib/Makefile" all
...

Looks like some kind of race, so let's revert the commit for now.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/Makefile | 2 +-
 lib/tests/Makefile        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index a263d7db5..30ca6810c 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 top_srcdir		?= ../..
 
-include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/env_pre.mk
 
 CFLAGS			+= -W -Wall
 LDLIBS			+= -lltp
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index c418202ed..73a0f1655 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -1,6 +1,6 @@
 top_srcdir		?= ../..
 
-include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/env_pre.mk
 
 CFLAGS			+= -W
 LDLIBS			+= -lltp
-- 
2.31.1

