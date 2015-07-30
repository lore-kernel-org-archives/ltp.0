Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZKpNJ-0005FH-PV
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 15:04:01 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKpND-00083U-QM
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 15:04:01 +0000
Date: Thu, 30 Jul 2015 17:03:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150730150337.GC21727@rei.suse.de>
References: <709268354.243831438265570214.JavaMail.weblogic@epmlwas09a>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <709268354.243831438265570214.JavaMail.weblogic@epmlwas09a>
Subject: Re: [LTP] [Query] Regarding netns testcases
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
To: Manjeet Pawar <manjeet.p@samsung.com>
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, ltp-list@lists.sourceforge.net, Rohit Thapliyal <r.thapliyal@samsung.com>, "pankaj.m@samsung.com" <pankaj.m@samsung.com>

Hi!
> I am facing crash while executing below netns testcases on ARM:
> 
> netns_crtchild   
> netns_two_children_ns 
> netns_crtchild_delchild 
> netns_par_chld_ipv6  
> netns_par_chld_ftp  
> netns_netlink   
> 
> After analysis of crash , it is found that all are crashing due to a common cause.
> -----------------------------------------------------------
> Backtrace:
> do_unshare_tests() --> crashes while call NULL function pointer
> do_clone_unshare_test() -- > pass NULL fuction pointer
> check_netns() -->  passes function ptr as NULL
> setup()
> main()
> ------------------------------------------------------------
> Culprit function:- (netns_helper.h)
> pid = do_clone_unshare_test(T_UNSHARE, CLONE_NEWNET | CLONE_NEWNS, NULL,
>             NULL);
> 
> Third argument passing to this function is NULL, which is not appropriate here, since it is derefrence by do_unshare_tests().

This is quite cosmetic issue. I've checked the code and the child here
segfaults after it reports status to the parent.

So if you send an patch that fixes the issue, I will apply it but since
these testcases will be soon rewritten from scratch I would not bother.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
