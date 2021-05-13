From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 13 May 2021 14:23:41 +0800
Subject: [LTP] [PATCH 2/2 v2] open_posix_testsuite/Makefile: Use tabs
 instead of spaces
In-Reply-To: <20210513062341.83852-1-xieziyao@huawei.com>
References: <20210513062341.83852-1-xieziyao@huawei.com>
Message-ID: <20210513062341.83852-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Replace spaces with tabs for open_posix_testsuite/Makefile.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/open_posix_testsuite/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
index d655ebbd4..205ecdc00 100644
--- a/testcases/open_posix_testsuite/Makefile
+++ b/testcases/open_posix_testsuite/Makefile
@@ -38,7 +38,7 @@ endif
 clean: $(CRITICAL_MAKEFILE)
 	@rm -f $(LOGFILE)*
 	@for dir in $(SUBDIRS) tools; do \
-	    $(MAKE) -C $$dir clean >/dev/null; \
+		$(MAKE) -C $$dir clean >/dev/null; \
 	done

 distclean: distclean-makefiles
@@ -51,7 +51,7 @@ distclean-makefiles:

 generate-makefiles: distclean-makefiles
 	@env top_srcdir=$(top_srcdir) \
-	    $(top_srcdir)/scripts/generate-makefiles.sh
+		$(top_srcdir)/scripts/generate-makefiles.sh

 install: bin-install conformance-install functional-install stress-install

@@ -99,8 +99,8 @@ tools-all:
 	@$(MAKE) -C tools all

 $(CRITICAL_MAKEFILE): \
-    $(top_srcdir)/scripts/generate-makefiles.sh	\
-    $(top_srcdir)/CFLAGS			\
-    $(top_srcdir)/LDFLAGS			\
-    $(top_srcdir)/LDLIBS
+	$(top_srcdir)/scripts/generate-makefiles.sh	\
+	$(top_srcdir)/CFLAGS			\
+	$(top_srcdir)/LDFLAGS			\
+	$(top_srcdir)/LDLIBS
 	@$(MAKE) generate-makefiles
--
2.17.1

