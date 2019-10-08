From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  8 Oct 2019 11:32:18 +0200
Subject: [LTP] [PATCH] getdents: Fix build under glibc 2.30
Message-ID: <20191008093218.15801-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

glibc commit b8b3d5a14e ("Linux: Move getdents64 to <dirent.h>")
moved the declaration from <unistd.h> to <dirent.h> to match the
location of the declaration in musl.

Thus we need to include both <dirent.h> and <unistd.h> for getdents64().

Using getdents64() declaration requires on both glibc and musl
_GNU_SOURCE definition, thus move it to to getdents.h.

Fixes: 587
Reported-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

you might not like moving _GNU_SOURCE definition to the header, I can
add the missing one in getdents01.c instead.

Travis: https://travis-ci.org/pevik/ltp/builds/595021543

Kind regards,
Petr

 testcases/kernel/syscalls/getdents/getdents.h   | 2 ++
 testcases/kernel/syscalls/getdents/getdents01.c | 3 ++-
 testcases/kernel/syscalls/getdents/getdents02.c | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents.h b/testcases/kernel/syscalls/getdents/getdents.h
index c24ed6c99..e43dacc15 100644
--- a/testcases/kernel/syscalls/getdents/getdents.h
+++ b/testcases/kernel/syscalls/getdents/getdents.h
@@ -20,6 +20,7 @@
 #ifndef GETDENTS_H
 #define GETDENTS_H
 
+#define _GNU_SOURCE
 #include <stdint.h>
 #include "test.h"
 #include "lapi/syscalls.h"
@@ -54,6 +55,7 @@ struct linux_dirent64 {
 };
 
 #if HAVE_GETDENTS64
+#include <dirent.h>
 #include <unistd.h>
 #else
 static inline int
diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index 3962d960b..17a58731d 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -19,6 +19,8 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#include "getdents.h"
+
 #include <stdio.h>
 #include <errno.h>
 #include <sys/types.h>
@@ -27,7 +29,6 @@
 
 #include "test.h"
 #include "safe_macros.h"
-#include "getdents.h"
 
 static void cleanup(void);
 static void setup(void);
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 7b023c53f..c45812241 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -33,7 +33,8 @@
  *
  */
 
-#define _GNU_SOURCE
+#include "getdents.h"
+
 #include <stdio.h>
 #include <errno.h>
 #include <sys/types.h>
@@ -41,7 +42,6 @@
 #include <fcntl.h>
 
 #include "test.h"
-#include "getdents.h"
 #include "safe_macros.h"
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
-- 
2.23.0

