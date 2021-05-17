From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 17 May 2021 17:30:29 +0100
Subject: [LTP] [RFC PATCH 6/6] API: Check exported symbols
In-Reply-To: <20210517163029.22974-1-rpalethorpe@suse.com>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
Message-ID: <20210517163029.22974-7-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Abort the build process if a new symbol is exported from the library
without tst_ or safe_ prepended.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/Makefile                 | 12 +++++++
 scripts/check_export_syms.sh | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100755 scripts/check_export_syms.sh

diff --git a/lib/Makefile b/lib/Makefile
index f019432e8..76ef49a3e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -42,5 +42,17 @@ $(pc_file):
 	test -d "$(@D)" || mkdir -p "$(@D)"
 	install -m $(INSTALL_MODE) "$(builddir)/$(@F)" "$@"
 
+CHECK_LIB ?= $(top_srcdir)/scripts/check_export_syms.sh
+.PHONY: check_lib
+check_lib: libltp.a
+ifdef VERBOSE
+	$(CHECK_LIB) $<
+else
+	@echo CHECK_LIB $<
+	@$(CHECK_LIB) $<
+endif
+
+MAKE_TARGETS		+= check_lib
+
 include $(top_srcdir)/include/mk/lib.mk
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/scripts/check_export_syms.sh b/scripts/check_export_syms.sh
new file mode 100755
index 000000000..d573ed946
--- /dev/null
+++ b/scripts/check_export_syms.sh
@@ -0,0 +1,64 @@
+#!/bin/sh -eu
+# Check the exported symbols from an object file or archive
+
+obj_file=$1
+
+non_prefix_syms() {
+    nm $obj_file --defined-only -o -g -l | \
+	awk -F ' ' "\$3 !~ /tst_|safe_|ltp_/ { print }"
+}
+
+ignore_list=$(tr -d '\n' <<EOF
+parse_opts|
+STD_LOOP_COUNT|
+usc_global_setup_hook|
+usc_test_looping|
+parse_ranges|
+random_bit|
+random_range|
+random_rangel|
+random_rangell|
+random_range_seed|
+range_max|
+range_min|
+range_mult|
+lio_check_asyncio|
+lio_help1|
+lio_help2|
+Lio_info1|
+Lio_info2|
+lio_parse_io_arg1|
+lio_parse_io_arg2|
+lio_random_methods|
+lio_read_buffer|
+lio_set_debug|
+Lio_SysCall|
+lio_wait4asyncio|
+lio_write_buffer|
+stride_bounds|
+TEST_ERRNO|
+TEST_RETURN|
+TST_RET_PTR|
+TCID|
+TST_ERR|
+TST_PASS|
+TST_RET
+EOF
+)
+
+ignore_regex="\$3 !~ /$ignore_list/"
+fmt_error_statement=$(cat <<"EOF"
+{
+  ("basename " $4) | getline cfile
+  print "ERROR: lib symbol exported without tst_ or safe_: " cfile"::"$3
+  failed = 1
+}
+END {
+  if (failed == 1) {
+      exit(1)
+  }
+}
+EOF
+)
+
+non_prefix_syms | awk -F ' ' "$ignore_regex $fmt_error_statement"
-- 
2.31.1

