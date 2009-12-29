Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lizf@cn.fujitsu.com>) id 1NPYGM-0000FV-55
	for ltp-list@lists.sourceforge.net; Tue, 29 Dec 2009 09:21:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NPYGK-0005mW-5r
	for ltp-list@lists.sourceforge.net; Tue, 29 Dec 2009 09:21:10 +0000
Message-ID: <4B39C9F4.1030708@cn.fujitsu.com>
Date: Tue, 29 Dec 2009 17:20:52 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B388C81.80903@linux.vnet.ibm.com>
In-Reply-To: <4B388C81.80903@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH 2/2] Added check for memory controller (
 functional, regression & stress )
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: risrajak@in.ibm.com, LTP <ltp-list@lists.sourceforge.net>, iranna.ankad@in.ibm.com

> commit fe4599d210be37a7d1bb2d6a5523b9e29bbd87e1
> Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
> Date:   Mon Dec 28 15:11:54 2009 +0530
> 
>     Added check for regression and funcitonal memcg test
> 

You should add your Signed-off-by.

> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> index 003af1c..303661c 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> @@ -28,8 +28,8 @@ export TCID="memcg_function_test"
>  export TST_TOTAL=38
>  export TST_COUNT=0
>  
> -grep -w memory /proc/cgroups 2>&1 > /dev/null
> -if [ $? -ne 0 ]; then
> +if [ `grep -w memory /proc/cgroups | cut -f4` == 0 ]

What if memory cgroup is not compiled? So the correct check should be:

if [ ! "grep -w memory /proc/cgroups | cut -f4" == "1" ]
then
	...
fi

> +then
>  	echo "WARNING:";
>  	echo "Kernel does not support for memory resource controller";
>  	echo "Skipping all memcgroup testcases....";
> diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> index 6bf7c88..0bc3d75 100755
> --- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> +++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> @@ -33,6 +33,15 @@ if [ "$USER" != root ]; then
>  	exit 0
>  fi
>  
> +if [ `grep -w memory /proc/cgroups | cut -f4` == 0 ]
> +then
> +        echo "WARNING:";
> +        echo "Kernel does not support for memory resource controller";
> +        echo "Skipping all memcgroup testcases....";
> +        exit 0
> +fi

ditto

> +
> +
>  tst_kvercmp 2 6 30
>  if [ $? -eq 0 ]; then
>  	tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
> diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> index 7244a16..c155bf1 100755
> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> @@ -28,14 +28,15 @@ export TCID="memcg_stress_test"
>  export TST_TOTAL=2
>  export TST_COUNT=0
>  
> -grep -w memory /proc/cgroups 2>&1 > /dev/null
> -if [ $? -ne 0 ]; then
> -	echo "WARNING:";
> -	echo "Kernel does not support for memory resource controller";
> -	echo "Skipping all memcgroup testcases....";
> -	exit 0
> +if [ `grep -w memory /proc/cgroups | cut -f4` == 0 ]
> +then
> +        echo "WARNING:";
> +        echo "Kernel does not support for memory resource controller";
> +        echo "Skipping all memcgroup testcases....";
> +        exit 0
>  fi

ditto

>  
> +
>  RUN_TIME=$(( 60 * 60 ))
>  
>  cleanup()


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
