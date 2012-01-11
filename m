Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rkwyz-0007K2-2h
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 12:08:45 +0000
Date: Wed, 11 Jan 2012 13:20:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120111122008.GC7143@saboteur.suse.cz>
References: <1326166692-18276-1-git-send-email-caspar@casparzhang.com>
	<4F0BB312.5070009@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F0BB312.5070009@casparzhang.com>
Subject: Re: [LTP] [PATCH] syscalls/getrusage03: flush stdout to avoid
 duplicated output
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > when executing with `$BIN/runltp` command, getrusage03 puts out
> > duplicated information due to buffered stdout. Using fflush(stdout) to
> > solve this issue.
> > 
> > Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> > ---
> >  testcases/kernel/syscalls/getrusage/getrusage03.c  |    7 +++++++
> >  .../kernel/syscalls/getrusage/getrusage03_child.c  |    1 +
> >  2 files changed, 8 insertions(+), 0 deletions(-)
> > 
> 
> Not sure if we have any better solution to avoid such buffered I/O issue.
> 

That seems to be a hack and not only because you don't know to which
file the tst_resm() is printing.

What is exactly the problem here?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
