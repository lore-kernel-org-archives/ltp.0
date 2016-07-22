From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:52 -0700
Subject: [LTP] [PATCH V3 19/23] creat06: Include limits.h for PATH_MAX
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-19-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Glibc includes limits.h indirectly and this error goes hidden
but musl is less pardoning

Fixes errors like

creat06.c:81:23: error: ‘PATH_MAX’ undeclared here (not in a function)
 static char long_name[PATH_MAX+2];
                       ^~~~~~~~

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/creat/creat06.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index bb27d03..165c1de 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -51,6 +51,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <limits.h>
 #include <pwd.h>
 #include <sys/mman.h>
 #include <sys/types.h>
-- 
2.9.0

