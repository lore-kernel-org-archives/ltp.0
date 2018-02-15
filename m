From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Feb 2018 21:47:12 +0100
Subject: [LTP] [RFC PATCH v2 1/3] tst_test.sh: Add default trap to INT
Message-ID: <20180215204714.14597-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This can be overwritten in tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
---
We've been talking about it:
http://lists.linux.it/pipermail/ltp/2017-December/006660.html
http://lists.linux.it/pipermail/ltp/2017-December/006663.html
But I guess this should be ok for all tests.
---
 testcases/lib/tst_test.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index d6b638549..56ec9d126 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) Linux Test Project, 2014-2017
+# Copyright (c) Linux Test Project, 2014-2018
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -32,6 +32,9 @@ export TST_TMPDIR_RHOST=0
 
 . tst_ansi_color.sh
 
+# default trap function
+trap "tst_brk TBROK 'test interrupted'" INT
+
 tst_do_exit()
 {
 	local ret=0
-- 
2.16.1

