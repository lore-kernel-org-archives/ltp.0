From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon,  5 Jul 2021 15:37:48 +0200
Subject: [LTP] [PATCH] shell: Drop empty line at SOF
Message-ID: <20210705133748.654630-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/pthread_attr_getinheritsched/2-1.sh   | 1 -
 .../conformance/interfaces/pthread_attr_getschedparam/2-1.sh     | 1 -
 .../conformance/interfaces/pthread_attr_getschedpolicy/1-1.sh    | 1 -
 .../conformance/interfaces/pthread_attr_getschedpolicy/3-1.sh    | 1 -
 .../conformance/interfaces/pthread_attr_getscope/2-1.sh          | 1 -
 .../conformance/interfaces/pthread_attr_getstack/2-1.sh          | 1 -
 .../conformance/interfaces/pthread_attr_getstacksize/2-1.sh      | 1 -
 .../conformance/interfaces/pthread_attr_setinheritsched/3-1.sh   | 1 -
 .../conformance/interfaces/pthread_attr_setschedparam/2-1.sh     | 1 -
 .../conformance/interfaces/pthread_attr_setschedpolicy/3-1.sh    | 1 -
 .../conformance/interfaces/pthread_attr_setscope/3-1.sh          | 1 -
 .../conformance/interfaces/pthread_attr_setstack/3-1.sh          | 1 -
 .../conformance/interfaces/pthread_attr_setstack/5-1.sh          | 1 -
 .../conformance/interfaces/pthread_attr_setstacksize/3-1.sh      | 1 -
 .../conformance/interfaces/pthread_getcpuclockid/2-1.sh          | 1 -
 15 files changed, 15 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/2-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/2-1.sh
index aefe843c9..1ab1bb016 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/2-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/2-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/2-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/2-1.sh
index 51416dc4c..1d17d7352 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/2-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/2-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, QUALCOMM Inc. All rights reserved.
 # Created by:  abisain REMOVE-THIS AT qualcomm DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/1-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/1-1.sh
index 84caa057a..b0ec24239 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/1-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/1-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/3-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/3-1.sh
index 8b313fc7b..48a16e266 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/3-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/3-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/2-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/2-1.sh
index d7ab68259..71eca6279 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/2-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/2-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/2-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/2-1.sh
index 0ce6a3443..6dd4aa620 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/2-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/2-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/2-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/2-1.sh
index 0ce6a3443..6dd4aa620 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/2-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/2-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/3-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/3-1.sh
index 9b4452d81..98f53eb19 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/3-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/3-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/2-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/2-1.sh
index 18612c808..ff1d1622f 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/2-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/2-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, QUALCOMM Inc. All rights reserved.
 # Created by:  abisain REMOVE-THIS AT qualcomm DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/3-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/3-1.sh
index c8d977f0b..8b181888b 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/3-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/3-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/3-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/3-1.sh
index 174ddadc9..02ab551b5 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/3-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/3-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/3-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/3-1.sh
index 871def244..c076f468f 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/3-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/3-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/5-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/5-1.sh
index 871def244..c076f468f 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/5-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/5-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/3-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/3-1.sh
index 871def244..c076f468f 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/3-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/3-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/2-1.sh b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/2-1.sh
index a3cf4dc76..d27e0ab32 100755
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/2-1.sh
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/2-1.sh
@@ -1,4 +1,3 @@
-
 #!/bin/sh
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  crystal.xiong REMOVE-THIS AT intel DOT com
-- 
2.25.1

