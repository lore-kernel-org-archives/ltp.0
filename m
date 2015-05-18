Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1YuEVD-0000VW-02
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 06:26:15 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YuEVB-0004Ug-0O
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 06:26:14 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4I6OhfZ011536
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2015 14:24:43 +0800
Message-ID: <555985D3.7070203@cn.fujitsu.com>
Date: Mon, 18 May 2015 14:25:23 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1430967285-15095-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1431928620-25592-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1431928620-25592-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] device-drivers/zram: add kernel version check
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 05/18/2015 01:57 PM, Xiaoguang Wang wrote:
> zram device attributes max_comp_streams and comp_algorithm are introduced
> since kernel v3.15, and mem_limit is introduced since kernel v3.18, we
> need to add these checks.
> 
> Also according to kernel-source-tree/Documentation/blockdev/zram.txt, zram
> device attribute disksize value can be either in bytes, or you can use mem
> suffixes. But in some old kernels, mem suffixes are not supported, for
> example, in RHEL6.6GA's kernel layer, it uses strict_strtoull() to parse
> disksize, which does not support mem suffixes, in some newer kernels, they
> use memparse() which supports mem suffixes. So here we just use bytes to make
> sure everything works correctly.

It'd be more straightforward to split to two patches, one for kernel version checking
and the other for unit change?

But anyway, looks good to me.

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


Thanks,
Wanlong Gao

> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/device-drivers/zram/zram01.sh   | 10 +++++++-
>  testcases/kernel/device-drivers/zram/zram02.sh   | 10 +++++++-
>  testcases/kernel/device-drivers/zram/zram_lib.sh | 32 +++++++++++++++++++++---
>  3 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> index 49cbbe9..26dae90 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -31,7 +31,15 @@ dev_num=4
>  # This is a list of parameters for zram devices.
>  # Number of items must be equal to 'dev_num' parameter.
>  zram_max_streams="2 3 5 8"
> -zram_sizes="25M 25M 25M 25M"
> +
> +# The zram sysfs node 'disksize' value can be either in bytes,
> +# or you can use mem suffixes. But in some old kernels, mem
> +# suffixes are not supported, for example, in RHEL6.6GA's kernel
> +# layer, it uses strict_strtoull() to parse disksize which does
> +# not support mem suffixes, in some newer kernels, they use
> +# memparse() which supports mem suffixes. So here we just use
> +# bytes to make sure everything works correctly.
> +zram_sizes="26214400 26214400 26214400 26214400" # 25MB
>  zram_mem_limits="25M 25M 25M 25M"
>  zram_filesystems="ext3 ext4 xfs btrfs"
>  zram_algs="lzo lzo lzo lzo"
> diff --git a/testcases/kernel/device-drivers/zram/zram02.sh b/testcases/kernel/device-drivers/zram/zram02.sh
> index 53f69bb..59b3f9f 100755
> --- a/testcases/kernel/device-drivers/zram/zram02.sh
> +++ b/testcases/kernel/device-drivers/zram/zram02.sh
> @@ -30,7 +30,15 @@ dev_num=1
>  # This is a list of parameters for zram devices.
>  # Number of items must be equal to 'dev_num' parameter.
>  zram_max_streams="2"
> -zram_sizes="100G"
> +
> +# The zram sysfs node 'disksize' value can be either in bytes,
> +# or you can use mem suffixes. But in some old kernels, mem
> +# suffixes are not supported, for example, in RHEL6.6GA's kernel
> +# layer, it uses strict_strtoull() to parse disksize which does
> +# not support mem suffixes, in some newer kernels, they use
> +# memparse() which supports mem suffixes. So here we just use
> +# bytes to make sure everything works correctly.
> +zram_sizes="107374182400" # 100GB
>  zram_mem_limits="1M"
>  
>  TST_CLEANUP="zram_cleanup"
> diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
> index e41d8c7..d3e62e0 100755
> --- a/testcases/kernel/device-drivers/zram/zram_lib.sh
> +++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
> @@ -62,7 +62,15 @@ zram_load()
>  
>  zram_max_streams()
>  {
> -	tst_resm TINFO "set max_comp_streams to zram device(s)"
> +	tst_kvercmp 3 15 0
> +	if [ $? -eq 0 ]; then
> +		tst_resm TCONF "device attribute max_comp_streams is"\
> +			"introduced since kernel v3.15, the running kernel"\
> +			"does not support it"
> +		return
> +	else
> +		tst_resm TINFO "set max_comp_streams to zram device(s)"
> +	fi
>  
>  	local i=0
>  	for max_s in $zram_max_streams; do
> @@ -83,7 +91,16 @@ zram_max_streams()
>  
>  zram_compress_alg()
>  {
> -	tst_resm TINFO "test that we can set compression algorithm"
> +	tst_kvercmp 3 15 0
> +	if [ $? -eq 0 ]; then
> +		tst_resm TCONF "device attribute comp_algorithm is"\
> +			"introduced since kernel v3.15, the running kernel"\
> +			"does not support it"
> +		return
> +	else
> +		tst_resm TINFO "test that we can set compression algorithm"
> +	fi
> +
>  	local algs=$(cat /sys/block/zram0/comp_algorithm)
>  	tst_resm TINFO "supported algs: $algs"
>  	local i=0
> @@ -116,7 +133,16 @@ zram_set_disksizes()
>  
>  zram_set_memlimit()
>  {
> -	tst_resm TINFO "set memory limit to zram device(s)"
> +	tst_kvercmp 3 18 0
> +	if [ $? -eq 0 ]; then
> +		tst_resm TCONF "device attribute mem_limit is"\
> +			"introduced since kernel v3.18, the running kernel"\
> +			"does not support it"
> +		return
> +	else
> +		tst_resm TINFO "set memory limit to zram device(s)"
> +	fi
> +
>  	local i=0
>  	for ds in $zram_mem_limits; do
>  		local sys_path="/sys/block/zram${i}/mem_limit"
> 


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
