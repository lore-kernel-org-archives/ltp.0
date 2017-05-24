From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 24 May 2017 17:38:09 +0800
Subject: [LTP] [PATCH] memcg_lib.sh: cosmetic fix for
 orig_memory_use_hierarchy variable
In-Reply-To: <1493344361-3181-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1493344361-3181-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <59255481.3020100@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

Ping :-)

Thanks,
Xiao Yang
On 2017/04/28 9:52, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index b785fe3..d4724c3 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -506,7 +506,7 @@ setup_test()
>  	# while there are distributions (RHEL7U0Beta for example) that sets
>  	# it to 1.
>  	orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)
> -	if [ -z "orig_memory_use_hierarchy" ];then
> +	if [ -z "$orig_memory_use_hierarchy" ];then
>  		tst_resm TINFO "cat /dev/memcg/memory.use_hierarchy failed"
>  	elif [ "$orig_memory_use_hierarchy" = "0" ];then
>  		orig_memory_use_hierarchy=""



