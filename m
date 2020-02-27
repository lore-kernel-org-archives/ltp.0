From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 27 Feb 2020 10:44:31 +0530
Subject: [LTP] [PATCH V5 03/10] lapi/fsmount.h: Include "lapi/fcntl.h"
In-Reply-To: <cover.1582779464.git.viresh.kumar@linaro.org>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
Message-ID: <7a20c9dc8df8c99f07d5aff5c153a38b21dbdc19.1582779464.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All the files that include (and that will include it in future) are most
probably going to need the definitions from "lapi/fcntl.h", include it
directly instead of <fcntl.h>, which will break it for old RHL distros.

Acked-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Li Wang <liwang@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/lapi/fsmount.h                        | 2 +-
 testcases/kernel/syscalls/fsmount/fsmount01.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index a6a24904e66d..5e5eaca7e6ff 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -7,12 +7,12 @@
 #ifndef FSMOUNT_H__
 #define FSMOUNT_H__
 
-#include <fcntl.h>
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 
 #include "config.h"
+#include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
 
 #ifndef HAVE_FSOPEN
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 8e29a1537334..514d3b0b38f8 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -10,7 +10,6 @@
 #include <sys/mount.h>
 
 #include "tst_test.h"
-#include "lapi/fcntl.h"
 #include "lapi/fsmount.h"
 
 #define MNTPOINT "newmount_point"
-- 
2.21.0.rc0.269.g1a574e7a288b

