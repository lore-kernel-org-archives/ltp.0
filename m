Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZRg5y-00078Q-Tv
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 12:34:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRg5w-0001LB-HO
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 12:34:26 +0000
Date: Tue, 18 Aug 2015 14:33:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150818123346.GA22482@rei.suse.de>
References: <1435712845-11717-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435712845-11717-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] cpuctl: correct wrong TCID
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
> index 3669a5d..e4c9672 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
> @@ -65,7 +65,7 @@
>  #define TIME_INTERVAL	30	/* Time interval in seconds */
>  #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
>  
> -char *TCID = "cpu_controller_test04";
> +char *TCID = "cpu_controller_test02";

I would rather see the TCID for cpuctl_test* to be renamed to
cpuctl_test* to match the filenames. Otherwise these changes looks fine
to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
