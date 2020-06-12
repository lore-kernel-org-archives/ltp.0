From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Fri, 12 Jun 2020 10:38:42 -0400
Subject: [LTP] [PATCH v2 2/2] IMA: Add a test to verify importing a
 certificate into keyring
In-Reply-To: <20200612143842.3993-1-t-josne@linux.microsoft.com>
References: <20200612143842.3993-1-t-josne@linux.microsoft.com>
Message-ID: <20200612143842.3993-3-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add an IMA measurement test that verifies that an x509 certificate
can be imported into the .ima keyring and measured correctly.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 .../security/integrity/ima/tests/ima_keys.sh  | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index f9c60a6fc..1eabb3e2e 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -5,10 +5,12 @@
 #
 # Verify that keys are measured correctly based on policy.
 
-TST_NEEDS_CMDS="awk cut xxd"
-TST_CNT=1
+TST_NEEDS_CMDS="awk cut xxd keyctl evmctl openssl cmp"
+TST_CNT=2
 TST_NEEDS_DEVICE=1
 
+CERT_FILE="${CERT_FILE:-}/etc/keys/x509_ima.der"
+
 . ima_setup.sh
 
 # Based on https://lkml.org/lkml/2019/12/13/564.
@@ -62,4 +64,43 @@ test1()
 	tst_res TPASS "specified keyrings were measured correctly"
 }
 
+
+# Test that a cert can be imported into the ".ima" keyring correctly.
+test2() {
+	local keyring_id key_id test_file="$PWD/test.txt"
+
+	[ -f $CERT_FILE ] || tst_brk TCONF "missing $CERT_FILE"
+
+	if ! openssl x509 -in $CERT_FILE -inform der > /dev/null; then
+		tst_brk TCONF "The suppled cert file ($CERT_FILE) is not a valid x509 certificate"
+	fi
+
+	tst_res TINFO "adding a cert to the .ima keyring ($CERT_FILE)"
+
+	keyring_id=$(keyctl show %:.ima | sed -n 2p | \
+		sed 's/^[[:space:]]*//' | cut -d' ' -f1) || \
+		tst_btk TCONF "unable to retrieve .ima keyring id"
+
+	if ! tst_is_num	"$keyring_id"; then
+		tst_brk TCONF "unable to parse keyring id from keyring"
+	fi
+
+	evmctl import $CERT_FILE "$keyring_id" > /dev/null || \
+		tst_brk TCONF "unable to import a cert into the .ima keyring"
+
+	grep -F ".ima" "$ASCII_MEASUREMENTS" | tail -n1 | cut -d' ' -f6 | \
+		xxd -r -p > $test_file || \
+		tst_brk TCONF "cert not found in ascii_runtime_measurements log"
+
+	if ! openssl x509 -in $test_file -inform der > /dev/null; then
+		tst_brk TCONF "The cert logged in ascii_runtime_measurements is not a valid x509 certificate"
+	fi
+
+	if cmp -s "$test_file" $CERT_FILE; then
+		tst_res TPASS "logged cert matches original cert"
+	else
+		tst_res TFAIL "logged cert does not match original cert"
+	fi
+}
+
 tst_run
-- 
2.25.1

