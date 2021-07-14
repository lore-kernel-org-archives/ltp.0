From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:19:59 +0200
Subject: [LTP] [PATCH v5 2/4] make: Add make test{, -c, -shell} targets
In-Reply-To: <20210714142001.20566-1-pvorel@suse.cz>
References: <20210714142001.20566-1-pvorel@suse.cz>
Message-ID: <20210714142001.20566-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For testing C and shell API.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Makefile b/Makefile
index 56812d77b..ff4a70eec 100644
--- a/Makefile
+++ b/Makefile
@@ -192,6 +192,29 @@ $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 ## Install
 install: $(INSTALL_TARGETS)
 
+## Test
+define _test
+	@set -e; $(top_srcdir)/lib/newlib_tests/runtest.sh -b $(abs_builddir) $(1)
+endef
+
+test: lib-all
+ifneq ($(build),$(host))
+	$(error running tests on cross-compile build not supported)
+endif
+	$(call _test)
+
+test-c: lib-all
+ifneq ($(build),$(host))
+	$(error running tests on cross-compile build not supported)
+endif
+	$(call _test,-c)
+
+test-shell: lib-all
+ifneq ($(build),$(host))
+	$(error running tests on cross-compile build not supported)
+endif
+	$(call _test,-s)
+
 ## Help
 .PHONY: help
 help:
-- 
2.32.0

