Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZ056-00014Y-BT
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2015 17:19:48 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZ055-0005Lg-3t
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2015 17:19:48 +0000
Date: Mon, 7 Sep 2015 19:19:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150907171902.GA7580@rei.suse.cz>
References: <1440410664-10266-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
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

Passing the value by global variable is ugly. Why don't we echo the
value here as:

echo $(get_present_cpus |wc -w), or even just call 'get_presnt_cpus |wc -w'

and do:

if [ $(get_present_cpus_num) -lt 2 ]; then
...
fi

in the testcases?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
