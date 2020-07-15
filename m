From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 14 Jul 2020 20:41:03 -0400
Subject: [LTP] [PATCH v4 2/2] IMA: Add a test to verify importing a
 certificate into keyring
In-Reply-To: <20200626021126.56760-3-t-josne@linux.microsoft.com>
References: <20200626021126.56760-1-t-josne@linux.microsoft.com>
 <20200626021126.56760-3-t-josne@linux.microsoft.com>
Message-ID: <1594773663.12900.215.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2020-06-25 at 22:11 -0400, Lachlan Sneff wrote:
> Add an IMA measurement test that verifies that an x509 certificate
> can be imported into the .ima keyring and measured correctly.
> 
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> ---
>  .../kernel/security/integrity/ima/README.md   | 22 ++++++++++
>  .../security/integrity/ima/tests/ima_keys.sh  | 44 ++++++++++++++++++-
>  2 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
> index 16a1f48c3..9e6790306 100644
> --- a/testcases/kernel/security/integrity/ima/README.md
> +++ b/testcases/kernel/security/integrity/ima/README.md
> @@ -16,6 +16,28 @@ CONFIG_INTEGRITY=y
>  CONFIG_IMA=y
>  ```
>  
> +IMA Key Import test
> +-------------
> +`ima_keys.sh` requires an x509 certificate to be signed by a key on one
> +of the trusted keyrings. The x509 certificate must be placed at
> +`/etc/keys/x509_ima.der` for this test or the path must be passed in
> +the CERT_FILE env var.
> +
> +The x509 public key key must be signed by the private key you generate.
> +Follow these instructions:
> +https://manpages.ubuntu.com/manpages/disco/man1/evmctl.1.html#generate%20trusted%20keys.
> +
> +The test cannot be set-up automatically because the x509 public key must be
> +built into the kernel and loaded onto a trusted keyring.
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
> index 94eb15e09..499881251 100755
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
> @@ -69,4 +71,42 @@ test1()
>  	fi
>  }
>  
> +
> +# Test that a cert can be imported into the ".ima" keyring correctly.
> +test2() {
> +	local keyring_id key_id test_file="file.txt"
> +
> +	[ -f $CERT_FILE ] || tst_brk TCONF "missing $CERT_FILE"
> +
> +	if ! openssl x509 -in $CERT_FILE -inform der > /dev/null; then
> +		tst_brk TCONF "The suppled cert file ($CERT_FILE) is not a valid x509 certificate"
> +	fi
> +
> +	tst_res TINFO "adding a cert to the .ima keyring ($CERT_FILE)"

Above this line there is some extraneous whitespace.

> +	
> +	keyring_id=$(keyctl describe %:.ima | cut -d' ' -f2 | tr -d ':') || \
> +		tst_btk TCONF "unable to retrieve .ima keyring id"

It seems "keyctl describe" is returning different things depending on
the version. ?You must be seeing 2 spaces before the keyring id. ?On
Ubuntu 20.0, I'm seeing the keyring id indented with 3 spaces.??On an
older Fedora, there are no spaces.??Try reversing the cut and tr
delimiters.

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

The original CERT_FILE should have been measured on boot. ?In fact, it
should have been the first key on the .ima keyring to be measured.
?Unless the CERT_FILE changed, importing it again shouldn't cause
another record to be added to the measurement list. ?Exporting the
last imported key onto the .ima keyring won't work.

> +
> +	if ! openssl x509 -in $test_file -inform der > /dev/null; then
> +		tst_brk TCONF "The cert logged in ascii_runtime_measurements is not a valid x509 certificate"
> +	fi
> +
> +	if cmp -s "$test_file" $CERT_FILE; then
> +		tst_res TPASS "logged cert matches original cert"
> +	else
> +		tst_res TFAIL "logged cert does not match original cert"

This is failing due to the above reason.

Mimi

> +	fi
> +}
> +
>  tst_run

