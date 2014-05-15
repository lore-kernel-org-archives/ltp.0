Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkuWC-0002fX-Aj
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 12:12:12 +0000
Date: Thu, 15 May 2014 14:12:00 +0200
From: chrubis@suse.cz
Message-ID: <20140515121200.GB23965@rei.Home>
References: <1397731818-26430-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397731818-26430-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] rmdir/rmdir02.c: cleanup
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
To: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> +	memset(longpathname, 'a', PATH_MAX + 2);

I've changed this to:

memset(longpathname, 'a', PATH_MAX + 1);

So that longpathname is zero terminated sting.

> -	/* resume original working directory */
> -	chdir(cwd);
> +	SAFE_TOUCH(cleanup, TESTFILE2, FILE_MODE, NULL);
>  
> -	return (strlen(longpath) >= PATH_MAX) ? 0 : -1;
> +#if !defined(UCLINUX)
> +	test_cases[4].dir = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
> +		MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> +#endif

And changed the MAP_PRIVATE_EXCEPT_UCLINUX to just MAP_PRIVATE, because
it's in #if !defined(UCLINUX) block anyway.

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
