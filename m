Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W0t3p-0006mT-0C
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 13:20:41 +0000
Date: Wed, 8 Jan 2014 14:20:21 +0100
From: chrubis@suse.cz
Message-ID: <20140108132021.GC1203@rei.Home>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<20140107140910.GD27135@rei.Home>
	<1389181297.2879.11.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389181297.2879.11.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v5 1/2] lib/cloner.c: add more args
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > Looks like this patch breaks compilation on older distributions, I've
> > got: "Too many arguments to function 'clone'". Has anybody seen this
> > too?
> > 
> 
> I run it in RHEL5.0GA, RHEL6.0GA, 7.0Beta
> and do not find these messages.
> Could you tell me which distributions it is.

SLES11 on s390 and s390x, SLES10, RHEL4. Generally older distributions
and/or exotic architectures.

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
