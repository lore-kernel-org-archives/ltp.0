From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 17 Dec 2020 14:16:04 -0500
Subject: [LTP] [PATCH v5 4/4] ima_tpm.sh: Fix calculating PCR aggregate
In-Reply-To: <20201214221946.6340-5-pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
 <20201214221946.6340-5-pvorel@suse.cz>
Message-ID: <b9408c3ccf8260d9a2232074c7a0433119b83d42.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> for TPM 2.0 and support more evmctl versions.
> 
> Because exporting PCR registers for TPM 2.0 has not been upstreamed [1],
> we use user space code, which requires evmctl >= 1.3.1 and tsspcrread.

Yes, really annoying.

> Using evmctl allows to test for TPM devices which does not export event
> log (/sys/kernel/security/tpm0/binary_bios_measurements).

Interesting way of phrasing the lack of a TPM 2.0 event log parser in
ima-evm-utils.   Until someone contributes a TPM 2.0 event log parser,
we're dependent on users verifying the event log against the TPM 2.0
PCR banks some other way (e.g. "tsseventextend -sim -if
/sys/kernel/security/tpm0/binary_bios_measurements -ns").

> 
> For TPM 1.2 read tpm0 device's pcrs file from sysfs. (tss1pcrread could
> be also used, but it's not yet packaged by distros.)
> 
> For old kernels which use SHA1/MD5, any evmctl version is required (evmctl
> ima_measurement was introduced in very old v0.7), but
> * newer sysctl path /sys/class/tpm/tpm0/device/pcrs requires evmctl 1.1
> * using ima_policy=tcb requires 1.3.1 due --ignore-violations
> 
> We now support output format of ima_measurement command for various
> evmctl versions:
> * 1.3: "sha256: TPM PCR-10:" (or other algorithm, e.g. "sha1:")
> * 1.1-1.2.1: "HW PCR-10:" (the only previously supported format)
> * 0.7-1.0: "PCR-10:"
> 
> NOTE: we ignore evmctl failure for evmctl < 1.3.1 (missing --ignore-violations,
> also evmctl < 1.1 fails with "PCRAgg does not match PCR-10")
> 
> As for previous commit fix testing with TPM 2.0 device which does not
> export event log (/sys/kernel/security/tpm0/binary_bios_measurements):
> not wrongly assuming TPM-bypass when kernel didn't export other TPM
> 2.0 files we check in get_tpm_version() but bios boot aggregate is
> correct (i.e. not 0x00s). In that case evmctl ima_boot_aggregate can get
> boot aggregate even without TPM event log.
> 
> [1] https://patchwork.kernel.org/patch/11759729/
> 
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr!

Other than the typo below, it looks good.

Mimi


> +test2()
>  {
> -	tst_res TINFO "verify PCR (Process Control Register)"
> +	local hash pcr_aggregate out ret
>  
> -	local dev_pcrs="$1"
> -	local pcr hash aggregate_pcr
> +	tst_res TINFO "verify PCR values"
>  
> -	aggregate_pcr="$(evmctl -v ima_measurement $BINARY_MEASUREMENTS 2>&1 | \
> -		grep 'HW PCR-10:' | awk '{print $3}')"
> -	if [ -z "$aggregate_pcr" ]; then
> -		tst_res TFAIL "failed to get PCR-10"
> -		return 1
> +	if [ "$MAYBE_TPM2" = 1 ]; then
> +		tst_res TINFO "TMP version not detected ($ERRMSG_TPM), assume TPM 2"


^ TPM  above and below

> +		TPM_VERSION=2
>  	fi
>  
> -	while read line; do
> -		pcr="$(echo $line | cut -d':' -f1)"
> -		if [ "$pcr" = "PCR-10" ]; then
> -			hash="$(echo $line | cut -d':' -f2 | awk '{ gsub (" ", "", $0); print tolower($0) }')"
> -			[ "$hash" = "$aggregate_pcr" ]
> -			return $?
> -		fi
> -	done < $dev_pcrs
> -	return 1
> -}
> +	if [ -z "$TPM_VERSION" ]; then
> +		tst_brk TCONF "TMP version not detected ($ERRMSG_TPM)"

 and here

