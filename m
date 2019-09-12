From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Sep 2019 22:13:16 +0200
Subject: [LTP] [PATCH 1/3] shell: Add tst_is_num()
In-Reply-To: <20190912201318.30931-1-pvorel@suse.cz>
References: <20190912201318.30931-1-pvorel@suse.cz>
Message-ID: <20190912201318.30931-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using grep -E, which more portable than using awk or anything else.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt | 6 ++++++
 testcases/lib/tst_test.sh       | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index a735b43bb..2d118578f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2259,6 +2259,12 @@ Checking for integers
 tst_is_int "$FOO"
 -------------------------------------------------------------------------------
 
+Checking for integers and floating point numbers
+++++++++++++++++++++++++++++++++++++++++++++++++
+# returns zero if passed an integer or floating point number parameter, non-zero otherwise
+tst_is_num "$FOO"
+-------------------------------------------------------------------------------
+
 Obtaining random numbers
 ++++++++++++++++++++++++
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e0b24c6b9..ca63745fd 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2014-2018
+# Copyright (c) Linux Test Project, 2014-2019
 # Author: Cyril Hrubis <chrubis@suse.cz>
 #
 # LTP test library for shell.
@@ -344,6 +344,11 @@ tst_is_int()
 	return $?
 }
 
+tst_is_num()
+{
+	echo "$1" | grep -Eq '^[-+]?[0-9]+\.?[0-9]*$'
+}
+
 tst_usage()
 {
 	if [ -n "$TST_USAGE" ]; then
-- 
2.22.1

