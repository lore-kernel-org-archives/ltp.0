From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 10 May 2021 07:47:11 -0700
Subject: [LTP] [PATCH v4 1/3] ima_keys.sh: Check policy only once
In-Reply-To: <20210507191414.14795-2-pvorel@suse.cz>
References: <20210507191414.14795-1-pvorel@suse.cz>
 <20210507191414.14795-2-pvorel@suse.cz>
Message-ID: <f22e507d-1983-b7a0-b5e0-15e1519ca038@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 5/7/21 12:14 PM, Petr Vorel wrote:
> Not needed to check the same policy twice.
> Rename to contain 'require' as we use tst_brk.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> new in v4
> 
>   .../security/integrity/ima/tests/ima_keys.sh       | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index 9951ab999..3476b8007 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -1,7 +1,7 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   # Copyright (c) 2020 Microsoft Corporation
> -# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
>   # Author: Lachlan Sneff <t-josne@linux.microsoft.com>
>   #
>   # Verify that keys are measured correctly based on policy.
> @@ -20,6 +20,7 @@ REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
>   setup()
>   {
>   	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
> +	require_valid_policy_template
>   }
>   
>   cleanup()
> @@ -27,15 +28,14 @@ cleanup()
>   	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
>   }
>   
> -check_policy_template()
> +
> +require_valid_policy_template()
>   {
>   	while read line; do
>   	if echo $line | grep -q 'template=' && ! echo $line | grep -q 'template=ima-buf'; then
> -		tst_res TCONF "only template=ima-buf can be specified for KEY_CHECK"
> -		return 1
> +		tst_brk TCONF "only template=ima-buf can be specified for KEY_CHECK"
>   	fi
>   	done < $TST_TMPDIR/policy.txt
> -	return 0
>   }
>   
>   check_keys_policy()
> @@ -59,8 +59,6 @@ test1()
>   
>   	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
>   
> -	check_policy_template || return
> -
>   	check_keys_policy "$pattern" > $tmp_file || return
>   	keycheck_lines=$(cat $tmp_file)
>   	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
> @@ -115,8 +113,6 @@ test2()
>   
>   	tst_res TINFO "verify measurement of certificate imported into a keyring"
>   
> -	check_policy_template || return
> -
>   	check_keys_policy "$pattern" >/dev/null || return
>   
>   	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
> 

