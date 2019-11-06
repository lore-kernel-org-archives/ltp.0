From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  6 Nov 2019 08:36:21 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization of
 signal USR1
Message-ID: <20191106073621.58738-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

memcg_process is triggered by memcg_lib to do allocations and
deallocations. These work was done in the signal handler.
In some cases it could happen, that memcg_lib send multiple
signals (e.g. in function warmup). This lead to signals getting
lost and failed tests.

The patch moves the allocation and deallocation to the main
function, triggered by a flag set by the signal handler.
Additionally TST_CHECKPOINT_WAKE/TST_CHECKPOINT_WAIT is
used to make memcg_lib wait until memcg_process is done
allocating/deallocating.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../controllers/memcg/functional/memcg_lib.sh |  1 +
 .../memcg/functional/memcg_process.c          | 44 +++++++++++--------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index aadaae4d2..7440e1eee 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -124,6 +124,7 @@ signal_memcg_process()
 	local usage_start=$(cat ${path}memory.usage_in_bytes)
 
 	kill -s USR1 $pid 2> /dev/null
+	TST_CHECKPOINT_WAIT 1
 
 	if [ -z "$size" ]; then
 		return
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
index 0e671f566..8e846879d 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -24,7 +24,8 @@
 static int fd;
 
 static volatile int flag_exit;
-static volatile int flag_allocated;
+static volatile int flag_do_work;
+static int flag_allocated;
 
 static int opt_mmap_anon;
 static int opt_mmap_file;
@@ -257,22 +258,7 @@ static void sigint_handler(int __attribute__ ((unused)) signo)
  */
 static void sigusr_handler(int __attribute__ ((unused)) signo)
 {
-	if (opt_mmap_anon)
-		mmap_anon();
-
-	if (opt_mmap_file)
-		mmap_file();
-
-	if (opt_mmap_lock1)
-		mmap_lock1();
-
-	if (opt_mmap_lock2)
-		mmap_lock2();
-
-	if (opt_shm)
-		shm();
-
-	flag_allocated = !flag_allocated;
+	flag_do_work++;
 }
 
 int main(int argc, char *argv[])
@@ -302,8 +288,30 @@ int main(int argc, char *argv[])
 
 	TST_CHECKPOINT_WAKE(0);
 
-	while (!flag_exit)
+	while (!flag_exit) {
+		if (flag_do_work) {
+			flag_do_work--;
+			if (opt_mmap_anon)
+				mmap_anon();
+
+			if (opt_mmap_file)
+				mmap_file();
+
+			if (opt_mmap_lock1)
+				mmap_lock1();
+
+			if (opt_mmap_lock2)
+				mmap_lock2();
+
+			if (opt_shm)
+				shm();
+
+			flag_allocated = !flag_allocated;
+
+			TST_CHECKPOINT_WAKE(1);
+		}
 		sleep(1);
+	}
 
 	close(fd);
 
-- 
2.20.1

