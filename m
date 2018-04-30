From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Apr 2018 19:33:17 +0200
Subject: [LTP] [PATCH 1/1] ima/ima_measurements.sh: Improve digest and
	algorithm detection
Message-ID: <20180430173317.14310-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previous detection didn't work for 'ima-sig' template descriptor in case
where measurement line contained signature (worked for record without
signature). Problem was caused by using index from the end of the
record [1]:
Sample ima-sig template measurements with/without the signature:
line="10 ee788468d1b416a394feb9f4e5650302d9cd5574 ima-sig sha256:866c2542efd5c7528591eb3bb2861a1994a655da47732ccf28f7f4b1ce42d564 /usr/lib64/libpam.so.0.84.1"

line="10 d3afb4df5fe42485b99677f4b68a04692977b4bc ima-sig sha256:7b85508c9181670fe169935310b8c95d7c2573f0318a70cecd12868569aab891 /etc/profile.d/less.sh 0302046e6c104601008bd533707b34a9e896d3d530a88e9af517fb7e8cf79e9e55064a577fcbcdb81236ede6fec0638d357e4c2ed9b261320f8789378d1e58af8e1c6f40ebdf080759be2c633b27bc8aed85af0620fa27700c68fdf31d33b2f9e36432a1e7d7eb8dbf20b9474d332deb9697767ee13e13c116544a843b54fce842d24ea485bb41f6f7b1e9fa3faed0c591f5243cee008b9499e48064141662d3c4d002b07448ae54dc8d8674437143d73c4e34f5b416300ba890dc391eae9e5b1e89190790d0ea77d1dc57e07dae9ca003294a36fda09c31f8afa347701bfcf5aed0fda9cf7a37f734ba80fc10f2d60409f0beba532f3e5cc15ae995128e466b20fdadef789e285519"

Detection also fails when used non-standard order of template fields
configured via ima_template_fmt kernel parameter.

Don't assume sha1 as default algorithm for old IMA format ('ima'
template descriptor) and determine it from digest length (these can be
only md5 or sha1 [2]).

Other minor changes
* rename variables:
  s/digest/algorithm/
  s/hash/digest/
* introduce cut dependency (ima-sig template with no signature use empty
  space instead of it)
* code cleanup

[1] https://lists.linux.it/pipermail/ltp/2018-April/007930.html
[2] https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reported-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 .../integrity/ima/tests/ima_measurements.sh        | 108 ++++++++++++++++-----
 1 file changed, 83 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 88eabd2a3..80fbf627a 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -19,7 +19,7 @@
 #
 # Verify that measurements are added to the measurement list based on policy.
 
-TST_NEEDS_CMDS="awk"
+TST_NEEDS_CMDS="awk cut"
 TST_SETUP="setup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
@@ -28,64 +28,122 @@ TST_NEEDS_DEVICE=1
 
 setup()
 {
-	DEFAULT_DIGEST_OLD_FORMAT="sha1"
 	TEST_FILE="$PWD/test.txt"
 
 	POLICY="$IMA_DIR/policy"
 	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
 
 	DIGEST_INDEX=
-	grep -q "ima-ng" $ASCII_MEASUREMENTS && DIGEST_INDEX=1
-	grep -q "ima-sig" $ASCII_MEASUREMENTS && DIGEST_INDEX=2
+
+	local template="$(tail -1 $ASCII_MEASUREMENTS | cut -d' ' -f 3)"
+	local i
+
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
 
 	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (ima_policy=tbc)"
 }
 
 # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
-compute_hash()
+compute_digest()
 {
-	local digest="$1"
+	local algorithm="$1"
 	local file="$2"
+	local digest
 
-	hash="$(${digest}sum $file 2>/dev/null | cut -f1 -d ' ')"
-	[ -n "$hash" ] && { echo $hash; return; }
+	digest="$(${algorithm}sum $file 2>/dev/null | cut -f1 -d ' ')"
+	if [ -n "$digest" ]; then
+		echo "$digest"
+		return 0
+	fi
 
-	hash="$(openssl $digest $file 2>/dev/null | cut -f2 -d ' ')"
-	[ -n "$hash" ] && { echo $hash; return; }
+	digest="$(openssl $algorithm $file 2>/dev/null | cut -f2 -d ' ')"
+	if [ -n "$digest" ]; then
+		echo "$digest"
+		return 0
+	fi
 
 	# uncommon ciphers
-	local arg="$digest"
-	case "$digest" in
+	local arg="$algorithm"
+	case "$algorithm" in
 	tgr192) arg="tiger" ;;
 	wp512) arg="whirlpool" ;;
 	esac
 
-	hash="$(rhash --$arg $file 2>/dev/null | cut -f1 -d ' ')"
-	[ -n "$hash" ] && { echo $hash; return; }
+	digest="$(rdigest --$arg $file 2>/dev/null | cut -f1 -d ' ')"
+	if [ -n "$digest" ]; then
+		echo "$digest"
+		return 0
+	fi
+	return 1
 }
 
 ima_check()
 {
-	local digest="$DEFAULT_DIGEST_OLD_FORMAT"
-	local hash expected_hash line
+	local delimiter=':'
+	local algorithm digest expected_digest line
 
 	# need to read file to get updated $ASCII_MEASUREMENTS
 	cat $TEST_FILE > /dev/null
 
 	line="$(grep $TEST_FILE $ASCII_MEASUREMENTS | tail -1)"
-	[ -n "$line" ] || tst_res TFAIL "cannot find measurement for '$TEST_FILE'"
+	if [ -z "$line" ]; then
+		tst_res TBROK "cannot find measurement record for '$TEST_FILE'"
+		return
+	fi
+	tst_res TINFO "measurement record: '$line'"
 
-	[ "$DIGEST_INDEX" ] && digest="$(echo "$line" | awk '{print $(NF-'$DIGEST_INDEX')}' | cut -d ':' -f 1)"
-	hash="$(echo "$line" | awk '{print $(NF-1)}' | cut -d ':' -f 2)"
+	digest=$(echo "$line" | cut -d' ' -f $DIGEST_INDEX)
+	if [ -z "$digest" ]; then
+		tst_res TBROK "cannot find digest (index: $DIGEST_INDEX)"
+		return
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
+			tst_res TBROK "algorithm must be either md5 or sha1 (digest: '$digest')"
+			return ;;
+		esac
+	fi
+	if [ -z "$algorithm" ]; then
+		tst_res TBROK "cannot find algorithm"
+		return
+	fi
+	if [ -z "$digest" ]; then
+		tst_res TBROK "cannot find digest"
+		return
+	fi
 
-	tst_res TINFO "computing hash for $digest digest"
-	expected_hash="$(compute_hash $digest $TEST_FILE)" || \
-		{ tst_res TCONF "cannot compute hash for '$digest' digest"; return; }
+	tst_res TINFO "computing digest for $algorithm algorithm"
+	expected_digest="$(compute_digest $algorithm $TEST_FILE)" || \
+		tst_brk TCONF "cannot compute digest for $algorithm algorithm"
 
-	if [ "$hash" = "$expected_hash" ]; then
-		tst_res TPASS "correct hash found"
+	if [ "$digest" = "$expected_digest" ]; then
+		tst_res TPASS "correct digest found"
 	else
-		tst_res TFAIL "hash not found"
+		tst_res TFAIL "digest not found"
 	fi
 }
 
-- 
2.16.3

