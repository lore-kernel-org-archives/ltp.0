Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEwZk-00016M-SS
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 09:32:32 +0000
Date: Tue, 14 Jul 2015 11:31:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150714093101.GA3729@rei.suse.de>
References: <1435721609-7938-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435721609-7938-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] containers: Use raw setns syscall for versions of
 glibc that don't include it
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
> index da03bae..21e5cb8 100644
> --- a/testcases/kernel/containers/userns/userns_helper.h
> +++ b/testcases/kernel/containers/userns/userns_helper.h
> @@ -15,6 +15,16 @@
>  #include "test.h"
>  #include "safe_macros.h"
>  
> +/*
> + * Use raw setns syscall for versions of glibc that don't include it
> + */
> +#if __GLIBC__ <= 2 && __GLIBC_MINOR__ < 14
> +int setns(int fd, int nstype)
> +{
> +	return ltp_syscall(__NR_setns, fd, nstype);
> +}
> +#endif

I would rather see this as configure check. Simple
AC_CHECK_FUNCS([setns]) would do, then we can use #ifndef HAVE_SETNS in
the source after we include config.h.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
