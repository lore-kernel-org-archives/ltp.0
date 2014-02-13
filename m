Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDtQI-0007hp-6x
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 10:21:38 +0000
Date: Thu, 13 Feb 2014 11:21:28 +0100
From: chrubis@suse.cz
Message-ID: <20140213102128.GB1737@rei.suse.cz>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
	<1392112090-13853-3-git-send-email-alexey.kodanev@oracle.com>
	<20140212154431.GB4905@rei.suse.cz> <5128140.KmexAZrTeg@vapier>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5128140.KmexAZrTeg@vapier>
Subject: Re: [LTP] [PATCH 4/4] lib: add tst_res_r.c
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, ltp-list@lists.sourceforge.net, vasily.isaenko@oracle.com

Hi!
> > This is hardly pefromance critical code so we don't need fine grade
> > locking as this. What we can do in most of the cases is to take the
> > mutext and call the function from tst_res.c, which would lead to much
> > simpler code.
> 
> glibc provides pthread mutex lock/unlock stubs, so i wonder if we even need _r 
> variants.  if the program hasn't linked against -lpthread, then the funcs will 
> simply return.  if it has, then you get locking.

That sounds interesting. Do you know if this is implemented in uClibc
(and possibly in other alternative libc libraries) too?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
