From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 14 Dec 2018 14:53:16 -0800
Subject: [LTP] [PATCH] getcpu01: Rename getcpu to avoid conflict with glibc
	>= 2.29
Message-ID: <20181214225316.43732-1-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

glibc has added getcpu() API starting with glibc 2.29 release, this
makes the static function in conflict and signatures are not same as
well.

Renaming helps to keep ltp build going

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/getcpu/getcpu01.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index c927512ca..e850fe844 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -82,7 +82,7 @@ int sys_support = 0;
 
 void cleanup(void);
 void setup(void);
-static inline int getcpu(unsigned int *, unsigned int *, void *);
+static inline int get_cpu(unsigned int *, unsigned int *, void *);
 unsigned int set_cpu_affinity(void);
 unsigned int get_nodeid(unsigned int);
 unsigned int max_cpuid(size_t, cpu_set_t *);
@@ -124,7 +124,7 @@ int main(int ac, char **av)
 #ifdef __i386__
 		node_set = get_nodeid(cpu_set);
 #endif
-		TEST(getcpu(&cpu_id, &node_id, NULL));
+		TEST(get_cpu(&cpu_id, &node_id, NULL));
 		if (TEST_RETURN == 0) {
 			if (cpu_id != cpu_set) {
 				tst_resm(TFAIL, "getcpu() returned wrong value"
@@ -157,10 +157,10 @@ int main(int ac, char **av)
 }
 
 /*
- * getcpu() - calls the system call
+ * get_cpu() - calls the system call
  */
-static inline int getcpu(unsigned *cpu_id, unsigned *node_id,
-			 void *cache_struct)
+static inline int get_cpu(unsigned *cpu_id, unsigned *node_id,
+			  void *cache_struct)
 {
 #if defined(__i386__)
 	return syscall(318, cpu_id, node_id, cache_struct);
-- 
2.20.0

