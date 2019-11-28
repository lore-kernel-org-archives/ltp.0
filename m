From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Nov 2019 16:45:06 +0800
Subject: [LTP] [PATCH 2/2] pkey01: disable hugetlb test if failed to reserve
 hugepage
In-Reply-To: <20191128084506.7587-1-liwang@redhat.com>
References: <20191128084506.7587-1-liwang@redhat.com>
Message-ID: <20191128084506.7587-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To handle the false positive:
  pkey01.c:69: BROK: nr_hugepages = 0, but expect 1

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/pkeys/pkey01.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index fa84e71f3..b5831af37 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -61,13 +61,12 @@ static void setup(void)
 		size = getpagesize();
 		no_hugepage = 1;
 	} else {
-		int val;
-		SAFE_FILE_PRINTF(PATH_VM_NRHPS, "%d", 1);
-		SAFE_FILE_SCANF(PATH_VM_NRHPS, "%d", &val);
-		if (val != 1)
-			tst_brk(TBROK, "nr_hugepages = %d, but expect %d",
-					val, 1);
-		size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
+		if (tst_request_hugepages(1)) {
+			size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
+		} else {
+			size = getpagesize();
+			no_hugepage = 1;
+		}
 	}
 
 	check_pkey_support();
-- 
2.20.1

