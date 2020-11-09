From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Mon,  9 Nov 2020 16:28:37 +0100
Subject: [LTP] [PATCH 1/1] lib/tst_virt: fix is_ibmz(VIRT_IBMZ) on IBM
 System Z
Message-ID: <20201109152837.657853-1-egorenar@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

is_ibmz(VIRT_IBMZ) always returns 0 which is incorrect on IBM System Z.
Don't check virt_type unnecessarily because it is checked later on
in the switch statement.

Fixes commit b2cc450f3 ("lib/tst_virt: support IBM/Z LPAR and z/VM virtualization environments").

Signed-off-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 lib/tst_virt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 1c6e41548..e72352464 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -70,9 +70,6 @@ static int is_ibmz(int virt_type)
 	char line[64];
 	int found_lpar, found_zvm;
 
-	if (virt_type != VIRT_IBMZ_LPAR && virt_type != VIRT_IBMZ_ZVM)
-		return 0;
-
 	if (access("/proc/sysinfo", F_OK) != 0)
 		return 0;
 
-- 
2.26.2

