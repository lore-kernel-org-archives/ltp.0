Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZedr-00041q-OV
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 12:38:23 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZedq-0007qu-Mn
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 12:38:23 +0000
Date: Wed, 9 Sep 2015 14:37:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150909123737.GA13664@rei.suse.cz>
References: <dde73925917fe3524a598d859fdb66ca95711fc3.1441798744.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dde73925917fe3524a598d859fdb66ca95711fc3.1441798744.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] mprotect04: fix powerpc crash when copying
 exec_func
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Testcase tried to copy page size area starting at &exec_func.
> This results in crash on powerpc, because &exec_func is too close
> to end of page and subsequent page is not mapped:

I was wondering about this problem when I was fixing the test, but could
not actually hit it.

> -static void *get_func(void *mem)
> +static int page_present(void *p)
>  {
> -	memcpy(mem, exec_func, getpagesize());
> +	int fd;
> +
> +	fd = SAFE_OPEN(cleanup, "page_present", O_WRONLY|O_CREAT, 0644);

Why don't we use "/dev/null"?


The rest looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
