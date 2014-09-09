Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XRMbH-0004hu-Fr
	for ltp-list@lists.sourceforge.net; Tue, 09 Sep 2014 14:40:55 +0000
Date: Tue, 9 Sep 2014 16:40:35 +0200
From: chrubis@suse.cz
Message-ID: <20140909144034.GA6108@rei>
References: <1407309452.2223.13.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1407309452.2223.13.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] securebits/check_keepcaps.c: Add comments about
 cap_get_flag may return -1
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
> In RHEL7.0(3.10.0) the value of CAP_LAST_CAP in linux/capability.h is 36, it is
> greater than in the capability.h which is used to create
> libcap.so(libcap-2.22-8) and that value is 34. Then cap_get_flag returns -1, and
> errno is set to EINVAL. Add comments to make this clear.

I'm a bit confused, the sys/capability.h header which is part of libcap
includes the linux/capability.h header which defines the the
CAP_LAST_CAP (at least on my system). So there shouldn't be a
disagreement between these two unless libcap was compiled with wrong
kernel headers which I would call a bug in distribution. Are you sure
that all your packages are up to date?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
