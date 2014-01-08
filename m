Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W0skV-0000do-VW
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 13:00:44 +0000
Date: Wed, 8 Jan 2014 14:00:24 +0100
From: chrubis@suse.cz
Message-ID: <20140108130024.GB1203@rei.Home>
References: <c3a64332100498deedfb1b27b83545e42deb2d54.1389101980.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3a64332100498deedfb1b27b83545e42deb2d54.1389101980.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] lib: errnos: use ERFKILL only if it's defined
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
> This is to fix compilation on RHEL5.3:
>   In file included from tst_res.c:216:
>   errnos.h: In function ???strerrnodef???:
>   errnos.h:164: error: ???ERFKILL??? undeclared (first use in this function)
>   errnos.h:164: error: (Each undeclared identifier is reported only once
>   errnos.h:164: error: for each function it appears in.)
>   errnos.h:164: error: array index in initializer not of integer type
>   errnos.h:164: error: (near initialization for ???errno_pairs???)
>   make[1]: *** [tst_res.o] Error 1
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  lib/errnos.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/errnos.h b/lib/errnos.h
> index 797aed4..ee9620b 100644
> --- a/lib/errnos.h
> +++ b/lib/errnos.h
> @@ -161,7 +161,9 @@ static const char *strerrnodef(int err)
>  		PAIR(EKEYREJECTED)
>  		PAIR(EOWNERDEAD)
>  		PAIR(ENOTRECOVERABLE)
> +#ifdef ERFKILL
>  		PAIR(ERFKILL)
> +#endif
>  #ifdef EHWPOISON
>  		PAIR(EHWPOISON)
>  #endif

Pushed and added few more so that we are compatible back to the SLES9
and RHEL4. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
