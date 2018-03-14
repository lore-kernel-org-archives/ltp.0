From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Mar 2018 16:57:31 +0100
Subject: [LTP] [RFC PATCH v2 4/4] ima/tpm: Various fixes
In-Reply-To: <20180314155731.5943-1-pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
Message-ID: <20180314155731.5943-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

test1
* Fix reading boot_aggregate for ima-ng

test2
* Fix pcrs paths
* Drop ima_measure binary, use upstream tool evmctl from ima-evm-utils instead
https://git.code.sf.net/p/linux-ima/ima-evm-utils

test3
* Dropped, as evmctl has no 'ima_measure --validate` equivalent

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/.gitignore     |   1 -
 .../security/integrity/ima/src/ima_measure.c       | 219 ---------------------
 .../kernel/security/integrity/ima/tests/ima_tpm.sh |  58 +++---
 3 files changed, 26 insertions(+), 252 deletions(-)
 delete mode 100644 testcases/kernel/security/integrity/ima/src/ima_measure.c

diff --git a/testcases/kernel/security/integrity/.gitignore b/testcases/kernel/security/integrity/.gitignore
index 1759bc98b..184aa78ce 100644
--- a/testcases/kernel/security/integrity/.gitignore
+++ b/testcases/kernel/security/integrity/.gitignore
@@ -1,3 +1,2 @@
 /ima/src/ima_boot_aggregate
-/ima/src/ima_measure
 /ima/src/ima_mmap
