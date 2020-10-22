From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Oct 2020 16:52:18 +0300
Subject: [LTP] [PATCH] route{4,6}-rmmod: Filter out ":" and fix typos
In-Reply-To: <1603361548-1534-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1603361548-1534-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <e0bdc892-6ade-f694-7c14-ca7ef7cb052f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 22.10.2020 13:12, Feiyu Zhu wrote:
> Reported-by: Jin Cao <caoj.fnst@cn.fujitsu.com>
> Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
> ---
>  testcases/network/stress/route/route4-rmmod | 4 ++--
>  testcases/network/stress/route/route6-rmmod | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
> index 7aa1958..1ba255e 100644
> --- a/testcases/network/stress/route/route4-rmmod
> +++ b/testcases/network/stress/route/route4-rmmod
> @@ -164,14 +164,14 @@ do_setup()
>      lhost_module=`ethtool -i $lhost_ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
>  
>      # Chack the other active interface uses the same driver
> -    for ifname in `ifconfig | grep ^eth | awk '{ print $1}'`; do
> +    for ifname in `ifconfig | grep ^eth | awk '{print $1}' | sed "s/://"`; do

Thanks for fixing it, but it is not enough here. This command is wrong,
not only does it use obsolete tool, but also assumes that interface
names start with 'eth'. So it skips the check for active connections
that already in use with the driver (it is going to remove) for all
modern systems.

I think we should at least remove this test from the runtest file
until the proper fix. Also this test and route4{6}-redirect are
really need to be rewritten with new test API, please have a look
at route-change-*.sh.


>  	if [ $lhost_ifname = $ifname ]; then
>  	    continue
>  	fi
>  
>  	module=`ethtool -i $ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
>  	if [ $lhost_module = $module ]; then
> -	    tst_resm TBROK "An active interface $ifname uses the same network deriver $module with the test intreface."
> +	    tst_resm TBROK "An active interface $ifname uses the same network driver $module with the test interface."
>  	    exit $TST_TOTAL
>  	fi
>      done
> diff --git a/testcases/network/stress/route/route6-rmmod b/testcases/network/stress/route/route6-rmmod
> index 765a57a..146fa77 100644
> --- a/testcases/network/stress/route/route6-rmmod
> +++ b/testcases/network/stress/route/route6-rmmod
> @@ -160,14 +160,14 @@ do_setup()
>      lhost_module=`ethtool -i $lhost_ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
>  
>      # Chack the other active interface uses the same driver
> -    for ifname in `ifconfig | grep ^eth | awk '{ print $1}'`; do
> +    for ifname in `ifconfig | grep ^eth | awk '{print $1}' | sed "s/://"`; do
>  	if [ $lhost_ifname = $ifname ]; then
>  	    continue
>  	fi
>  
>  	module=`ethtool -i $ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
>  	if [ $lhost_module = $module ]; then
> -	    tst_resm TBROK "An active interface $ifname uses the same network deriver $module with the test intreface."
> +	    tst_resm TBROK "An active interface $ifname uses the same network driver $module with the test interface."
>  	    exit $TST_TOTAL
>  	fi
>      done
> 

