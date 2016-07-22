From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:56 -0700
Subject: [LTP] [PATCH V3 23/23] shmem_test_04: Include sys/types.h for
	caddr_t
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-23-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/ipc/ipc_stress/shmem_test_04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/ipc/ipc_stress/shmem_test_04.c b/testcases/kernel/ipc/ipc_stress/shmem_test_04.c
index 41aa3f4..01cf62b 100644
--- a/testcases/kernel/ipc/ipc_stress/shmem_test_04.c
+++ b/testcases/kernel/ipc/ipc_stress/shmem_test_04.c
@@ -65,6 +65,7 @@
 #include <signal.h>
 #include <stdint.h>
 #include <sys/mman.h>
+#include <sys/types.h>
 
 #ifdef _LINUX_
 typedef unsigned long ulong_t;
-- 
2.9.0

