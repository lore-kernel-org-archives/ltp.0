From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 26 Aug 2020 18:15:42 -0400
Subject: [LTP] [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
In-Reply-To: <20200820090824.3033-5-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-5-pvorel@suse.cz>
Message-ID: <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2020-08-20 at 11:08 +0200, Petr Vorel wrote:

> @@ -63,4 +73,50 @@ test1()
>  	tst_res TPASS "specified keyrings were measured correctly"
>  }
> 
> +# Create a new keyring, import a certificate into it, and verify
> +# that the certificate is measured correctly by IMA.
> +test2()
> +{
> +	tst_require_cmds evmctl keyctl openssl
> +
> +	local cert_file="$TST_DATAROOT/x509_ima.der"
> +	local keyring_name="key_import_test"
> +	local temp_file="file.txt"
> +
> +	tst_res TINFO "verify measurement of certificate imported into a keyring"
> +
> +	if ! check_ima_policy_content "^measure.*func=KEY_CHECK.*keyrings=.*$keyring_name"; then
> +		tst_brk TCONF "IMA policy does not contain $keyring_name keyring"
> +	fi
> +
> +	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
> +		tst_brk TBROK "unable to create a new keyring"
> +
> +	if ! tst_is_num $KEYRING_ID; then
> +		tst_brk TBROK "unable to parse the new keyring id ('$KEYRING_ID')"
> +	fi
> +

Instead of using TST_DATAROOT, which is defined as
"$LTPROOT/datafiles", use LTPROOT directly to define the path to the
cert.  Adding the following will allow the test to run from the build
directory.
 
      if [ ! -f $cert_file ]; then
              cert_file="$LTPROOT/../datafiles/ima_keys/x509_ima.der"
      fi

Mimi

> +	evmctl import $cert_file $KEYRING_ID > /dev/null || \
> +		tst_brk TBROK "unable to import a certificate into $keyring_name keyring"
> +

