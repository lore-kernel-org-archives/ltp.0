From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu,  1 Jul 2021 07:03:13 +0200
Subject: [LTP] [PATCH 1/2] lib/tests: Rename test tst_print_result.c
In-Reply-To: <20210701050314.1005067-1-petr.vorel@gmail.com>
References: <20210701050314.1005067-1-petr.vorel@gmail.com>
Message-ID: <20210701050314.1005067-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

Also:
* remove copy pasted test description
* fix author in the copyright

Fixes: cecbd0cb3 ("Fix buffer overflow in print_result() function")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/.gitignore                       |  2 +-
 lib/newlib_tests/{test17.c => tst_print_result.c} | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)
 rename lib/newlib_tests/{test17.c => tst_print_result.c} (80%)

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 83a240223..9f53bbb99 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -22,7 +22,7 @@ tst_device
 tst_safe_fileops
 tst_res_hexd
 tst_strstatus
-test17
+tst_print_result
 test18
 test19
 test20
diff --git a/lib/newlib_tests/test17.c b/lib/newlib_tests/tst_print_result.c
similarity index 80%
rename from lib/newlib_tests/test17.c
rename to lib/newlib_tests/tst_print_result.c
index c0fc0bc30..0a2ca5af1 100644
--- a/lib/newlib_tests/test17.c
+++ b/lib/newlib_tests/tst_print_result.c
@@ -1,12 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ * Copyright (c) 2017 Veronika Kabatova <vkabatov@redhat.com>
  */
-/* Basic functionality test for tst_fuzzy_sync.h similar to the atomic tests
- * (test15.c). One thread writes to the odd indexes of an array while the
- * other writes to the even. If the threads are not synchronised then they
- * will probably write to the wrong indexes as they share an index variable
- * which they should take it in turns to update.
+
+/*
+ * Test for cecbd0cb3 ("Fix buffer overflow in print_result() function")
  */
 
 #include <stdlib.h>
-- 
2.32.0.rc0

