From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jun 2018 11:06:18 +0200
Subject: [LTP] [PATCH ltp] controllers/cpuset/cpuset_regression_test.sh:
 fix shellcheck error
In-Reply-To: <20180525074406.24422-1-yixin.zhang@intel.com>
References: <20180525074406.24422-1-yixin.zhang@intel.com>
Message-ID: <20180625090618.72uct6jf7mkhudzy@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yixin,

> testcases/kernel/controllers/cpuset/cpuset_regression_test.sh:89:10:error:
> -n doesn't work with unquoted arguments. Quote or use [[ ]]. [SC2070]

> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>  testcases/kernel/controllers/cpuset/cpuset_regression_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> index 4a104a3ad..249f16a76 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> @@ -86,7 +86,7 @@ cleanup()
>  		rmdir ${root_cpuset_dir}/testdir
>  	fi

> -	if [ -n ${cpu_exclusive_value} -a ${cpu_exclusive_value} -ne 1 ]; then
> +	if [ -n "${cpu_exclusive_value}" ] && [ ${cpu_exclusive_value} -ne 1 ]; then
>  		# Need to flush, or may be output:
>  		# "write error: Device or resource busy"
>  		sync

Thanks for your patch, pushed.

I dared to simplify the expression (see bellow, this is posix compliant as well,
we use it in LTP) + shorten commit message title a bit. Hope you don't mind.

if [ "$cpu_exclusive_value" != 1 ]; then

BTW this tests also needs to be rewritten to new shell API.

Kind regards,
Petr
