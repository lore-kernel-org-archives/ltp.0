Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PPe0r-0006pR-4g
	for ltp-list@lists.sourceforge.net; Mon, 06 Dec 2010 16:34:05 +0000
Date: Mon, 6 Dec 2010 17:47:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101206164726.GC6562@saboteur.suse.cz>
References: <1006961573.2311291438423847.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1995606888.2331291438618074.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1995606888.2331291438618074.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] munmap() don't check sysctl_max_mapcount
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
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > Also no need to check return value from check() which always returns
> > zero.
> The reason to use TEST() is to take advantages of standard LTP options like,
> 
>   -c n    Run n copies concurrently
>   -I x    Execute test for x seconds

If you look into the include/usctest.h the TEST() macro just saves
return value and errno. The -c -I options are implemented elsewhere. The
-c is done by TEST_PAUSE in setup() and the -I is done by the
TEST_LOOPING() (and is broken anyway). I would just remove the TEST()
macro and cange the check() to void.

> > Do you need to create temporary directory for testing pthreads?
> No, They were copied from the standard LTP test template. I was under
> the impression that some of internal LTP things need those. If not, I
> can remove them.

No it just creates unique directory and changes CWD to it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
