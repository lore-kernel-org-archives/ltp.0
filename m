From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 18:02:11 +0200
Subject: [LTP] [PATCH v4 1/4] IMA: Move get_algorithm_digest(),
 set_digest_index() to ima_setup.sh
In-Reply-To: <20200930160214.29358-1-pvorel@suse.cz>
References: <20200930160214.29358-1-pvorel@suse.cz>
Message-ID: <20200930160214.29358-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To be reusable by more tests (preparation for next commit).

Call set_digest_index() inside get_algorithm_digest() if needed
instead of expecting get_algorithm_digest() caller to call
set_digest_index() before.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_measurements.sh   | 62 ++--------------
 .../security/integrity/ima/tests/ima_setup.sh | 70 +++++++++++++++++++
 2 files changed, 76 insertions(+), 56 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 9a7500c76..1927e937c 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -6,7 +6,7 @@
 #
 # Verify that measurements are added to the measurement list based on policy.
 
-TST_NEEDS_CMDS="awk cut"
+TST_NEEDS_CMDS="awk cut sed"
 TST_SETUP="setup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
@@ -20,72 +20,22 @@ setup()
 	TEST_FILE="$PWD/test.txt"
 	POLICY="$IMA_DIR/policy"
 	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
-	DIGEST_INDEX=
-
-	local template="$(tail -1 $ASCII_MEASUREMENTS | cut -d' ' -f 3)"
-	local i
-
-	# parse digest index
-	# https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
-	case "$template" in
-	ima|ima-ng|ima-sig|ima-buf) DIGEST_INDEX=4 ;;
-	*)
-		# using ima_template_fmt kernel parameter
-		local IFS="|"
-		i=4
-		for word in $template; do
-			if [ "$word" = 'd' -o "$word" = 'd-ng' ]; then
-				DIGEST_INDEX=$i
-				break
-			fi
-			i=$((i+1))
-		done
-	esac
-
-	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
-		"Cannot find digest index (template: '$template')"
 }
 
 ima_check()
 {
-	local delimiter=':'
-	local algorithm digest expected_digest line
+	local algorithm digest expected_digest line tmp
 
 	# need to read file to get updated $ASCII_MEASUREMENTS
 	cat $TEST_FILE > /dev/null
 
 	line="$(grep $TEST_FILE $ASCII_MEASUREMENTS | tail -1)"
-	if [ -z "$line" ]; then
-		tst_res TFAIL "cannot find measurement record for '$TEST_FILE'"
-		return
-	fi
-	tst_res TINFO "measurement record: '$line'"
 
-	digest=$(echo "$line" | cut -d' ' -f $DIGEST_INDEX)
-	if [ -z "$digest" ]; then
-		tst_res TFAIL "cannot find digest (index: $DIGEST_INDEX)"
-		return
-	fi
-
-	if [ "${digest#*$delimiter}" != "$digest" ]; then
-		algorithm=$(echo "$digest" | cut -d $delimiter -f 1)
-		digest=$(echo "$digest" | cut -d $delimiter -f 2)
+	if tmp=$(get_algorithm_digest "$line"); then
+		algorithm=$(echo "$tmp" | cut -d'|' -f1)
+		digest=$(echo "$tmp" | cut -d'|' -f2)
 	else
-		case "${#digest}" in
-		32) algorithm="md5" ;;
-		40) algorithm="sha1" ;;
-		*)
-			tst_res TFAIL "algorithm must be either md5 or sha1 (digest: '$digest')"
-			return ;;
-		esac
-	fi
-	if [ -z "$algorithm" ]; then
-		tst_res TFAIL "cannot find algorithm"
-		return
-	fi
-	if [ -z "$digest" ]; then
-		tst_res TFAIL "cannot find digest"
-		return
+		tst_res TBROK "failed to get algorithm/digest for '$TEST_FILE': $tmp"
 	fi
 
 	tst_res TINFO "computing digest for $algorithm algorithm"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 1f17aa707..83ea62d4f 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -191,6 +191,76 @@ ima_cleanup()
 	fi
 }
 
+set_digest_index()
+{
+	DIGEST_INDEX=
+
+	local template="$(tail -1 $ASCII_MEASUREMENTS | cut -d' ' -f 3)"
+	local i word
+
+	# parse digest index
+	# https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
+	case "$template" in
+	ima|ima-ng|ima-sig) DIGEST_INDEX=4 ;;
+	*)
+		# using ima_template_fmt kernel parameter
+		local IFS="|"
+		i=4
+		for word in $template; do
+			if [ "$word" = 'd' -o "$word" = 'd-ng' ]; then
+				DIGEST_INDEX=$i
+				break
+			fi
+			i=$((i+1))
+		done
+	esac
+
+	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
+		"Cannot find digest index (template: '$template')"
+}
+
+get_algorithm_digest()
+{
+	local line="$1"
+	local delimiter=':'
+	local algorithm digest
+
+	if [ -z "$line" ]; then
+		echo "measurement record not found"
+		return 1
+	fi
+
+	[ -z "$DIGEST_INDEX" ] && set_digest_index
+	digest=$(echo "$line" | cut -d' ' -f $DIGEST_INDEX)
+	if [ -z "$digest" ]; then
+		echo "digest not found (index: $DIGEST_INDEX, line: '$line')"
+		return 1
+	fi
+
+	if [ "${digest#*$delimiter}" != "$digest" ]; then
+		algorithm=$(echo "$digest" | cut -d $delimiter -f 1)
+		digest=$(echo "$digest" | cut -d $delimiter -f 2)
+	else
+		case "${#digest}" in
+		32) algorithm="md5" ;;
+		40) algorithm="sha1" ;;
+		*)
+			echo "algorithm must be either md5 or sha1 (digest: '$digest')"
+			return 1 ;;
+		esac
+	fi
+	if [ -z "$algorithm" ]; then
+		echo "algorithm not found"
+		return 1
+	fi
+	if [ -z "$digest" ]; then
+		echo "digest not found"
+		return 1
+	fi
+
+	echo "$algorithm|$digest"
+}
+
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
 if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
-- 
2.28.0

