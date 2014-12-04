Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XwUVI-0004Cr-PM
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 11:23:24 +0000
Date: Thu, 4 Dec 2014 12:23:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141204112311.GC15326@rei.suse.de>
References: <1417101031-5272-1-git-send-email-mmarhefk@redhat.com>
	<20141202123840.GA16824@rei.suse.de> <54803C62.30803@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54803C62.30803@redhat.com>
Subject: Re: [LTP] [PATCH] testcases/lib/test.sh: added tst_timeout()
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > This is bashism. The portable way to do this seems to be do
> > tr -d [:digit:] on the string and checking if result is empty or use
> > grep.
> 
> Indeed, 'tr' may be used in this case, but an (AFAIK) portable
> replacement for =~ is expr(1):

I do not care much about the way it's implemented. All we need is that
the code runs fine at least with bash, dash and bussybox.

>   if ! expr "$timeout" : '.*[0-9]\+$' >/dev/null; then
> 
> although, as you can see, there are several limitations:
> 
>   - IIRC the busybox version doesn't support '+ TOKEN' syntax, so we
>     rely on ie. $timeout != "match"
>   - different implementations may have different syntax, although the
>     `:' notation is AFAIK the oldest
>   - regexp matching is always done from the beginning, so there's `^'
>     implied
>   - path to /dev/null may be different on some systems (_PATH_DEVNULL),
>     not sure if "/dev/null" is a POSIX requirement

We rely on /dev/null heavily in all parts of LTP. The goal is to be
portable across various Linux distributions, even embedded ones. We do
not care about rest of the UNIX world much (the exception is the Open
Posix Testsuite which should be written to the POSIX standard).

Ahd the whole problem reminds me an old saying:

"I'ts easier to implement portable shell than a porable shell code."

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
