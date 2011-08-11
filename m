Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QrWTi-0001jh-0s
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 14:43:22 +0000
Date: Thu, 11 Aug 2011 16:47:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110811144721.GA17773@saboteur.suse.cz>
References: <120e211c585b71f27c1bfc13d48e0f535b3201d5.1312279518.git.czhang@redhat.com>
	<20110811140358.GA16435@saboteur.suse.cz>
	<4E43E8EF.4060101@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E43E8EF.4060101@redhat.com>
Subject: Re: [LTP] [PATCH] mm/ksm05: new testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> >>>  +static void sighandler(int sig)
> >>>  +{
> >>>  +	if (sig == SIGSEGV)
> >>>  +		tst_exit();
> >>>  +	else
> >>>  +		tst_resm(TFAIL, "sighandler received invalid signal:%d", sig);
> >>>  +}
> >I'm little worried about the tst_xxx interface used in signal handlers
> >as it is not signal-async-safe and may fail (in strange circumstances).
> >
> >But this is in child process, right? So you could call _exit() and check
> >the return value in parent.
> >
> >Also the return value from tst_resm() would end up as return value from
> >child and wouldn't propagate to parent if I'm not mistaken.
> >
> 
> Would something like:
> 
> static void sighandler(int sig)
> {
>   exit((sig == SIGSEGV) ? 0 : sig);
> }
> 
> be acceptable?

Yes, just use _exit() instead of exit() to be extra safe.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
