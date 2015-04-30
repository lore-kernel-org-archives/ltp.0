Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YnnNz-0004T1-0v
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 12:16:11 +0000
Date: Thu, 30 Apr 2015 14:15:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150430121539.GB24720@rei.suse.de>
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1427787975-10668-3-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1427787975-10668-3-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/6] lib6/asapi_05.c: cleanup
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +#define ETCOUNT	(sizeof(etab)/sizeof(etab[0]))

ARRAY_SIZE()

> +/*
> + * This is for old, broken glibc-header icmp6_filter structure definitions.
> + * If icmp6.h has struct icmp6_filter with field named "data" instead
> + * of the standard "icmp_filt", uncomment this line.
> + */
> +/*#define icmp_filt	data */

I guess that we can remove this completly. It was workaround for broken
glibc-2.3.3 and older which is about 11 years old now.
(glibc commit c2280dc039c69a690dd006c1f145c7ba9aa2eaad)

> +enum tt { T_WILLPASS, T_WILLBLOCK, T_SETPASS, T_SETBLOCK, T_SETPASSALL,
> +	T_SETBLOCKALL
> +};
> +struct ftent {
> +	char *ft_tname;		/* test name, for logging */
> +	unsigned char ft_sndtype;	/* send type field */
> +	unsigned char ft_flttype;	/* filter type field */
> +	enum tt ft_test;	/* what macro to test */
> +	int ft_expected;	/* packet should pass? */
> +} ftab[] = {
> +	{ "ICMP6_FILTER_SETPASS s 20 f 20", 20, 20, T_SETPASS, 1 },
> +	{ "ICMP6_FILTER_SETPASS s 20 f 21", 20, 21, T_SETPASS, 0 },
> +	{ "ICMP6_FILTER_SETBLOCK s 20 f 20", 20, 20, T_SETBLOCK, 0 },
> +	{ "ICMP6_FILTER_SETBLOCK s 20 f 21", 20, 21, T_SETBLOCK, 1 },
> +	{ "ICMP6_FILTER_PASSALL s 20", 20, 0, T_SETPASSALL, 1 },
> +	{ "ICMP6_FILTER_PASSALL s 20", 21, 0, T_SETPASSALL, 1 },
> +	{ "ICMP6_FILTER_BLOCKALL s 20", 20, 0, T_SETBLOCKALL, 0 },
> +	{ "ICMP6_FILTER_BLOCKALL s 20", 21, 0, T_SETBLOCKALL, 0 },
> +	{ "ICMP6_FILTER_WILLBLOCK s 20 f 21", 20, 21, T_WILLBLOCK, 0 },
> +	{ "ICMP6_FILTER_WILLBLOCK s 20 f 20", 20, 20, T_WILLBLOCK, 1 },
> +	{ "ICMP6_FILTER_WILLPASS s 20 f 21", 20, 21, T_WILLPASS, 0 },
> +	{ "ICMP6_FILTER_WILLPASS s 22 f 22", 22, 22, T_WILLPASS, 1 },
> +};
> +
> +#define FTCOUNT	(sizeof(ftab)/sizeof(ftab[0]))

ARRAY_SIZE()

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
