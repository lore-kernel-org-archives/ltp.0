From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Jul 2021 09:35:23 +0200
Subject: [LTP] [PATCH 1/1] shmget03: Consider already mapped segments
Message-ID: <20210722073523.5099-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes running test on systems with already mapped segments.

Test expected that no segment was already mapped, thus reached the
maximum earlier:

$ ipcs -m

------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status
0x62001fae 0          root       660        4124096    1

./shmget03
tst_test.c:1344: TINFO: Timeout per run is 0h 05m 00s
shmget03.c:46: TBROK: shmget failed unexpectedly: ENOSPC (28)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I suppose we don't want to factor out the code counting lines and put it
into safe_file_ops.c.

Kind regards,
Petr

 testcases/kernel/syscalls/ipc/shmget/shmget03.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index efbc465e1..57130e993 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -14,15 +14,19 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/ipc.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <pwd.h>
 #include <sys/shm.h>
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
+#include "tst_safe_stdio.h"
 #include "libnewipc.h"
 
 static int *queues;
 static int maxshms, queue_cnt;
+static int mapped_shms = -1;
+static FILE *f = NULL;
 static key_t shmkey;
 
 static void verify_shmget(void)
@@ -34,10 +38,19 @@ static void verify_shmget(void)
 static void setup(void)
 {
 	int res, num;
+	char c;
 
 	shmkey = GETIPCKEY();
 
+	f = SAFE_FOPEN("/proc/sysvipc/shm", "r");
+	while ((c = fgetc(f)) != EOF) {
+		if (c == '\n')
+			mapped_shms++;
+	}
+	tst_res(TINFO, "Already mapped shared memory segments: %d", mapped_shms);
+
 	SAFE_FILE_SCANF("/proc/sys/kernel/shmmni", "%i", &maxshms);
+	maxshms -= mapped_shms;
 
 	queues = SAFE_MALLOC(maxshms * sizeof(int));
 	for (num = 0; num < maxshms; num++) {
@@ -62,6 +75,9 @@ static void cleanup(void)
 		SAFE_SHMCTL(queues[num], IPC_RMID, NULL);
 
 	free(queues);
+
+	if (f)
+		SAFE_FCLOSE(f);
 }
 
 static struct tst_test test = {
-- 
2.32.0

