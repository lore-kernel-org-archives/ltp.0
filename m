From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:42 +0000
Subject: [LTP] [PATCH 22/31] include sys/types.h
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-22-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes

error: unknown type name 'uint'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/ipc/ipc_stress/shmem_test_04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/ipc/ipc_stress/shmem_test_04.c b/testcases/kernel/ipc/ipc_stress/shmem_test_04.c
index 72c2e60..e7e5f61 100644
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
2.7.0

