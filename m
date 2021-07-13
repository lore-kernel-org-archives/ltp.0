From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Jul 2021 12:13:36 +0200
Subject: [LTP] [PATCH v4 5/7] make: Add make test{, -c, -shell} targets
In-Reply-To: <20210713101338.6985-1-pvorel@suse.cz>
References: <20210713101338.6985-1-pvorel@suse.cz>
Message-ID: <20210713101338.6985-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For testing C and shell API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v3->v4:
Don't run on cross-compile.

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

