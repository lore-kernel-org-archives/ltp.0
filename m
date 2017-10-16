From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2017 11:58:07 +0200
Subject: [LTP] [PATCH 1/1] kernel/ima. Fix compile error regression
Message-ID: <20171016095807.17449-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

introduced in 8b6f0f9a9 ("m4: Fix libcrypto detection on 32-bit cross build")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 2 +-
 testcases/kernel/security/integrity/ima/src/ima_measure.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index a45509ab6..f7ae77cb1 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -118,6 +118,6 @@ int main(int argc, char *argv[])
 #else
 int main(void)
 {
-	tst_brkm(TCONF, "test requires libcrypto and openssl development packages");
+	tst_brkm(TCONF, NULL, "test requires libcrypto and openssl development packages");
 }
 #endif
diff --git a/testcases/kernel/security/integrity/ima/src/ima_measure.c b/testcases/kernel/security/integrity/ima/src/ima_measure.c
index 0bb7d2466..3aa56490f 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_measure.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_measure.c
@@ -214,6 +214,6 @@ int main(int argc, char *argv[])
 #else
 int main(void)
 {
-	tst_brkm(TCONF, "test requires libcrypto and openssl development packages");
+	tst_brkm(TCONF, NULL, "test requires libcrypto and openssl development packages");
 }
 #endif
-- 
2.14.2

