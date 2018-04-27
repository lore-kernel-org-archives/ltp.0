From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 27 Apr 2018 09:46:23 -0400
Subject: [LTP] [COMMITTED] [PATCH 1/1] ima/ima_measurements.sh: Add info
 about tests expecting tcb policy
In-Reply-To: <20180427134333.29017-1-pvorel@suse.cz>
References: <20180427134333.29017-1-pvorel@suse.cz>
Message-ID: <1524836783.3416.57.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2018-04-27 at 15:43 +0200, Petr Vorel wrote:
> IMA tests assume tcb policy [1]. But only measurement tests are failing,
> let's puts the info only for them.
> 
> This should be better detected [1] as after tests running for first time
> tcb policy is loaded by ima_policy.sh test.
> 
> Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> [1] https://lists.linux.it/pipermail/ltp/2018-April/007924.html
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/security/integrity/ima/tests/ima_measurements.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> index 294e29d30..88eabd2a3 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> @@ -37,6 +37,8 @@ setup()
>  	DIGEST_INDEX=
>  	grep -q "ima-ng" $ASCII_MEASUREMENTS && DIGEST_INDEX=1
>  	grep -q "ima-sig" $ASCII_MEASUREMENTS && DIGEST_INDEX=2
> +
> +	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (ima_policy=tbc)"
>  }

^tcb

>  # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160

