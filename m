From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 24 Jun 2020 12:41:08 -0400
Subject: [LTP] [PATCH v3 2/2] IMA: Add a test to verify importing a
 certificate into keyring
In-Reply-To: <20200617234957.10611-3-t-josne@linux.microsoft.com>
References: <20200617234957.10611-1-t-josne@linux.microsoft.com>
 <20200617234957.10611-3-t-josne@linux.microsoft.com>
Message-ID: <1593016868.27152.88.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lachlan,

On Wed, 2020-06-17 at 19:49 -0400, Lachlan Sneff wrote:
> Add an IMA measurement test that verifies that an x509 certificate
> can be imported into the .ima keyring and measured correctly.

Please expand this, explaining that the x509 certificate needs to be
signed by a key on one of the trusted keyrings.

Once there is a reliable way of adding a key to the IMA keyring, this
opens up a lot of other testing possibilities.

> 
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> ---
>  .../kernel/security/integrity/ima/README.md   | 21 +++++++++
>  .../security/integrity/ima/tests/ima_keys.sh  | 47 ++++++++++++++++++-
>  2 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
> index 16a1f48c3..e41f7b570 100644
> --- a/testcases/kernel/security/integrity/ima/README.md
> +++ b/testcases/kernel/security/integrity/ima/README.md
> @@ -16,6 +16,27 @@ CONFIG_INTEGRITY=y
>  CONFIG_IMA=y
>  ```
>  
> +IMA Key Import test
> +-------------
> +
> +`ima_keys.sh` requires an x509 key to be generated and placed
> +at `/etc/keys/x509_ima.der`.

The filename "/etc/keys/x509_ima.der" is configurable. ?It's based on
CONFIG_IMA_X509_PATH Kconfig option. ?Perhaps extract it from the
running kernel's Kconfig?

> +
> +The x509 public key key must be signed by the private key you generate.
> +Follow these instructions:
> +https://manpages.ubuntu.com/manpages/disco/man1/evmctl.1.html#generate%20trusted%20keys.
> +
> +The test cannot be set-up automatically because the kernel must be built
> +with one of the keys you generate.

Please reword this to convey that the public key must be built into
the kernel and loaded onto a trusted keyring (eg.
.builtin_trusted_keys, .secondary_trusted_keyring)

> +
> +As well as what's required for the IMA tests, the following are also required
> +in the kernel configuration:
> +```
> +CONFIG_IMA_READ_POLICY=y
> +CONFIG_SYSTEM_TRUSTED_KEYRING=y
> +CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
> +```
> +
>  EVM tests
>  ---------
>  
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index 2b5324dbf..1d9824aba 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -5,10 +5,12 @@
>  #
>  # Verify that keys are measured correctly based on policy.
>  
> -TST_NEEDS_CMDS="grep mktemp cut sed tr"
> -TST_CNT=1
> +TST_NEEDS_CMDS="grep mktemp cut sed tr xxd keyctl evmctl openssl cmp"
> +TST_CNT=2
>  TST_NEEDS_DEVICE=1
>  
> +CERT_FILE="${CERT_FILE:-/etc/keys/x509_ima.der}"
> +
>  . ima_setup.sh
>  
>  # Based on https://lkml.org/lkml/2019/12/13/564.
> @@ -64,4 +66,45 @@ test1()
>  	tst_res TPASS "specified keyrings were measured correctly"
>  }
>  
> +
> +# Test that a cert can be imported into the ".ima" keyring correctly.
> +test2() {
> +	local keyring_id key_id test_file=$(mktemp)
> +
> +	[ -f $CERT_FILE ] || tst_brk TCONF "missing $CERT_FILE"
> +
> +	if ! openssl x509 -in $CERT_FILE -inform der > /dev/null; then
> +		tst_brk TCONF "The suppled cert file ($CERT_FILE) is not a valid x509 certificate"
> +	fi
> +
> +	tst_res TINFO "adding a cert to the .ima keyring ($CERT_FILE)"
> +
> +	keyring_id=$(keyctl show %:.ima | sed -n 2p | \
> +		sed 's/^[[:space:]]*//' | cut -d' ' -f1) || \
> +		tst_btk TCONF "unable to retrieve .ima keyring id"

Using "keyctl describe" returns the keyring id as the first token,
making it simpler to parse.

Mimi

> +
> +	if ! tst_is_num	"$keyring_id"; then
> +		tst_brk TCONF "unable to parse keyring id from keyring"
> +	fi
> +
> +	evmctl import $CERT_FILE "$keyring_id" > /dev/null || \
> +		tst_brk TCONF "unable to import a cert into the .ima keyring"
> +
> +	grep -F ".ima" "$ASCII_MEASUREMENTS" | tail -n1 | cut -d' ' -f6 | \
> +		xxd -r -p > $test_file || \
> +		tst_brk TCONF "cert not found in ascii_runtime_measurements log"
> +
> +	if ! openssl x509 -in $test_file -inform der > /dev/null; then
> +		tst_brk TCONF "The cert logged in ascii_runtime_measurements is not a valid x509 certificate"
> +	fi
> +
> +	if cmp -s "$test_file" $CERT_FILE; then
> +		tst_res TPASS "logged cert matches original cert"
> +	else
> +		tst_res TFAIL "logged cert does not match original cert"
> +	fi
> +
> +	rm $test_file
> +}
> +
>  tst_run

