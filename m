From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 29 Sep 2020 15:01:43 -0400
Subject: [LTP] [PATCH v3 4/4] ima_tpm.sh: Fix calculating PCR aggregate
In-Reply-To: <20200929165021.11731-5-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929165021.11731-5-pvorel@suse.cz>
Message-ID: <77a75615c8ee019bcd0b0dac7946449b2e26c891.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Tue, 2020-09-29 at 18:50 +0200, Petr Vorel wrote:
> +get_pcr10_aggregate()
> +{
> +       local pcr
> +
> +       evmctl -v ima_measurement $BINARY_MEASUREMENTS > hash.txt 2>&1
> +
> +       pcr=$(grep -E "^($ALGORITHM: )*PCRAgg.*:" hash.txt \
> +               | awk '{print $NF}')
> +
> +       if [ -z "$pcr" ]; then
> +               tst_res TFAIL "evmctl failed to get aggregate PCR-10"
> +               cat hash.txt >&2
> +               return
> +       fi
> +
> +       echo "$pcr"
> +}
> +

I'm seeing the following output:

10 a528ab7a7096e0187aa5c154502f467a0f931873 ima-ng
sha1:75bf81bc120313f6aa61430fad4a47afceea3e7c
/usr/local/lib/libimaevm.so.2.0.0
Failed to match per TPM bank or SHA1 padded TPM digest(s).
errno: No such file or directory (2)
ima_tpm 2 TBROK: Test didn't report any results
ima_tpm 2 TINFO: SELinux enabled in enforcing mode, this may affect
test results
ima_tpm 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1
(requires super/root)
ima_tpm 2 TINFO: install seinfo to find used SELinux profiles
ima_tpm 2 TINFO: loaded SELinux profiles: none

SELinux is blamed enough for different things.  Let's not add verifying
the IMA measurement list.  A more likely reason for failing to validate
the measurement list is that it contains violations.  Normally this is
because the builtin "ima_policy=tcb" policy has not been replaced with
a custom policy, based on LSM labels.

Test2 should fail when the measurement list contains violations, but it
should retry validating the measurement list with the "--ignore-
violations" option to provide additional context.

thanks,

Mimi

