From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:53 -0700
Subject: [LTP] [PATCH V3 20/23] fcntl34: Replace pthread_yield() with
	sched_yield()
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-20-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sched_yield() is specified in POSIX, helps compiling with musl

home/root/work/ltp/testcases/kernel/syscalls/fcntl/fcntl34.c:88: undefined reference to `pthread_yield'
collect2: error: ld returned 1 exit status
make: *** [<builtin>: fcntl34] Error 1

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/fcntl/fcntl34.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index c72951e..a1c0c44 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <pthread.h>
+#include <sched.h>
 
 #include "lapi/fcntl.h"
 #include "tst_test.h"
@@ -84,7 +85,7 @@ void *thread_fn_01(void *arg)
 		if (fcntl(fd, F_OFD_SETLKW, &lck) == -1)
 			tst_brk(TBROK | TERRNO, "fcntl() failed");
 
-		pthread_yield();
+		sched_yield();
 	}
 
 	SAFE_CLOSE(fd);
-- 
2.9.0

