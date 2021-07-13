From: Ian May <ian.s.may@gmail.com>
Date: Tue, 13 Jul 2021 13:34:49 +0000
Subject: [LTP] [PATCH] syscalls/shmctl05.c: Fix leak of shared memory segment
Message-ID: <20210713133449.33278-1-ian.s.may@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The cleanup function is using the key 0xF00F instead of the id in the shmctl call.
This causes the shared mem segment to not be removed properly.

This can be reproduced with the following:

$ ./shmctl05
tst_test.c:1342: TINFO: Timeout per run is
../../../../../include/tst_fuzzy_sync.h:522: TINFO: Minimum sampling period ended
../../../../../include/tst_fuzzy_sync.h:345: TINFO: loop = 1024, delay_bias = 0
../../../../../include/tst_fuzzy_sync.h:333: TINFO: start_a - start_b: { avg =   ns, avg_dev =     ns, dev_ratio = }
../../../../../include/tst_fuzzy_sync.h:333: TINFO: end_a - start_a  : { avg =   ns, avg_dev =     ns, dev_ratio = }
../../../../../include/tst_fuzzy_sync.h:333: TINFO: end_b - start_b  : { avg =   ns, avg_dev =     ns, dev_ratio = }
../../../../../include/tst_fuzzy_sync.h:333: TINFO: end_a - end_b    : { avg =   ns, avg_dev =     ns, dev_ratio = }
../../../../../include/tst_fuzzy_sync.h:333: TINFO: spins            : { avg =     , avg_dev =       , dev_ratio = }
../../../../../include/tst_fuzzy_sync.h:678: TINFO: Exceeded execution time, requesting exit
shmctl05.c:89: TPASS: didn't crash

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

$ ipcs -m

------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status
0x0000f00f 629964859  user       700        4096       0

Fix
In the cleanup, add a SAFE_SHMGET to fetch the id and pass into shmctl call.
Confirmed this resolves the leaked segment.

Signed-off-by: Ian May <ian.s.may@gmail.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index f8b76bda7..ea7eef6f1 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -91,8 +91,10 @@ static void do_test(void)
 
 static void cleanup(void)
 {
+	int id;
 	tst_fzsync_pair_cleanup(&fzsync_pair);
-	shmctl(0xF00F, IPC_RMID, NULL);
+	id = SAFE_SHMGET(0xF00F, 4096, 0);
+	SAFE_SHMCTL(id, IPC_RMID, NULL);
 }
 
 static struct tst_test test = {
-- 
2.25.1

