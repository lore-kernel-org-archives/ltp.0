Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z86aY-0006ks-IR
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 12:49:06 +0000
Date: Thu, 25 Jun 2015 14:47:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150625124750.GB2866@rei.suse.de>
References: <53635abf85856cffa2799ea43f942a619faec342.1435235333.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53635abf85856cffa2799ea43f942a619faec342.1435235333.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] getrandom: fix compilation with older kernels
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
> +#ifndef __GETRANDOM_H__
> +#define __GETRANDOM_H__
> +
> +/*
> + * Flags for getrandom(2)
> + *
> + * GRND_NONBLOCK	Don't block and return EAGAIN instead
> + * GRND_RANDOM		Use the /dev/random pool instead of /dev/urandom
> + */
> +
> +#ifndef GRND_NONBLOCK
> + #define GRND_NONBLOCK	0x0001
> +#endif
> +
> +#ifndef GRND_RANDOM
> + #define GRND_RANDOM	0x0002
> +#endif

It's usuall to intend the identifier after the # such as:

#ifdef
# define
#endif

Since there are some compilers that can't cope with spaces before #
(at least that is what I've been told).

--

The rest looks fine, acked.

Thanks for doing this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
