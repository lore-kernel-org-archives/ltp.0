From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jun 2021 23:48:06 +0200
Subject: [LTP] [PATCH v3 3/5] make: Add make test{, -c, -shell} targets
In-Reply-To: <20210629214808.18760-1-pvorel@suse.cz>
References: <20210629214808.18760-1-pvorel@suse.cz>
Message-ID: <20210629214808.18760-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For testing C and shell API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Simplicity wins :).

 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 56812d77b..7c1dba7e6 100644
--- a/Makefile
+++ b/Makefile
@@ -192,6 +192,16 @@ $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 ## Install
 install: $(INSTALL_TARGETS)
 
+## Test
+test: lib-all
+	$(top_srcdir)/lib/newlib_tests/runtest.sh
+
+test-c: lib-all
+	$(top_srcdir)/lib/newlib_tests/runtest.sh -c
+
+test-shell: lib-all
+	$(top_srcdir)/lib/newlib_tests/runtest.sh -s
+
 ## Help
 .PHONY: help
 help:
-- 
2.32.0

