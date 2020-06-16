From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Jun 2020 12:26:18 +0200
Subject: [LTP] [PATCH v2 2/2] IMA: Add a test to verify importing a
 certificate into keyring
In-Reply-To: <20200612143842.3993-3-t-josne@linux.microsoft.com>
References: <20200612143842.3993-1-t-josne@linux.microsoft.com>
 <20200612143842.3993-3-t-josne@linux.microsoft.com>
Message-ID: <20200616102618.GA4513@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lachlan,

few details (all can be fixed by me before merge, no need to repost).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -5,10 +5,12 @@

>  # Verify that keys are measured correctly based on policy.

> -TST_NEEDS_CMDS="awk cut xxd"
> -TST_CNT=1
> +TST_NEEDS_CMDS="awk cut xxd keyctl evmctl openssl cmp"
TST_NEEDS_CMDS="awk cmp cut evmctl keyctl openssl sed xxd"
(I ignore tail, if there is cut, sed and openssl it should be there,
the same rule as for grep).

> +TST_CNT=2
>  TST_NEEDS_DEVICE=1

> +CERT_FILE="${CERT_FILE:-}/etc/keys/x509_ima.der"
I'm sorry, I was wrong, this must be:
CERT_FILE="${CERT_FILE:-/etc/keys/x509_ima.der}"

> +
>  . ima_setup.sh

>  # Based on https://lkml.org/lkml/2019/12/13/564.
> @@ -62,4 +64,43 @@ test1()
>  	tst_res TPASS "specified keyrings were measured correctly"
>  }

> +
> +# Test that a cert can be imported into the ".ima" keyring correctly.
> +test2() {
> +	local keyring_id key_id test_file="$PWD/test.txt"
nit: Can test_file use relative path?
local test_file="test.txt"

Kind regards,
Petr