diff --git a/testcases/kernel/security/integrity/ima/src/ima_measure.c b/testcases/kernel/security/integrity/ima/src/ima_measure.c
deleted file mode 100644
index 3aa56490f..000000000
--- a/testcases/kernel/security/integrity/ima/src/ima_measure.c
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2008
- *
- * Authors:
- * Reiner Sailer <sailer@watson.ibm.com>
- * Mimi Zohar <zohar@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation, version 2 of the
- * License.
- *
- * File: ima_measure.c
- *
- * Calculate the SHA1 aggregate-pcr value based on the IMA runtime
- * binary measurements.
- */
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "config.h"
-#include "test.h"
-
-char *TCID = "ima_measure";
-
-#if HAVE_LIBCRYPTO
-#include <openssl/sha.h>
-
-#define TCG_EVENT_NAME_LEN_MAX	255
-
-int TST_TOTAL = 1;
-
-static int verbose;
-
-#define print_info(format, arg...) \
-	if (verbose) \
-		printf(format, ##arg)
-
-static u_int8_t zero[SHA_DIGEST_LENGTH];
-static u_int8_t fox[SHA_DIGEST_LENGTH];
-
-struct event {
-	struct {
-		u_int32_t pcr;
-		u_int8_t digest[SHA_DIGEST_LENGTH];
-		u_int32_t name_len;
-	} header;
-	char name[TCG_EVENT_NAME_LEN_MAX + 1];
-	struct {
-		u_int8_t digest[SHA_DIGEST_LENGTH];
-		char filename[TCG_EVENT_NAME_LEN_MAX + 1];
-	} ima_data;
-	int filename_len;
-};
-
-static void display_sha1_digest(u_int8_t * digest)
-{
-	int i;
-
-	for (i = 0; i < 20; i++)
-		print_info(" %02X", (*(digest + i) & 0xff));
-}
-
-/*
- * Calculate the sha1 hash of data
- */
-static void calc_digest(u_int8_t * digest, int len, void *data)
-{
-	SHA_CTX c;
-
-	/* Calc template hash for an ima entry */
-	memset(digest, 0, sizeof *digest);
-	SHA1_Init(&c);
-	SHA1_Update(&c, data, len);
-	SHA1_Final(digest, &c);
-}
-
-static int verify_template_hash(struct event *template)
-{
-	int rc;
-
-	rc = memcmp(fox, template->header.digest, sizeof fox);
-	if (rc != 0) {
-		u_int8_t digest[SHA_DIGEST_LENGTH];
-
-		memset(digest, 0, sizeof digest);
-		calc_digest(digest, sizeof template->ima_data,
-			    &template->ima_data);
-		rc = memcmp(digest, template->header.digest, sizeof digest);
-		return rc != 0 ? 1 : 0;
-	}
-	return 0;
-}
-
-/*
- * ima_measurements.c - calculate the SHA1 aggregate-pcr value based
- * on the IMA runtime binary measurements.
- *
- * format: ima_measurement [--validate] [--verify] [--verbose]
- *
- * --validate: forces validation of the aggregrate pcr value
- * 	     for an invalidated PCR. Replace all entries in the
- * 	     runtime binary measurement list with 0x00 hash values,
- * 	     which indicate the PCR was invalidated, either for
- * 	     "a time of measure, time of use"(ToMToU) error, or a
- *	     file open for read was already open for write, with
- * 	     0xFF's hash value, when calculating the aggregate
- *	     pcr value.
- *
- * --verify: for all IMA template entries in the runtime binary
- * 	     measurement list, calculate the template hash value
- * 	     and compare it with the actual template hash value.
- *	     Return the number of incorrect hash measurements.
- *
- * --verbose: For all entries in the runtime binary measurement
- *	     list, display the template information.
- *
- * template info:  list #, PCR-register #, template hash, template name
- *	IMA info:  IMA hash, filename hint
- *
- * Ouput: displays the aggregate-pcr value
- * Return code: if verification enabled, returns number of verification
- * 		errors.
- */
-int main(int argc, char *argv[])
-{
-	FILE *fp;
-	struct event template;
-	u_int8_t pcr[SHA_DIGEST_LENGTH];
-	int i, count = 0;
-
-	int validate = 0;
-	int verify = 0;
-
-	if (argc < 2) {
-		printf("format: %s binary_runtime_measurements"
-		       " [--validate] [--verbose] [--verify]\n", argv[0]);
-		return 1;
-	}
-
-	for (i = 2; i < argc; i++) {
-		if (strncmp(argv[i], "--validate", 8) == 0)
-			validate = 1;
-		if (strncmp(argv[i], "--verbose", 7) == 0)
-			verbose = 1;
-		if (strncmp(argv[i], "--verify", 6) == 0)
-			verify = 1;
-	}
-
-	fp = fopen(argv[1], "r");
-	if (!fp) {
-		printf("fn: %s\n", argv[1]);
-		perror("Unable to open file\n");
-		return 1;
-	}
-	memset(pcr, 0, SHA_DIGEST_LENGTH);	/* initial PCR content 0..0 */
-	memset(zero, 0, SHA_DIGEST_LENGTH);
-	memset(fox, 0xff, SHA_DIGEST_LENGTH);
-
-	print_info("### PCR HASH                                  "
-		   "TEMPLATE-NAME\n");
-	while (fread(&template.header, sizeof template.header, 1, fp)) {
-		SHA_CTX c;
-
-		/* Extend simulated PCR with new template digest */
-		SHA1_Init(&c);
-		SHA1_Update(&c, pcr, SHA_DIGEST_LENGTH);
-		if (validate) {
-			if (memcmp(template.header.digest, zero, 20) == 0)
-				memset(template.header.digest, 0xFF, 20);
-		}
-		SHA1_Update(&c, template.header.digest, 20);
-		SHA1_Final(pcr, &c);
-
-		print_info("%3d %03u ", count++, template.header.pcr);
-		display_sha1_digest(template.header.digest);
-		if (template.header.name_len > TCG_EVENT_NAME_LEN_MAX) {
-			printf("%d ERROR: event name too long!\n",
-			       template.header.name_len);
-			exit(1);
-		}
-		memset(template.name, 0, sizeof template.name);
-		fread(template.name, template.header.name_len, 1, fp);
-		print_info(" %s ", template.name);
-
-		memset(&template.ima_data, 0, sizeof template.ima_data);
-		fread(&template.ima_data.digest,
-		      sizeof template.ima_data.digest, 1, fp);
-		display_sha1_digest(template.ima_data.digest);
-
-		fread(&template.filename_len,
-		      sizeof template.filename_len, 1, fp);
-		fread(template.ima_data.filename, template.filename_len, 1, fp);
-		print_info(" %s\n", template.ima_data.filename);
-
-		if (verify)
-			if (verify_template_hash(&template) != 0) {
-				tst_resm(TFAIL, "Hash failed");
-			}
-	}
-	fclose(fp);
-
-	verbose = 1;
-	print_info("PCRAggr (re-calculated):");
-	display_sha1_digest(pcr);
-	tst_exit();
-}
-
-#else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "test requires libcrypto and openssl development packages");
-}
-#endif
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index e78926165..ced1383a1 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -21,13 +21,13 @@
 
 TST_TESTFUNC="test"
 TST_SETUP="init"
