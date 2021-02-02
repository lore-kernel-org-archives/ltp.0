From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  2 Feb 2021 14:04:41 +0100
Subject: [LTP] [PATCH 2/2] keyctl05: TCONF on FIPS mode
In-Reply-To: <20210202130441.17861-1-pvorel@suse.cz>
References: <20210202130441.17861-1-pvorel@suse.cz>
Message-ID: <20210202130441.17861-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

asymmetric key test fails on FIPS with dmesg:
RSA: key size not allowed in FIPS mode

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/keyctl/keyctl05.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index 55ce852b8..1cd665ba4 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -85,19 +85,25 @@ static void test_update_nonupdatable(const char *type,
 
 	new_session_keyring();
 
+	int is_asymmetric = !strcmp(type, "asymmetric");
+
 	TEST(add_key(type, "desc", payload, plen, KEY_SPEC_SESSION_KEYRING));
 	if (TST_RET < 0) {
+		if (TST_ERR == EINVAL && is_asymmetric && tst_fips_enabled()) {
+			tst_res(TCONF, "key size not allowed in FIPS mode");
+			return;
+		}
 		if (TST_ERR == ENODEV) {
 			tst_res(TCONF, "kernel doesn't support key type '%s'",
 				type);
 			return;
 		}
-		if (TST_ERR == EBADMSG && !strcmp(type, "asymmetric")) {
+		if (TST_ERR == EBADMSG && is_asymmetric) {
 			tst_res(TCONF, "kernel is missing x509 cert parser "
 				"(CONFIG_X509_CERTIFICATE_PARSER)");
 			return;
 		}
-		if (TST_ERR == ENOENT && !strcmp(type, "asymmetric")) {
+		if (TST_ERR == ENOENT && is_asymmetric) {
 			tst_res(TCONF, "kernel is missing crypto algorithms "
 				"needed to parse x509 cert (CONFIG_CRYPTO_RSA "
 				"and/or CONFIG_CRYPTO_SHA256)");
-- 
2.30.0

