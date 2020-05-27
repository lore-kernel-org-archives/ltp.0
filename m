From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 27 May 2020 13:41:20 -0400
Subject: [LTP] [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot
 aggregate
In-Reply-To: <20200527071434.28574-1-pvorel@suse.cz>
References: <20200527071434.28574-1-pvorel@suse.cz>
Message-ID: <1590601280.16219.1.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Wed, 2020-05-27 at 09:14 +0200, Petr Vorel wrote:
> Fixes test for kernel commit: 6f1a1d103b48 ima: ("Switch to
> ima_hash_algo for boot aggregate") from current linux-integrity tree.
> 
> Tests was failing, because it expect SHA1 hash, but for TPM 2.0 is
> now used IMA default hash algorithm (by default default SHA256).
> This is similar for entries in IMA measurement list so we can reuse
> already existing code.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v1->v2:
> * removing global variables from get_algorithm_digest (hopefully it's
> less ugly)
> 
> Tested only on VM. Can anybody test it on real HW?

With just this change, the ima_tpm.sh test is failing. ?I assume it is
failing because it is reading the SHA1 TPM bank, not the SHA256 bank
to calculate the boot_aggregate hash.

ima_tpm 1 TINFO: timeout per run is 0h 5m 0s
ima_tpm 1 TINFO: IMA kernel config:
ima_tpm 1 TINFO: CONFIG_IMA=y
ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_tpm 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_tpm 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_tpm 1 TINFO: CONFIG_IMA_WRITE_POLICY=y
ima_tpm 1 TINFO: CONFIG_IMA_READ_POLICY=y
ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_tpm 1 TINFO: CONFIG_IMA_ARCH_POLICY=y
ima_tpm 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
ima_tpm 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
ima_tpm 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
ima_tpm 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc3+.signed root=UUID=119f1a79-c391-4e37-905d-3a503284cadb ro quiet splash ima-policy=tcb
ima_tpm 1 TINFO: verify boot aggregate
ima_tpm 1 TINFO: used algorithm: sha256
ima_tpm 1 TINFO: IMA boot aggregate: 'b2341e4ccea25be7fa750830fb5fdf4bef1c44a4'
ima_tpm 1 TFAIL: bios boot aggregate does not match IMA boot aggregate (3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5b)
ima_tpm 2 TINFO: verify PCR values
ima_tpm 2 TINFO: evmctl version: evmctl 1.2
ima_tpm 2 TCONF: TPM Hardware Support not enabled in kernel or no TPM chip found
ima_tpm 3 TINFO: AppArmor enabled, this may affect test results
ima_tpm 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
ima_tpm 3 TINFO: loaded AppArmor profiles: none

Summary:
passed   0
failed   1
skipped  1
warnings 0

# head -1 /sys/kernel/security/ima/ascii_runtime_measurements

10 a3132d2501128ff527171658d40d8deb61e2292b ima-ng
sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5
b boot_aggregate

The ima-evm-utils next-testing branch has code to calculate the
boot_aggregate based on multiple banks.

# evmctl ima_boot_aggregate

sha1:4cf3d105b1a1a41b951cc6431f0801c01fe50b24
sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5b

There's also a new test to verify the boot_aggregate.

$ VERBOSE=1 make check TESTS=boog_aggregate.test

Both need some review and testing before being released.

thanks,

Mimi
