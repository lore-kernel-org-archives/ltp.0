From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 24 Jun 2020 09:21:41 -0400
Subject: [LTP] [PATCH v3 1/2] IMA: Add a test to verify measurment of
 keys
In-Reply-To: <20200617234957.10611-2-t-josne@linux.microsoft.com>
References: <20200617234957.10611-1-t-josne@linux.microsoft.com>
 <20200617234957.10611-2-t-josne@linux.microsoft.com>
Message-ID: <1593004901.27152.17.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lachian,

> +
> +# Based on https://lkml.org/lkml/2019/12/13/564.
> +# (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
> +test1()
> +{
> +	local keyrings keycheck_line templates test_file=$(mktemp)
> +
> +	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
> +
> +	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
> +
> +	[ -r $IMA_POLICY ] || tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
> +
> +	keycheck_line=$(grep "func=KEY_CHECK" $IMA_POLICY)
> +	if [ -z "$keycheck_line" ]; then
> +		tst_brk TCONF "ima policy does not specify \"func=KEY_CHECK\""
> +	fi
> +
> +	if echo "$keycheck_line" | grep -q "*keyrings*"; then
> +		tst_brk TCONF "ima policy does not specify a keyrings to check"
> +	fi
> +
> +	keyrings=$(echo "$keycheck_line" | tr " " "\n" | grep "keyrings" | \
> +		sed "s/\./\\\./g" | cut -d'=' -f2)
> +	if [ -z "$keyrings" ]; then
> +		tst_brk TCONF "ima policy has a keyring key-value specifier, but no specified keyrings"
> +	fi
> +
> +	templates=$(echo "$keycheck_line" | tr " " "\n" | grep "template" | \
> +		cut -d'=' -f2)
> +
> +	grep -E "($templates)*($keyrings)" $ASCII_MEASUREMENTS | while read line

Probably because I have multiple KEY_CHECK rules, this is failing:

grep: Unmatched ( or \(

And then it continues merrily alongs its way.

ima_keys 1 TPASS: specified keyrings were measured correctly
ima_keys 2 TCONF: missing /etc/keys/x509_ima.der

Mimi

> +	do
> +		local digest expected_digest algorithm
> +
> +		digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
> +		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
> +		keyring=$(echo "$line" | cut -d' ' -f5)
> +
> +		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
> +
> +		expected_digest="$(compute_digest $algorithm $test_file)" || \
> +			tst_brk TCONF "cannot compute digest for $algorithm"
> +
> +		if [ "$digest" != "$expected_digest" ]; then
> +			tst_res TFAIL "incorrect digest was found for the ($keyring) keyring"
> +		fi
> +	done
> +
> +	rm $test_file
> +
> +	tst_res TPASS "specified keyrings were measured correctly"
> +}
