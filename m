From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 29 Sep 2020 16:46:07 -0400
Subject: [LTP] [PATCH v3 3/4] ima_tpm.sh: Fix calculating boot aggregate
In-Reply-To: <20200929165021.11731-4-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929165021.11731-4-pvorel@suse.cz>
Message-ID: <b249ba7ba369810e28c3653c4dfd23ca3ac9d1d8.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2020-09-29 at 18:50 +0200, Petr Vorel wrote:
> for TPM 2.0 or kernel >= v5.8-rc1:
> 6f1a1d103b48 ima: ("Switch to ima_hash_algo for boot aggregate")
> 
> Test still fails with TPM 2.0 on kernel < v5.8-rc1.
> 
> Test was failing, because it expect SHA1 hash, but for TPM 2.0 is
> now used IMA default hash algorithm (by default default SHA256).

TPM 1.2 only supported MD5 and SHA1, at least the IMA measurement list
did.  (This is probably the reason it searched for "boot_aggregate" and
not "sha1".)  Nobody should be using MD5, so the boot_aggregate for TPM
1.2 should always be SHA1.

For TPM 2.0, which supports multiple algorithms, it's a bit more
complicated.  The hash algorithm used for calculating the
"boot_aggregate" is dependent on which TPM bank is enabled.  For
example, even if the default IMA measurement hash is defined as SHA256,
but the TPM 2.0 SHA256 bank isn't enabled, it will fall back to
calculating a SHA1 "boot_aggregate".

For backwards compatibility, the SHA1 boot_aggregate is based on PCRs 0
-7, while all others include PCRs 0 - 9.

> This is similar for entries in IMA measurement list so we can reuse
> already existing code.
> 
> Reading other algorithms than sha1 or TPM 2.0 requires evmctl >= 1.3.
> Although recent evmctl is recommended, to support older kernels when
> sha1 is used, get boot aggregate with old our legacy ima_boot_aggregate.c.

For example, some PTT firmware (TPM 2.0) only supports SHA1.  (I've
seen some TPM 2.0's using the TPM 1.2 event log format.)   Instead of
saying, "to support older kernels when sha1 is used, get boot_aggregate
...", it should say "to support older TPMs, calculate the
"boot_aggregate" with ...cat

One of the major differences is that the original TPM 1.2 support
walked the TPM event log, extending the PCRs.  Only after re-
calculating the PCRs, would it calculate the "boot_aggregate".  The TPM
2.0 support assumes that some other mechanism exists for verifying the
PCRs against the TPM event log* and just calculates the
"boot_aggregate" based on the existing TPM PCR values.

* tsseventextend -sim -if
/sys/kernel/security/tpm0/binary_bios_measurements  -v -ns

Mimi

> 
> Also fixed test without TPM device (when IMA TPM-bypass is tested)
> as some TPM 2.0 devices does not export event log
> (/sys/kernel/security/tpm0/binary_bios_measurements).
> This does not require evmctl at all.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v2->v3:
> * separate testing real HW and IMA TPM-bypass into it's own functions
> * fixed checking in check_evmctl
> * improve get_tpm_version to not depend on having dmesg on IMA TPM-bypass
> 
> Kind regards,
> Petr

