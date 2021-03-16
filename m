From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 16 Mar 2021 09:25:30 -0700
Subject: [LTP] [PATCH 2/2] IMA/ima_keys.sh: Require evmctl 1.3.2
In-Reply-To: <20210316150600.16461-2-pvorel@suse.cz>
References: <20210316150600.16461-1-pvorel@suse.cz>
 <20210316150600.16461-2-pvorel@suse.cz>
Message-ID: <cedd3e94-8374-9600-96b2-a14412e22e14@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 3/16/21 8:06 AM, Petr Vorel wrote:
> Test requires fix 19b77c8 ("ima-evm-utils: Fix reading of sigfile").
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index c9eef4b68..aba1711a5 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -92,7 +92,9 @@ test1()
>   # that the certificate is measured correctly by IMA.
>   test2()
>   {
> -	tst_require_cmds evmctl keyctl openssl
> +	tst_require_cmds keyctl openssl
> +
> +	require_evmctl "1.3.2"
>   
>   	local cert_file="$TST_DATAROOT/x509_ima.der"
>   	local keyring_name="key_import_test"
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

