Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fenggw-fnst@cn.fujitsu.com>) id 1ZXlTT-0002HO-HQ
	for ltp-list@lists.sourceforge.net; Fri, 04 Sep 2015 07:31:51 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZXlTQ-0000WT-Qa
	for ltp-list@lists.sourceforge.net; Fri, 04 Sep 2015 07:31:51 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t847VTRS021511
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Sep 2015 15:31:29 +0800
Message-ID: <55E94929.7060903@cn.fujitsu.com>
Date: Fri, 4 Sep 2015 15:32:57 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1440410664-10266-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
In-Reply-To: <1440410664-10266-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] cpuhotplug_hotplug.sh: fix the return of cpu
	number
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
To: ltp-list@lists.sourceforge.net

Hello!
    ping.

Best Regards,
Guangwen Feng

On 2015/08/24 18:04, Guangwen Feng wrote:
> In shell, function's return value can not exceed 255, if we run
> the test on machines which have more than 255 cpus, the result
> will be incorrect, so fix that by using global variable instead.
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh   | 2 +-
>  testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh   | 2 +-
>  testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh   | 2 +-
>  testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh   | 4 ++--
>  testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh   | 2 +-
>  testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh   | 2 +-
>  testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh   | 2 +-
>  .../kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh      | 8 ++++----
>  8 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
> index 8ae1379..e75da21 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
> @@ -112,7 +112,7 @@ LOOP_COUNT=1
>  tst_check_cmds perl
>  
>  get_present_cpus_num
> -if [ $? -lt 2 ]; then
> +if [ $PRESENT_CPUS_NUM -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi
>  
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
> index c42cc1b..f6b4345 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
> @@ -55,7 +55,7 @@ done
>  LOOP_COUNT=1
>  
>  get_present_cpus_num
> -if [ $? -lt 2 ]; then
> +if [ $PRESENT_CPUS_NUM -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi
>  
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
> index 3469b10..a68ac7d 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
> @@ -64,7 +64,7 @@ done
>  LOOP_COUNT=1
>  
>  get_present_cpus_num
> -cpus_num=$?
> +cpus_num=${PRESENT_CPUS_NUM}
>  if [ $cpus_num -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
> index 58a822e..3ecbb36 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
> @@ -49,13 +49,13 @@ done
>  LOOP_COUNT=1
>  
>  get_present_cpus_num
> -cpus_num=$?
> +cpus_num=${PRESENT_CPUS_NUM}
>  if [ $cpus_num -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi
>  
>  get_hotplug_cpus_num
> -if [ $? -lt 1 ]; then
> +if [ $HOTPLUG_CPUS_NUM -lt 1 ]; then
>  	tst_brkm TCONF "system doesn't have at least one hotpluggable CPU"
>  fi
>  
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> index 60382c8..8009af2 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> @@ -56,7 +56,7 @@ LOOP_COUNT=1
>  tst_check_cmds sar
>  
>  get_present_cpus_num
> -if [ $? -lt 2 ]; then
> +if [ $PRESENT_CPUS_NUM -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi
>  
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> index 6710fad..5e71abf 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> @@ -50,7 +50,7 @@ done
>  LOOP_COUNT=1
>  
>  get_present_cpus_num
> -if [ $? -lt 2 ]; then
> +if [ $PRESENT_CPUS_NUM -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi
>  
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
> index 7edb3a9..81dc225 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
> @@ -56,7 +56,7 @@ done
>  LOOP_COUNT=1
>  
>  get_present_cpus_num
> -if [ $? -lt 2 ]; then
> +if [ $PRESENT_CPUS_NUM -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi
>  
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> index 6920393..be8bce2 100644
> --- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> @@ -165,11 +165,11 @@ get_present_cpus()
>  
>  # get_present_cpus_num()
>  #
> -#  Prints the number of present CPUs
> +#  Gets the number of present CPUs
>  #
>  get_present_cpus_num()
>  {
> -    return $(get_present_cpus | wc -w)
> +	PRESENT_CPUS_NUM=`get_present_cpus | wc -w`
>  }
>  
>  # get_hotplug_cpus()
> @@ -192,11 +192,11 @@ get_hotplug_cpus()
>  
>  # get_hotplug_cpus_num()
>  #
> -#  Prints the number of hotpluggable CPUs
> +#  Gets the number of hotpluggable CPUs
>  #
>  get_hotplug_cpus_num()
>  {
> -    return $(get_hotplug_cpus | wc -w)
> +	HOTPLUG_CPUS_NUM=`get_hotplug_cpus | wc -w`
>  }
>  
>  # get_all_cpu_states()
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