-TST_CNT=3
+TST_CNT=2
 
 . ima_setup.sh
 
 init()
 {
-	tst_check_cmds ima_boot_aggregate ima_measure
+	tst_check_cmds awk cut evmctl ima_boot_aggregate
 }
 
 test1()
@@ -37,24 +37,23 @@ test1()
 	local zero="0000000000000000000000000000000000000000"
 	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
 	local ima_measurements="$ASCII_MEASUREMENTS"
-	local boot_aggregate boot_hash ima_hash line
+	local boot_aggregate boot_hash line
 
 	# IMA boot aggregate
 	read line < $ima_measurements
-	ima_hash=$(expr substr "${line}" 49 40)
+	boot_hash=$(echo $line | awk '{print $(NF-1)}' | cut -d':' -f2)
 
 	if [ ! -f "$tpm_bios" ]; then
 		tst_res TINFO "TPM not builtin kernel, or TPM not enabled"
 
-		if [ "${ima_hash}" = "${zero}" ]; then
+		if [ "${boot_hash}" = "${zero}" ]; then
 			tst_res TPASS "bios boot aggregate is 0"
 		else
 			tst_res TFAIL "bios boot aggregate is not 0"
 		fi
 	else
-		boot_aggregate=$(ima_boot_aggregate $tpm_bios)
-		boot_hash=$(expr substr $boot_aggregate 16 40)
-		if [ "${ima_hash}" = "${boot_hash}" ]; then
+		boot_aggregate=$(ima_boot_aggregate $tpm_bios | grep "boot_aggregate:" | cut -d':' -f2)
+		if [ "${boot_hash}" = "${boot_aggregate}" ]; then
 			tst_res TPASS "bios aggregate matches IMA boot aggregate"
 		else
 			tst_res TFAIL "bios aggregate does not match IMA boot aggregate"
@@ -69,29 +68,37 @@ validate_pcr()
 {
 	tst_res TINFO "verify PCR (Process Control Register)"
 
-	local ima_measurements="$BINARY_MEASUREMENTS"
-	local aggregate_pcr="$(ima_measure $ima_measurements --validate)"
 	local dev_pcrs="$1"
-	local ret=0
+	local pcr hash aggregate_pcr
+
+	aggregate_pcr="$(evmctl -v ima_measurement $BINARY_MEASUREMENTS 2>&1 | \
+		grep 'HW PCR-10:' | awk '{print $3}')"
+	[ -e "$aggregate_pcr" ] || tst_res TFAIL "failed to get PCR-10"
 
 	while read line; do
-		pcr=$(expr substr "${line}" 1 6)
+		pcr="$(echo $line | cut -d':' -f1)"
 		if [ "${pcr}" = "PCR-10" ]; then
-			aggr=$(expr substr "${aggregate_pcr}" 26 59)
-			pcr=$(expr substr "${line}" 9 59)
-			[ "${pcr}" = "${aggr}" ] || ret=$?
+			hash="$(echo $line | cut -d':' -f2 | awk '{ gsub (" ", "", $0); print tolower($0) }')"
+			[ "${hash}" = "${aggregate_pcr}" ]
+			return $?
 		fi
 	done < $dev_pcrs
-	return $ret
+	return 1
 }
 
 test2()
 {
 	tst_res TINFO "verify PCR values"
+	tst_res TINFO "evmctl version: $(evmctl --version)"
 
-	# Would be nice to know where the PCRs are located. Is this safe?
-	local pcrs_path="$(find $SYSFS/devices/ | grep pcrs)"
-	if [ $? -eq 0 ]; then
+	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"
+	if [ -f "$pcrs_path" ]; then
+		tst_res TINFO "new PCRS path, evmctl >= 1.1 required"
+	else
+		pcrs_path="/sys/class/misc/tpm0/device/pcrs"
+	fi
+
+	if [ -f "$pcrs_path" ]; then
 		validate_pcr $pcrs_path
 		if [ $? -eq 0 ]; then
 			tst_res TPASS "aggregate PCR value matches real PCR value"
@@ -103,17 +110,4 @@ test2()
 	fi
 }
 
-test3()
-{
-	tst_res TINFO "verify template hash value"
-
-	local ima_measurements="$BINARY_MEASUREMENTS"
-	ima_measure $ima_measurements --verify --validate
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "verified IMA template hash values"
-	else
-		tst_res TFAIL "error verifing IMA template hash values"
-	fi
-}
-
 tst_run
-- 
2.16.2

