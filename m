From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Apr 2018 12:19:16 +0200
Subject: [LTP] [RFC PATCH 9/9] testcases: cpuset: Check if "getconf" is
 available
In-Reply-To: <20180423094639.14612-10-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-10-mylene.josserand@bootlin.com>
Message-ID: <20180423101915.GE24481@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The "getconf" binary is used by cpuset_regression_test.sh
> and may not be installed in the system. The test will fail
> but it is a misconfiguration so let's use "tst_check_cmds"
> to check if this binary is available and return a TCONF error
> if not.
> 
> Signed-off-by: Myl??ne Josserand <mylene.josserand@bootlin.com>
> ---
>  testcases/kernel/controllers/cpuset/cpuset_regression_test.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> index 4a104a3ad..96a57955c 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> @@ -34,6 +34,8 @@ setup()
>  		tst_brkm TCONF "Test must be run with kernel 3.18.0 or newer"
>  	fi
>  
> +	tst_check_cmds "getconf"
> +
>  	local cpu_num=$(getconf _NPROCESSORS_ONLN)
>  	if [ $cpu_num -lt 2 ]; then
>  		tst_brkm TCONF "We need 2 cpus at least to have test"

Hmm, or we may put something as tst_getconf.c into the
testcases/lib/ directory and implement subset of variables needed for
the tests there.

-- 
Cyril Hrubis
chrubis@suse.cz
