From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Jul 2020 09:55:39 +0200
Subject: [LTP] [PATCH v4 1/2] IMA: Add a test to verify measurment of
 keys
In-Reply-To: <20200626021126.56760-2-t-josne@linux.microsoft.com>
References: <20200626021126.56760-1-t-josne@linux.microsoft.com>
 <20200626021126.56760-2-t-josne@linux.microsoft.com>
Message-ID: <20200714075539.GA23472@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lachlan,

...
> +# Based on https://lkml.org/lkml/2019/12/13/564.
> +# (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
> +test1()
> +{
> +	local keyrings keycheck_lines keycheck_line templates test_file="file.txt"
$keycheck_lines and $keycheck_line are a bit hard to distinguish, but we already
use $line later on, thus let's keep it.
> +
> +	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
> +
> +	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
> +
> +	[ -r $IMA_POLICY ] || tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
> +
> +	keycheck_lines=$(grep "func=KEY_CHECK" $IMA_POLICY)
> +	if [ -z "$keycheck_lines" ]; then
> +		tst_brk TCONF "ima policy does not specify \"func=KEY_CHECK\""
> +	fi
> +
> +	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
> +
> +	if [ -z "$keycheck_line" ]; then
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
> +	success=true
> +
> +	grep -E "($templates)*($keyrings)" $ASCII_MEASUREMENTS | while read line
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
> +			$success=false
$success=false is wrong, success=false must be used. And it's not defined as
local. And also although it's working this way, LTP shell code style is using
1/empty, not true/false. Can you use:
			fail=1

And also, does it make sense to continue evaluating on error? If not (not sure
myself) return after tst_res TFAIL would be the best.

> +			tst_res TFAIL "incorrect digest was found for the ($keyring) keyring"
> +		fi
> +	done
> +
> +	if $success; then
and here:
if [ "$fail" ]; then
> +		tst_res TPASS "specified keyrings were measured correctly"
> +	fi
...

The rest looks ok to me (no need to repost new version just for this).

Kind regards,
Petr
