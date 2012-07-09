Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1So4AB-0002Zu-Lr
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:57:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1So4AA-0003Nt-GE
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:57:27 +0000
Message-ID: <4FFA487A.4000907@cn.fujitsu.com>
Date: Mon, 09 Jul 2012 10:56:58 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1341388422-28133-1-git-send-email-jin.li@windriver.com>
	<1341388422-28133-2-git-send-email-jin.li@windriver.com>
In-Reply-To: <1341388422-28133-2-git-send-email-jin.li@windriver.com>
Subject: Re: [LTP] [PATCH] Add test case path in
	testcases/kernel/hotplug/cpu_hotplug/runtests.sh
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
To: Jin Li <jin.li@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On 07/04/2012 03:53 PM, Jin Li wrote:
> Fail to invoke cpuhotplug via:
> 
> ./runltp -f cpuhotplug
> 
> <<<test_output>>>
> incrementing stop
> CPU:        1
> LOOPS:      1
> LHCS_PATH:  /opt/ltp/testcases/bin/cpu_hotplug
> /opt/ltp/testcases/bin/cpu_hotplug/runtests.sh: line 15: functional/hotplug??.sh: No such file or directory
> 

pushed, thank you.

Wanlong Gao

> Signed-off-by: Jin Li <jin.li@windriver.com>
> ---
>  testcases/kernel/hotplug/cpu_hotplug/runtests.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/runtests.sh b/testcases/kernel/hotplug/cpu_hotplug/runtests.sh
> index 2803508..1943f83 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/runtests.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/runtests.sh
> @@ -11,6 +11,6 @@ echo "LOOPS:      $LOOPS"
>  echo "LHCS_PATH:  $LHCS_PATH"
>  
>  
> -for case in functional/hotplug??.sh; do
> +for case in $LHCS_PATH/functional/hotplug??.sh; do
>  	$case $CPU_TO_TEST
>  done
> 



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
