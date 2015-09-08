Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZI3Q-0004vN-Dj
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 12:31:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZI3O-0002iT-F4
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 12:31:16 +0000
Date: Tue, 8 Sep 2015 14:30:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150908123029.GA3747@rei.suse.cz>
References: <55EEA2EF.6040706@cn.fujitsu.com>
	<1441704883-4331-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1441704883-4331-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] cpuhotplug_hotplug.sh: fix the return of cpu
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
> index 6920393..48bd814 100644
> --- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> @@ -169,7 +169,7 @@ get_present_cpus()
>  #
>  get_present_cpus_num()
>  {
> -    return $(get_present_cpus | wc -w)
> +	echo $(get_present_cpus | wc -w)

I've changed the tab here back to four spaces since rest of the file
uses four spaces for indentation and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
