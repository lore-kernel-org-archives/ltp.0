From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Jun 2020 21:25:42 +0200
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: Print tst_{res, brk} into stdout
Message-ID: <20200619192542.20113-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This allows printing messages on functions which output is redirected
into variable or used in eval. Also this change unifies the behavior
with C new API, which printed into stderr from the beginning.

Hope this change does not bring any regression.

Legacy API kept printing into stdout (legacy C API also prints to
stdout).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

some examples:

Before:
/opt/ltp/testcases/bin/tst_net.sh: line 885: 33mTCONF:: command not found
/opt/ltp/testcases/bin/tst_net.sh: eval: line 888: syntax error near unexpected token `('
/opt/ltp/testcases/bin/tst_net.sh: eval: line 888: `tst_rhost_run 1 TCONF: 'rsh' not found tst_rhost_run 1 TINFO: AppArmor enabled, this may affect test results tst_rhost_run 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root) tst_rhost_run 1 TINFO: loaded AppArmor profiles: none Summary: passed 0 failed 0 skipped 1 warnings 1'

With this patch:
tst_rhost_run 1 TCONF: 'rsh' not found
/opt/ltp/testcases/bin/tst_net.sh: line 885: Summary:: command not found
tst_rhost_run 1 TCONF: 'rsh' not found
/opt/ltp/testcases/bin/tst_net.sh: line 888: Summary:: command not found
tst_rhost_run 1 TINFO: Network config (local -- remote):
tst_rhost_run 1 TINFO: ltp_ns_veth2 --
tst_rhost_run 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
tst_rhost_run 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
tst_rhost_run 1 TCONF: 'rsh' not found
tst_rhost_run 1 TINFO: timeout per run is 0h 5m 0s
tst_rhost_run 1 TCONF: 'rsh' not found

Kind regards,
Petr

 testcases/lib/tst_test.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 1cf724cbe..2e637b25b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2014-2019
+# Copyright (c) Linux Test Project, 2014-2020
 # Author: Cyril Hrubis <chrubis@suse.cz>
 #
 # LTP test library for shell.
@@ -102,9 +102,9 @@ tst_res()
 
 	_tst_inc_res "$res"
 
-	printf "$TST_ID $TST_COUNT "
-	tst_print_colored $res "$res: "
-	echo "$@"
+	printf "$TST_ID $TST_COUNT " >&2
+	tst_print_colored $res "$res: " >&2
+	echo "$@" >&2
 }
 
 tst_brk()
-- 
2.27.0

