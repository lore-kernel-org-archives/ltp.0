Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Tbm6o-0002pW-Mq
	for ltp-list@lists.sourceforge.net; Fri, 23 Nov 2012 05:47:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tbm6n-00036X-VS
	for ltp-list@lists.sourceforge.net; Fri, 23 Nov 2012 05:47:26 +0000
Message-ID: <50AF0DA9.1090908@cn.fujitsu.com>
Date: Fri, 23 Nov 2012 13:46:17 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1353649340-678-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1353649340-678-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] numa01.sh: fix error in getting number of CPUs
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

On 11/23/2012 01:42 PM, Simon Xu wrote:
> test04 in numa01.sh is using a wrong method to get the number of CPUs.
> This results in:
> 
> numactl: cpu argument 9 is out of range
> 
> awk: cmd. line:1: fatal: cannot open file `/proc/4116/stat' for reading
> (No such file or directory)
> /opt/ltp/testcases/bin/numa01.sh: line 475: [: =: unary operator expected
> awk: cmd. line:1: fatal: cannot open file `/proc/4116/stat' for reading
> (No such file or directory)
> /opt/ltp/testcases/bin/numa01.sh: line 481: [: -ne: unary operator expected
> /opt/ltp/testcases/bin/numa01.sh: line 488: kill: (4116) - No such process
> numa04      4  TBROK  :  Kill on process 4116 fails
> 
> Fix it by getting number of CPUs by grepping /proc/cpuinfo.
> ---
>  testcases/kernel/numa/numa01.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
> index 3ea7950..8d0808a 100644
> --- a/testcases/kernel/numa/numa01.sh
> +++ b/testcases/kernel/numa/numa01.sh
> @@ -466,7 +466,7 @@ test04()
>      run_on_cpu=0
>      running_on_cpu=0
>  
> -    no_of_cpus=$(ls /sys/devices/system/cpu/ | wc -w)
> +    no_of_cpus=$(grep "^processor"  /proc/cpuinfo | wc -l)

We have commands tst_ncpus and tst_ncpus_max to get the number of cpu in the system.

Thanks,
Wanlong Gao

>      # not sure whether cpu's can't be in odd number
>      run_on_cpu=$[$[$no_of_cpus+1]/2]
>      numactl --physcpubind=$run_on_cpu support_numa $PAUSE & #just waits for sigint
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
