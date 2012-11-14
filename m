Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TYWdG-00054Z-AP
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 06:39:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TYWdF-00045K-FK
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 06:39:30 +0000
Message-ID: <50A33C6F.1050604@cn.fujitsu.com>
Date: Wed, 14 Nov 2012 14:38:39 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1352705641-27644-1-git-send-email-jin.li@windriver.com>
	<1352705641-27644-4-git-send-email-jin.li@windriver.com>
In-Reply-To: <1352705641-27644-4-git-send-email-jin.li@windriver.com>
Subject: Re: [LTP] [PATCH 3/3] Fix cpuhotplug test case cpuhotplug05
Reply-To: gaowanlong@cn.fujitsu.com
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
To: jin.li@windriver.com
Cc: ltp-list@lists.sourceforge.net

On 11/12/2012 03:34 PM, jin.li@windriver.com wrote:
> From: Jin Li <jin.li@windriver.com>
> 
> Check whether sar is available befor run test

This is OK to me.

Thanks,
Wanlong Gao

> 
> Signed-off-by: Jin Li <jin.li@windriver.com>
> ---
>  testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> index ad57efe..e64b91c 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> @@ -27,6 +27,11 @@ Desc:   Does sar behave properly during CPU hotplug events?
>  
>  EOF
>  
> +which sar > /dev/null 2>&1 || {
> +        tst_resm TCONF "sar does not exist"
> +        exit_clean 1
> +}
> +
>  # Verify the specified CPU is available
>  if ! cpu_is_valid "${CPU_TO_TEST}" ; then
>  	tst_resm TBROK"CPU${CPU_TO_TEST} not found"
> 


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
