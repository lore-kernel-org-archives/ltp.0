Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TNmWE-0004Gf-Ra
	for ltp-list@lists.sourceforge.net; Mon, 15 Oct 2012 15:23:50 +0000
Date: Mon, 15 Oct 2012 17:21:32 +0200
From: chrubis@suse.cz
Message-ID: <20121015152131.GA4852@rei.suse.cz>
References: <5077D10C.3040302@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5077D10C.3040302@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v6] pthread_cond_brodcast/1-2.c hung when mem left
 is not enough
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> +#ifdef __linux__
> +#include <sys/sysinfo.h>
> +
> +static int getfreeram(void)
> +{
> +	int ret;
> +	struct sysinfo sysinformation;
> +
> +	ret = sysinfo(&sysinformation);
> +	if (ret != 0)
> +		return 0;
> +	return sysinformation.freeram;
> +}
> +#else
> +static int getfreeram(void)
> +{
> +	return 0;
> +}
> +#endif

I think that there is still the same problem as in the first version.
Are you sure that sysinfo.freeram is reasonable number? Because as far
as I understand it this nuber shows amount of ram that is not used
currently. So when you run the test inside of LTP testsuite the number
may be quite low as there may be a lot of data cached in the buffers
because buffers are flushed only when there is memory pressure.

I've checked docs for both fork() and pthread_create() and both of them
shall indicate that there are no resources to create process/thread by
setting errno to EAGAIN (fork() may additionally return ENOMEM too). So
we could create processes until counter is reached or we got ENOMEM
which should be 100% portable.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
