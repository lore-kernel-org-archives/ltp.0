From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Jun 2019 08:56:48 +0200
Subject: [LTP] [PATCH 1/3] doc: Use SPDX license identifier
In-Reply-To: <20190614065650.8612-1-pvorel@suse.cz>
References: <20190614065650.8612-1-pvorel@suse.cz>
Message-ID: <20190614065650.8612-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-tutorial-simple.txt  | 30 +++---------------------------
 doc/test-writing-guidelines.txt | 27 ++++++++++-----------------
 2 files changed, 13 insertions(+), 44 deletions(-)

diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
index 48f3ed516..34b214252 100644
--- a/doc/c-test-tutorial-simple.txt
+++ b/doc/c-test-tutorial-simple.txt
@@ -111,21 +111,9 @@ kernel version if necessary. I will explain what the code does below.
 
 [source,c]
 ------------------------------------------------------------------------------
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Instruction Ignorer <"can't"@be.bothered.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
@@ -190,20 +178,8 @@ following contents.
 
 [source,make]
 ------------------------------------------------------------------------------
-# Copyright (c) 2017 Linux Test Project
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Linux Test Project
 
 top_srcdir		?= ../../../..
 
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index f1912dc12..74cde4c58 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -153,7 +153,7 @@ separate patch.
 ~~~~~~~~~~~
 
 Code contributed to LTP should be licensed under GPLv2+ (GNU GPL version 2 or
-any later version).
+any later version). Use `SPDX-License-Identifier: GPL-2.0-or-later`.
 
 2. Writing a testcase
 ---------------------
@@ -1686,9 +1686,8 @@ WARNING: All identifiers starting with TST_ or tst_ are reserved for the
 [source,sh]
 -------------------------------------------------------------------------------
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # This is a basic test for true shell buildin
-#
 
 TST_TESTFUNC=do_test
 . tst_test.sh
@@ -1734,9 +1733,8 @@ starts the test.
 [source,sh]
 -------------------------------------------------------------------------------
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Example test with tests in separate functions
-#
 
 TST_TESTFUNC=test
 TST_CNT=2
@@ -1765,9 +1763,8 @@ found they are executed one by one. The test number is passed to it in the '$1'.
 [source,sh]
 -------------------------------------------------------------------------------
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Example test with tests in a single function
-#
 
 TST_TESTFUNC=do_test
 TST_CNT=2
@@ -1794,10 +1791,9 @@ to it in the '$1'.
 [source,sh]
 -------------------------------------------------------------------------------
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Example test with tests in a single function, using $TST_TEST_DATA and
 # $TST_TEST_DATA_IFS
-#
 
 TST_TESTFUNC=do_test
 TST_TEST_DATA="foo:bar:d dd"
@@ -1822,9 +1818,8 @@ It's possible to pass data for function with '$TST_TEST_DATA'. Optional
 [source,sh]
 -------------------------------------------------------------------------------
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Example test with tests in a single function, using $TST_TEST_DATA and $TST_CNT
-#
 
 TST_TESTFUNC=do_test
 TST_CNT=2
@@ -1924,9 +1919,8 @@ variable, if module wasn't found the test will exit with 'TCONF'.
 [source,sh]
 -------------------------------------------------------------------------------
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Optional test command line parameters
-#
 
 TST_OPTS="af:"
 TST_USAGE=usage
@@ -1978,9 +1972,8 @@ and, if option has argument, its value in the '$2'.
 [source,sh]
 -------------------------------------------------------------------------------
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Optional test positional parameters
-#
 
 TST_POS_ARGS=3
 TST_USAGE=usage
@@ -2294,9 +2287,9 @@ correct daemon name.
 [source,sh]
 -------------------------------------------------------------------------------
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Cron daemon restart example
-#
+
 TCID=cron01
 TST_COUNT=1
 . test.sh
-- 
2.21.0

