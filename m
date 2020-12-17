From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 17 Dec 2020 13:12:36 -0500
Subject: [LTP] [PATCH v5 3/4] ima_tpm.sh: Fix calculating boot aggregate
In-Reply-To: <20201214221946.6340-4-pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
 <20201214221946.6340-4-pvorel@suse.cz>
Message-ID: <25e41786777f814455780915dfe1bc2c769dc99c.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> for TPM 2.0 or kernel >= v5.8-rc1:
> 6f1a1d103b48 ima: ("Switch to ima_hash_algo for boot aggregate")
> 
> Test still fails with newer TPM 2.0 on kernel < v5.8-rc1.

The above commit was backported in stable.  Do you know if the failing
systems backported the above patch?   I've recently asked for commit
20c59ce010f8 ("ima: extend boot_aggregate with kernel measurements")
also be backported.

> 
> Test was failing, because it expect SHA1 (we ignore MD5) hash, but for TPM 2.0
> is now used IMA default hash algorithm (by default default SHA256).
> This is similar for entries in IMA measurement list so we can reuse
> already existing code.
> 
> Reading other algorithms than SHA1 or support TPM 2.0 requires evmctl
> >= 1.3.1 (1.3 would also work for test1, but will be required for test2).
> 
> Although recent evmctl is recommended, to support older kernels and TPMs
> which support only SHA1, get boot aggregate with old our legacy
> ima_boot_aggregate.c.

^ the LTP legacy ima_boot_aggregate.c still works, without the evmctl
dependency.

> 
> Also fixed cases:
> * testing with no TPM device:
> * TPM TPM 2.0 devices which does not export event log
> (/sys/kernel/security/tpm0/binary_bios_measurements).

^ firmware which does not export the TPM 2.0 binary event log

> 
> Also fixed test without TPM device (when IMA TPM-bypass is tested)
> as some TPM 2.0 devices does not export event log
> (/sys/kernel/security/tpm0/binary_bios_measurements).

This looks like a duplicate of above.  Maybe just add another bullet
*
detecting IMA TPM-bypass mode

> This does not require evmctl at all.

I assume this comment refers to TPM 2.0 calculating the
"boot_aggregate" based on the existing PCR values, as opposed to TPM
1.2 which first walks the TPM event log, calculating the PCRs.

> 
> Also try best to detect TPM major version (1, 2 or none - assume
> TPM-bypass). This fixes testing with TPM 2.0 device which does not
> export event log (/sys/kernel/security/tpm0/binary_bios_measurements):
> not wrongly assuming TPM-bypass when kernel didn't export other TPM
> 2.0 files we check in get_tpm_version() but bios boot aggregate is
> correct (i.e. not 0x00s). In that case evmctl ima_boot_aggregate can get
> boot aggregate even without TPM event log.
> 
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr!

Mimi

