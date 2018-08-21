From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Aug 2018 16:05:47 +0200
Subject: [LTP] [RFC PATCH 2/2] make: Add test target
In-Reply-To: <20180821140547.2509-1-pvorel@suse.cz>
References: <20180821140547.2509-1-pvorel@suse.cz>
Message-ID: <20180821140547.2509-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile           |  3 +++
 lib/tests/Makefile |  3 +++
 lib/tests/test.sh  | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100755 lib/tests/test.sh

diff --git a/Makefile b/Makefile
index b0368a472..f886ac350 100644
--- a/Makefile
+++ b/Makefile
@@ -89,6 +89,9 @@ MAKE_TARGETS		:= $(addsuffix -all,$(filter-out lib,$(COMMON_TARGETS)))
 # overtaxed one, or one where -j => 1 was specified.
 all: $(addsuffix -all,$(COMMON_TARGETS)) Version
 
+test:
+	cd lib/tests && make $@
+
 $(MAKE_TARGETS): lib-all
 
 .PHONY: include-all include-install
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 73a0f1655..732fee2c4 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -7,4 +7,7 @@ LDLIBS			+= -lltp
 
 tst_cleanup_once: CFLAGS += -pthread
 
+test:
+	./test.sh $(MAKE_TARGETS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/lib/tests/test.sh b/lib/tests/test.sh
new file mode 100755
index 000000000..81d57a81b
--- /dev/null
+++ b/lib/tests/test.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2016-2018 Petr Vorel <pvorel@suse.cz>
+
+set -e
+
+for i in $@; do
+    echo "=== Testing '$i' ==="
+    case $i in
+        tst_checkpoint_wake_timeout|tst_record_childstatus)
+        if [ "$i" = "tst_record_childstatus" ]; then
+            echo "NOTE: expecting fail the test"
+            ./$i || [ $? -eq 1 ]
+        fi
+        ;;
+        tst_device)
+            if [ $(id -u) -ne 0 ]; then
+                echo "WARN: not root, skip the test"
+            else
+                ./$i
+            fi
+        ;;
+        *)
+        ./$i
+        ;;
+    esac
+    echo
+done
+
+echo "END OF TESTING"
+
+# vim: set ft=sh ts=4 sts=4 sw=4 expandtab :
-- 
2.18.0

