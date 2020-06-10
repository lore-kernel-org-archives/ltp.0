From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Wed, 10 Jun 2020 10:01:23 -0700
Subject: [LTP] [PATCH 2/2] IMA: Add a test to verify importing a certificate
 into keyring
In-Reply-To: <1591808483-22040-1-git-send-email-t-josne@linux.microsoft.com>
References: <1591808483-22040-1-git-send-email-t-josne@linux.microsoft.com>
Message-ID: <1591808483-22040-2-git-send-email-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add an IMA measurement test that verifies that an x509 certificate
can be imported into the .ima keyring and measured correctly.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 .../security/integrity/ima/tests/ima_keys.sh  | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 1b0dd0aed..6904fabfa 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -7,7 +7,7 @@
 
 TST_NEEDS_CMDS="awk cut"
 TST_SETUP="setup"
-TST_CNT=1
+TST_CNT=2
 TST_NEEDS_DEVICE=1
 
 . ima_setup.sh
@@ -69,4 +69,46 @@ $(echo "$line" | cut -d' ' -f5) keyring"
 	tst_res TPASS "specified keyrings were measured correctly"
 }
 
+
+# Test that a cert can be imported into the ".ima" keyring correctly.
+test2() {
+	local keyring_id key_id
+	CERT_FILE="/etc/keys/x509_ima.der" # Default
+
+	[ -f $CERT_FILE ] || tst_brk TCONF "missing $CERT_FILE"
+
+	if ! openssl x509 -in $CERT_FILE -inform der > /dev/null; then
+		tst_brk TCONF "The suppled cert file ($CERT_FILE) is not \
+a valid x509 certificate"
+	fi
+
+	tst_res TINFO "adding a cert to the \".ima\" keyring ($CERT_FILE)"
+
+	keyring_id=$(sudo keyctl show %:.ima | sed -n 2p | \
+		sed 's/^[[:space:]]*//' | cut -d' ' -f1) || \
+		tst_btk TCONF "unable to retrieve .ima keyring id"
+
+	if ! tst_is_num	"$keyring_id"; then
+		tst_brk TCONF "unable to parse keyring id from keyring"
+	fi
+
+	sudo evmctl import $CERT_FILE "$keyring_id" > /dev/null || \
+		tst_brk TCONF "unable to import a cert into the .ima keyring"
+
+	grep -F ".ima" "$ASCII_MEASUREMENTS" | tail -n1 | cut -d' ' -f6 | \
+		xxd -r -p > $TEST_FILE || \
+		tst_brk TCONF "cert not found in ascii_runtime_measurements log"
+
+	if ! openssl x509 -in $TEST_FILE -inform der > /dev/null; then
+		tst_brk TCONF "The cert logged in ascii_runtime_measurements \
+($CERT_FILE) is not a valid x509 certificate"
+	fi
+
+	if cmp -s "$TEST_FILE" $CERT_FILE; then
+		tst_res TPASS "logged cert matches original cert"
+	else
+		tst_res TFAIL "logged cert does not match original cert"
+	fi
+}
+
 tst_run
-- 
2.25.1

