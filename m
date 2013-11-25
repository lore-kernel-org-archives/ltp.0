Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vkx1s-0002Md-Fq
	for ltp-list@lists.sourceforge.net; Mon, 25 Nov 2013 14:20:48 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 4FE8BA79B2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Nov 2013 15:20:41 +0100 (CET)
Date: Mon, 25 Nov 2013 15:20:18 +0100
From: chrubis@suse.cz
Message-ID: <20131125142018.GB32540@rei.suse.cz>
References: <20131120095902.GB30274@quack.suse.cz>
	<20131120122505.GB2168@rei.nue.novell.com>
	<20131120203951.GE30274@quack.suse.cz>
	<20131120214857.GA1106@rei.my-cloud.eu>
	<20131120224313.GH30274@quack.suse.cz>
	<20131121151044.GA27253@rei.nue.novell.com>
	<20131121204705.GB29565@quack.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121204705.GB29565@quack.suse.cz>
Subject: Re: [LTP] fanotify tests
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > I've fixed a last few issues in the code, added gitignore file and
> > pushed, see comments bellow and the diff.
>   Thanks!
> 
> > There is a bug in ltp_syscall() implementation that calls callback if
> > fanotify syscalls are not compiled in the kernel and that results in the
> > TWARN in the return value. I will look into this one and fix it.
> > 
> > Also fanotify syscalls don't have a man pages :( Where do I find a
> > documentation for it?
>   Yeah, fanotify() doesn't seem to have manpages in a standard package.
> However some manpages apparently exist as you can see when googling for
> "fanotify manpage". E.g.
> http://www.xypron.de/projects/fanotify-manpages/man7/fanotify.7.html
> 
> is one such example (which is what I used, although I admit I had to
> consult kernel sources a few times as well).
> 

That is unfortunate, the git repo on that address even has a link to
patches send to man pages ML[1] and it looks to me like they weren't
accepted because example was missing, at least if I read the emails
right.

1. http://marc.info/?l=linux-man&m=131914559320227&w=2

It would be nice to get these included in the man-pages git as well...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
