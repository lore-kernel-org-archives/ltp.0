From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jul 2020 19:20:43 +0200
Subject: [LTP] [PATCH v2 6/7] net/test: Add basic testing for tst_rhost_run
In-Reply-To: <20200710172044.21592-1-pvorel@suse.cz>
References: <20200710172044.21592-1-pvorel@suse.cz>
Message-ID: <20200710172044.21592-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Regression test for use of nested single quotes
(fixed in previous commit).

Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/shell/net/tst_rhost_run.sh | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 lib/newlib_tests/shell/net/tst_rhost_run.sh

diff --git a/lib/newlib_tests/shell/net/tst_rhost_run.sh b/lib/newlib_tests/shell/net/tst_rhost_run.sh
new file mode 100755
index 000000000..4c034a4ac
--- /dev/null
+++ b/lib/newlib_tests/shell/net/tst_rhost_run.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+
+TST_TESTFUNC=do_test
+PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
+. tst_net.sh
+
+do_test()
+{
+	local file="/etc/fstab"
+
+	tst_rhost_run -c 'which grep > /dev/null' || \
+		tst_res TCONF "grep not found on rhost"
+
+	tst_rhost_run -c "[ -f $file ]" || \
+		tst_res TCONF "$file not found on rhost"
+
+	tst_rhost_run -s -c "grep -q \"[^ ]\" $file"
+	tst_rhost_run -s -c "grep -q '[^ ]' $file"
+
+	tst_res TPASS "tst_rhost_run is working"
+}
+
+tst_run
-- 
2.27.0

