From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:39 -0700
Subject: [LTP] [PATCH V3 06/23] Use unsigned int instead of uint
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-6-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes

error: unknown type name 'uint'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/ipc/ipc_stress/shmem_test_04.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/ipc/ipc_stress/shmem_test_04.c b/testcases/kernel/ipc/ipc_stress/shmem_test_04.c
index 72c2e60..41aa3f4 100644
--- a/testcases/kernel/ipc/ipc_stress/shmem_test_04.c
+++ b/testcases/kernel/ipc/ipc_stress/shmem_test_04.c
@@ -116,7 +116,7 @@ typedef unsigned long ulong_t;
  * sys_error (): System error message function
  * error (): Error message function
  */
-static int mkemptyfile(uint);
+static int mkemptyfile(unsigned int);
 static void parse_args(int, char **);
 static void cleanup(int);
 static void setup_signal_handlers();
@@ -476,7 +476,7 @@ static void int_handler(int sig)
  *
  * Make an empty temporary file of a given size and return its descriptor.
  */
-static int mkemptyfile(uint size)
+static int mkemptyfile(unsigned int size)
 {
 #ifdef _LINUX_
 
-- 
2.9.0

