From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 May 2018 18:47:36 +0300
Subject: [LTP] [RFC PATCH v5 2/5] tst_test.sh: Warn about using
 "private" variable or function
In-Reply-To: <20180525215725.7218-3-pvorel@suse.cz>
References: <20180525215725.7218-1-pvorel@suse.cz>
 <20180525215725.7218-3-pvorel@suse.cz>
Message-ID: <9c849736-05c7-5725-f436-3c252988784a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26.05.2018 00:57, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_test.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 337d33ca4..de5d65039 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -260,6 +260,10 @@ tst_run()
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
>  			esac
>  		done
> +
> +		for _tst_i in $(grep _tst_ "$TST_TEST_PATH" | sed 's/.*_tst_//; s/[="} \t\/:`].*//'); do
> +			tst_res TWARN "Private variable or function _tst_$_tst_i used!"

Hi Petr,


For example "do_virt_dev_tst_01()" function name in the test, it is
also a private function name?


> +		done
>  	fi
>  
>  	OPTIND=1
> 

