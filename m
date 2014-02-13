Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDvy9-00035S-Ca
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 13:04:45 +0000
Date: Thu, 13 Feb 2014 14:04:34 +0100
From: chrubis@suse.cz
Message-ID: <20140213130434.GB16584@rei.suse.cz>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
	<1392112090-13853-3-git-send-email-alexey.kodanev@oracle.com>
	<20140212154431.GB4905@rei.suse.cz> <5128140.KmexAZrTeg@vapier>
	<20140213102128.GB1737@rei.suse.cz> <52FCA8DF.4030503@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52FCA8DF.4030503@oracle.com>
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> >> glibc provides pthread mutex lock/unlock stubs, so i wonder if we even need _r
> >> variants.  if the program hasn't linked against -lpthread, then the funcs will
> >> simply return.  if it has, then you get locking.
> > That sounds interesting. Do you know if this is implemented in uClibc
> > (and possibly in other alternative libc libraries) too?
> If portability is acceptable we could put mutex initializer in the 
> libltp. Another question should we lock/unlock mutex inside the libltp's 
> functions or set it like in the example I sent previously (use wrapper 
> macros)?

In a case that mutex stubs are common practice among libc
implementations I would be for adding the mutexes directly into the
libltp.a and do the locking inside the original functions. If not we
should go with wrappers.

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
