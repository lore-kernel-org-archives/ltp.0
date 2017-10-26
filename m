From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:36 +0100
Subject: [LTP] [PATCH 07/18] vma03: accept ENOMEM return value from mremap
In-Reply-To: <20171026141447.26749-1-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
Message-ID: <20171026141447.26749-8-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Will Deacon <will.deacon@arm.com>

Attempting to map a wrapping region with mremap should fail (that's the
whole point of this test). Accept ENOMEM as well as EINVAL.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/mem/vma/vma03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index 4b34ab0a0..5f231e5bb 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -100,7 +100,7 @@ int main(int argc, char *argv[])
 
 		remap = mremap(map, pgsz, 2 * pgsz, 0);
 		if (remap == MAP_FAILED) {
-			if (errno == EINVAL)
+			if (errno == EINVAL || errno == ENOMEM)
 				tst_resm(TPASS, "mremap failed as expected.");
 			else
 				tst_resm(TFAIL | TERRNO, "mremap");
-- 
2.14.2

