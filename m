From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Mar 2021 16:06:00 +0100
Subject: [LTP] [PATCH 2/2] IMA/ima_keys.sh: Require evmctl 1.3.2
In-Reply-To: <20210316150600.16461-1-pvorel@suse.cz>
References: <20210316150600.16461-1-pvorel@suse.cz>
Message-ID: <20210316150600.16461-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test requires fix 19b77c8 ("ima-evm-utils: Fix reading of sigfile").

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index c9eef4b68..aba1711a5 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -92,7 +92,9 @@ test1()
 # that the certificate is measured correctly by IMA.
 test2()
 {
-	tst_require_cmds evmctl keyctl openssl
+	tst_require_cmds keyctl openssl
+
+	require_evmctl "1.3.2"
 
 	local cert_file="$TST_DATAROOT/x509_ima.der"
 	local keyring_name="key_import_test"
-- 
2.30.1

