From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Apr 2018 11:51:40 +0200
Subject: [LTP] [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Message-ID: <20180427095140.y6nngyv4ldjvitc6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> changes v2->v3:
> * Fixed some of errors caused by test order.

> * ima_boot_aggregate
>   - max event size is now 1MB according to spec

> * ima_mmap
>   - reduce sleep + log it
>   - rewritten into new API

> * ima_measurements.sh
>   - don't require iversion for kernel >= 4.16
>   - avoid using tmpfs

> * ima_policy.sh
>   - improved detection of policy writability
>   - merge test2 and test3

> * ima_violations.sh
>   - avoid using tmpfs
>   - improved grepping logs (no sleep is needed)

> * ima_tpm.sh
>   - Improve error messages

> TODO:
> * fix problems with violations tests (see patch 02/10).
> * detect whether policy must be signed (currently tests assume the
> policy does not need to be signed):
> https://lists.linux.it/pipermail/ltp/2018-April/007702.html
> http://lists.linux.it/pipermail/ltp/2018-January/006970.html

Merged. See diff against v3, if interested.
Thanks a lot Mimi for your comments, tips and review.

TODO:

* detect whether policy must be signed (currently tests assume the
policy does not need to be signed):
https://lists.linux.it/pipermail/ltp/2018-April/007702.html
http://lists.linux.it/pipermail/ltp/2018-January/006970.html

* ima_violations are failing on logging into /var/log/messages (without auditd):

tst_device.c:83: INFO: Found free device '/dev/loop0'
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/vmlinuz-4.10.0-rc6-kaiser root=/dev/mapp             er/debian--testing--vg-root ro quiet ima_policy=secure_boot
ima_violations 1 TINFO: IMA kernel config
ima_violations 1 TINFO: CONFIG_IMA=y
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA1=y
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha1"
ima_violations 1 TINFO: CONFIG_IMA_WRITE_POLICY=y
ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=y
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_violations 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_violations 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
ima_violations 1 TINFO: CONFIG_IMA_BLACKLIST_KEYRING=y
ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_violations 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
ima_violations 1 TINFO: using log /var/log/messages
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TINFO: open_writers not found in /var/log/messages (1/3 attempt)...
ima_violations 1 TINFO: open_writers not found in /var/log/messages (2/3 attempt)...
ima_violations 1 TINFO: open_writers not found in /var/log/messages (3/3 attempt)...
ima_violations 1 TFAIL: open_writers not found in /var/log/messages
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TINFO: ToMToU not found in /var/log/messages (1/3 attempt)...
ima_violations 2 TINFO: ToMToU not found in /var/log/messages (2/3 attempt)...
ima_violations 2 TINFO: ToMToU not found in /var/log/messages (3/3 attempt)...
ima_violations 2 TFAIL: ToMToU not found in /var/log/messages
...
This is due previous test ima_policy running (when there is not
possible write to policy, e.g. second run of the testsuites on CONFIG_IMA_WRITE_POLICY=n
it's ok)
I wonder if we should just TCONF when logging into /var/log/messages with combination of
policy being writable (or TCONF when logging into /var/log/messages in any case).


* Check whether current policy has tbc (i.e. presence of "ima_tcb" or "tcb" being part of ima_policy in
/proc/cmdline) [1]. I wonder if we should TCONF all tests without tcb (some tests are
working

* Getting record with old kernels (tested on both deprecated ima_tbc and ima_policy=tcb):
ima_measurements 1 TINFO: /proc/cmdline: BOOT_IMAGE=/vmlinuz-3.10.0-693.2.2.el7.x86_64 root=/dev/mapper/centos-root ro crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet ima_tbc
ima_measurements 1 TINFO: IMA kernel config:
ima_measurements 1 TINFO: CONFIG_IMA=y
ima_measurements 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_measurements 1 TINFO: CONFIG_IMA_AUDIT=y
ima_measurements 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_measurements 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_measurements 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_measurements 1 TINFO: verify adding record to the IMA measurement list
ima_measurements 1 TFAIL: cannot find measurement for '/tmp/netpan-1253/LTP_ima_measurements.P2uyOze2J4/test.txt'
awk: cmd. line:1: (FILENAME=- FNR=1) fatal: attempt to access field -1
ima_measurements 1 TINFO: computing hash for sha1 digest
ima_measurements 1 TFAIL: hash not found
ima_measurements 2 TINFO: verify updating record in the IMA measurement list
ima_measurements 2 TCONF: XFS Filesystem >= V5 required for iversion support
ima_measurements 3 TINFO: verify not measuring user files
ima_measurements 3 TPASS: grep /tmp/netpan-1253/LTP_ima_measurements.P2uyOze2J4/user/test.txt /sys/kernel/security/ima/ascii_runtime_measurements failed as expected

Not sure if this is caused by different IMA behavior in old kernels or due configuration.

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2018-April/007906.html


Diff against v3:
diff --git runtest/ima runtest/ima
index e7824a62a..bcae16bb7 100644
--- runtest/ima
+++ runtest/ima
@@ -1,5 +1,5 @@
 #DESCRIPTION:Integrity Measurement Architecture (IMA)
-ima_violations ima_violations.sh
-ima_policy ima_policy.sh
 ima_measurements ima_measurements.sh
+ima_policy ima_policy.sh
 ima_tpm ima_tpm.sh
+ima_violations ima_violations.sh
diff --git testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 862cc07ba..f6e7be041 100644
--- testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -81,7 +81,7 @@ int main(int argc, char *argv[])
 	for (i = 0; i < NUM_PCRS; i++)
 		memset(&pcr[i].digest, 0, SHA_DIGEST_LENGTH);
 
-	event.data = (char *) malloc(MAX_EVENT_DATA_SIZE);
+	event.data = malloc(MAX_EVENT_DATA_SIZE);
 	if (!event.data) {
 		printf("Cannot allocate memory\n");
 		return 1;
diff --git testcases/kernel/security/integrity/ima/tests/ima_policy.sh testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 1c4a0b922..64aa8cb7a 100755
--- testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -95,7 +95,7 @@ test2()
 	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
 		tst_res TPASS "policy was loaded just by one process and able to loaded multiple times"
 	else
-		tst_res TFAIL "problem with loading policy (policy should be able to load multiple times)"
+		tst_res TFAIL "problem loading or extending policy (may require policy to be signed)"
 	fi
 }
 
diff --git testcases/kernel/security/integrity/ima/tests/ima_setup.sh testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 03851167f..8ea7aec18 100644
--- testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -64,6 +64,21 @@ mount_loop_device()
 	cd mntpoint
 }
 
+print_ima_config()
+{
+	local config="/boot/config-$(uname -r)"
+	local i
+
+	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
+
+	if [ -r "$config" ]; then
+		tst_res TINFO "IMA kernel config:"
+		for i in $(grep ^CONFIG_IMA $config); do
+			tst_res TINFO "$i"
+		done
+	fi
+}
+
 ima_setup()
 {
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
@@ -73,14 +88,14 @@ ima_setup()
 	ASCII_MEASUREMENTS="$IMA_DIR/ascii_runtime_measurements"
 	BINARY_MEASUREMENTS="$IMA_DIR/binary_runtime_measurements"
 
+	print_ima_config
+
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
 		mount_loop_device
 	fi
 
-	if [ -n "$TST_SETUP_CALLER" ]; then
-		$TST_SETUP_CALLER
-	fi
+	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
 ima_cleanup()
diff --git testcases/kernel/security/integrity/ima/tests/ima_tpm.sh testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 0124c338f..0ffc3c022 100755
--- testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -69,7 +69,7 @@ validate_pcr()
 		grep 'HW PCR-10:' | awk '{print $3}')"
 	if [ -z "$aggregate_pcr" ]; then
 		tst_res TFAIL "failed to get PCR-10"
-		return
+		return 1
 	fi
 
 	while read line; do
