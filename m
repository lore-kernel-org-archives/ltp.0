From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 6 Dec 2018 17:40:11 +0800
Subject: [LTP] [PATCH] openposix: Remove _XOPEN_SOURCE in
	strchr/strcpy/strncpy
Message-ID: <1544089211-8138-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

We have defined _XOPEN_SOURCE to 600 by gcc -D in open_posix_testsuite/CFLA=
GS=EF=BC=8C
So defining _XOPEN_SOURCE to different value in test results in a "_XOPEN_S=
OURCE
redefined" warning.

It seems that all of tests get pass even if _XOPEN_SOURCE is defined to 600
by default, so remove the duplicate _XOPEN_SOURCE in test.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c  | 1 -
 testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c  | 1 -
 testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c | 1 -
 testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strchr/1=
-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c
index 95eda79..611a64d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c
@@ -25,7 +25,6 @@
  *	-Repeat the above all steps for given number of iterations.
 */
=20
-#define _XOPEN_SOURCE 700
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1=
-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c
index 2fdc002..adfbfc3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c
@@ -17,7 +17,6 @@
  *  -Also compare returned pointer with s2.
 */
=20
-#define _XOPEN_SOURCE 700
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/=
1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
index 3458015..396bd60 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
@@ -20,7 +20,6 @@
  *  -Repeat the above steps for given number of iterations.
 */
=20
-#define _XOPEN_SOURCE 700
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/=
2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c
index a7761c5..2a20872 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c
@@ -20,7 +20,6 @@
  *  -Repeat the above steps for given number of iterations.
 */
=20
-#define _XOPEN_SOURCE 700
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
--=20
1.8.3.1



