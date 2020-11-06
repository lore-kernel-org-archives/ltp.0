From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Fri,  6 Nov 2020 14:06:23 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_virt: fix detection when
 systemd-detect-virt returns 1
In-Reply-To: <20201106130624.454614-1-egorenar@linux.ibm.com>
References: <20201106130624.454614-1-egorenar@linux.ibm.com>
Message-ID: <20201106130624.454614-2-egorenar@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>

When systemd-detect-virt detects no virtualization environment,
it returns 1 as exit code. This leads to tst_is_virt not doing any
fallback tests.

The problem can be reproduced inside a IBM System Z LPAR virtualization
environment.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 lib/tst_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 53d33e69c..914a08d96 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -109,9 +109,9 @@ int tst_is_virt(int virt_type)
 {
 	int ret = try_systemd_detect_virt();
 
-	if (ret >= 0) {
+	if (ret > 0) {
 		if (virt_type == VIRT_ANY)
-			return ret != 0;
+			return 1;
 		else
 			return ret == virt_type;
 	}
-- 
2.26.2

