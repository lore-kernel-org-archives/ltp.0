From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Jun 2021 14:52:29 +0200
Subject: [LTP] [PATCH 1/1] newlib_tests: Fix build dependency on lib
Message-ID: <20210610125229.24140-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

this fixes build error:

$ cd lib && make clean && cd newlib_tests && make
ld: cannot find -lltp

Fixes: bbdb9f783 ("lib: Add new test library API")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 30ca6810c..a263d7db5 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 top_srcdir		?= ../..
 
-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
 CFLAGS			+= -W -Wall
 LDLIBS			+= -lltp
-- 
2.31.1

