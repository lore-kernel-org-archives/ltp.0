From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:35 +0100
Subject: [LTP] [PATCH 06/18] hugeshmget02: add missing SHM_HUGETLB flag on
	segment creation
In-Reply-To: <20171026141447.26749-1-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
Message-ID: <20171026141447.26749-7-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On test setup, hugeshmget02 detects the number of huge pages available
and uses that number to size a shared memory segment that is allocated
to carry out subsequent syscalls checks.

The setup() function detects the number of huge pages available so that
it can size the share memory segment to allocate with a reasonable size
value, but fails to pass the SHM_HUGETLB on shared memory segment
creation which defeats the whole purpose of detecting the available
number of huge pages before creating the segment.

This omission can result in test failures, eg:

hugeshmget02    0  TINFO  :  set nr_hugepages to 128
hugeshmget02    0  TINFO  :  Using 21 hugepages
hugeshmget02    1  TBROK  :  hugeshmget02.c:155: shmget #setup:
errno=ENOMEM(12): Cannot allocate memory
hugeshmget02    2  TBROK  :  hugeshmget02.c:155: Remaining cases broken
hugeshmget02    0  TINFO  :  set nr_hugepages to 0

This patch adds the missing SHM_HUGETLB flag to the shmget call in the
setup() function.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 7db8b4ede..0abd1aaf8 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -99,7 +99,8 @@ void setup(void)
 
 	shmkey = getipckey();
 	shmkey2 = shmkey + 1;
-	shm_id_1 = shmget(shmkey, shm_size, IPC_CREAT | IPC_EXCL | SHM_RW);
+	shm_id_1 = shmget(shmkey, shm_size,
+			  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
 	if (shm_id_1 == -1)
 		tst_brk(TBROK | TERRNO, "shmget #setup");
 }
-- 
2.14.2

