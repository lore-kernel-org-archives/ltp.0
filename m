From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  8 Apr 2019 17:21:45 +0200
Subject: [LTP] [PATCH] Makefile: Remove IDcheck.sh
Message-ID: <20190408152145.29005-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is no point in running the IDcheck on 'make install' as it's
completely pointless to print ignored errors on installation which is
only confusing users.

Also the same script is even executed as a part of runltp script which
is more appropriate place for it.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Makefile | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/Makefile b/Makefile
index 170c2da20..c46d050ce 100644
--- a/Makefile
+++ b/Makefile
@@ -21,11 +21,6 @@
 # Ngie Cooper, July 2009
 #
 
-# Force IDcheck.sh to fix any issues found with $(DESTDIR)/etc/group and
-# $(DESTDIR)/etc/passwd automatically when after running the top-level
-# install target.
-CREATE_ENTRIES		?= 0
-
 top_srcdir		?= $(CURDIR)
 
 include $(top_srcdir)/include/mk/env_pre.mk
@@ -42,9 +37,6 @@ vpath %.in		$(top_srcdir)/include
 vpath %.m4		$(top_srcdir)/m4
 vpath %.mk		$(top_srcdir)/mk:$(top_srcdir)/mk/include
 
-# Skip running IDcheck.sh at the end of install?
-SKIP_IDCHECK		?= 0
-
 # User wants uclinux binaries?
 UCLINUX			?= 0
 export UCLINUX
@@ -202,17 +194,6 @@ $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 
 ## Install
 install: $(INSTALL_TARGETS)
-ifeq ($(SKIP_IDCHECK),0)
-	-@CREATE_ENTRIES=$(CREATE_ENTRIES) \
-	 DESTDIR="$(DESTDIR)" \
-	 "$(top_srcdir)/IDcheck.sh"
-else
-	@echo "*******************************************************"
-	@echo "** Will not run IDcheck.sh (SKIP_IDCHECK set to 1).  **"
-	@echo "*******************************************************"
-endif
-
-## Misc targets.
 
 ## Help
 .PHONY: help
-- 
2.19.2

