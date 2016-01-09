From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:14:04 +0000
Subject: [LTP] [PATCH V2 16/32] ustat: Change header from ustat.h to
	sys/ustat.h
In-Reply-To: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452302060-103643-16-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

makes it portable for musl, on glibc ustat.h is just including
sys/ustat.h too

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/ustat/ustat01.c | 2 +-
 testcases/kernel/syscalls/ustat/ustat02.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 01b7688..494647b 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -20,8 +20,8 @@
  */
 
 #include <unistd.h>
-#include <ustat.h>
 #include <errno.h>
+#include <sys/ustat.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include "test.h"
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index 4e66236..edada31 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -21,8 +21,8 @@
  */
 
 #include <unistd.h>
-#include <ustat.h>
 #include <errno.h>
+#include <sys/ustat.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include "test.h"
-- 
2.7.0

