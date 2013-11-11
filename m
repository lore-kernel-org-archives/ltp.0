Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VfrsW-0004iB-4e
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 13:50:08 +0000
Date: Mon, 11 Nov 2013 14:49:57 +0100
From: chrubis@suse.cz
Message-ID: <20131111134956.GC12164@rei>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
	<1383085243-5833-5-git-send-email-vincent.hsu@linaro.org>
	<20131107131417.GB28961@rei.suse.cz>
	<CAARHBVvTzEtp=ycDaiTwEwYFRR_DpVu=og-A7TWcOA7gPtwQeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAARHBVvTzEtp=ycDaiTwEwYFRR_DpVu=og-A7TWcOA7gPtwQeQ@mail.gmail.com>
Subject: Re: [LTP] [LNG][PATCH 4/9] ltp-networking/tcp_cmds/netstat: netstat
 cmds will return 1 even if no output in stderr on Ubuntu 12.04
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
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, Linaro Networking <linaro-networking@linaro.org>

Hi!
> > > for example:
> > >     $ netstat -s 1>netstat/dev/null 2>&1 ; echo $?
> > >     1
> >
> > This is completly bogus code, it returns nonzero because the file
> > 'netstat/dev/null' cannot be found. It works for me if I remove the
> > 'netstat' from the line.
> >
> Sorry, it a typo.

Ok.

> it will returns nonzero in ubuntu 12.04. it's a similar case to finger test.
> 
> for example:
>     $ netstat -s 1>/dev/null 2>&1 ; echo $?
>     1

Ah, so the -s is correct netstat switch and the 1 is invalid parameter
(which gets ignored here) but apparently debian base distros are patched
to return non-zero.

So resend the patch with correct description (i.e. that this fixes the
test on debian based distributions).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
