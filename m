From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  2 Aug 2021 19:35:33 +0200
Subject: [LTP] [PATCH v7 4/7] make: Add make test{, -c, -shell} targets
In-Reply-To: <20210802173536.19525-1-pvorel@suse.cz>
References: <20210802173536.19525-1-pvorel@suse.cz>
Message-ID: <20210802173536.19525-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For testing C and shell API.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v6.

 Makefile | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Makefile b/Makefile
index 3b0ba330d..4e37362f9 100644
--- a/Makefile
+++ b/Makefile
@@ -200,6 +200,29 @@ check: $(CHECK_TARGETS)
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

