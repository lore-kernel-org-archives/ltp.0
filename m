From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 27 Apr 2018 07:26:52 -0400
Subject: [LTP] [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
In-Reply-To: <20180427095140.y6nngyv4ldjvitc6@dell5510>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180427095140.y6nngyv4ldjvitc6@dell5510>
Message-ID: <1524828412.3416.31.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, 2018-04-27 at 11:51 +0200, Petr Vorel wrote:
[...]
>  ima_cleanup()
> diff --git testcases/kernel/security/integrity/ima/tests/ima_tpm.sh testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index 0124c338f..0ffc3c022 100755
> --- testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -69,7 +69,7 @@ validate_pcr()
>  		grep 'HW PCR-10:' | awk '{print $3}')"
>  	if [ -z "$aggregate_pcr" ]; then
>  		tst_res TFAIL "failed to get PCR-10"
> -		return
> +		return 1
>  	fi
> 
>  	while read line; do
> 

        aggregate_pcr="$(evmctl -v ima_measurement
$BINARY_MEASUREMENTS 2>&1 | \
                grep 'HW PCR-10:' | awk '{print $3}')"

This works properly with the "ima-ng" template and even the "ima-sig"
template, without any signatures or keys.  With the "ima-sig" there
will be some informational/warning messages.  Even with the warnings,
we can still validate the measurement list PCR value.

The last two records will contain the calculated aggregate PCR value
and the real HW PCR value. 

example 1: evmctl without any keys
[...]
Failed to open keyfile: /etc/keys/x509_evm.der
PCRAgg 10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b
HW PCR-10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b

example 2: evmctl missing some keys
key 1: 6e6c1046 /etc/keys/ima/<additional key>
[...]
/usr/lib64/evolution/plugins/liborg-gnome-email-custom-header.so: RSA_public_decrypt() failed: -1
/usr/lib64/evolution/plugins/liborg-gnome-external-editor.so: RSA_public_decrypt() failed: -1
PCRAgg 10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b
HW PCR-10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b

example 3: evmctl with all keys ("-k" option) 
key 1: 6e6c1046 /etc/keys/ima/<distro key>
key 2: c4e2426e /etc/keys/ima/<additional key>
PCRAgg 10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b
HW PCR-10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b

Mimi

