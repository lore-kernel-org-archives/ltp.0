Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PcNfT-0000YL-3L
	for ltp-list@lists.sourceforge.net; Mon, 10 Jan 2011 19:44:39 +0000
Date: Mon, 10 Jan 2011 21:01:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110110200100.GC23413@saboteur.suse.cz>
References: <AANLkTinX9M3EsBxSDsVy56iKqskSWKQE4vMhXy0kcxNG@mail.gmail.com>
	<20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
	<AANLkTi=L8Vai5_=fn0psJeovura_Y=VjdN28ufiqBiiA@mail.gmail.com>
	<AANLkTin-yaUcPd8GZHgWnoYkxpOxDFs4enEik8afaeEc@mail.gmail.com>
	<AANLkTinFbVBZtA_hCfRqTK=sZW+ZBSi3KbjA7Butkfum@mail.gmail.com>
	<F3972A55-1F53-4B70-A858-E041E01F246D@gmail.com>
	<20110107143607.GA12323@saboteur.suse.cz>
	<C4CD5B9F-C198-44A7-996B-3D2C46C4AD86@gmail.com>
	<20110110184316.GB23413@saboteur.suse.cz>
	<AANLkTi=RGbG++FaG4AsZZkrZB14cuKPeuOZZPNVoNvSc@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=RGbG++FaG4AsZZkrZB14cuKPeuOZZPNVoNvSc@mail.gmail.com>
Subject: Re: [LTP] [PATCH 00/13]Fix a few syntax error
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> >> > I still could not compile the latest git. I've got a bunch of:
> >> >
> >> > pipe declared with warn_unused_result
> >> > write declared with warn_unused_result
> >> > read declared with warn_unused_result
> >>
> >> Now you know why I used void casts in a few spots :). Some are of value, some are fud.
> >
> > The problem seems to be that in different versions of libc different
> > calls are marked with warn_unused_result. I'm still thinking if -Werror
> > is right default for git tree. And I'm almost sure that it's wrong for
> > releases.
> 
> Agreed, but people need to turn it on before committing test code, so
> that their code doesn't introduce any new warnings.

Well that doesn't catch up warnings if they are compiling, let's say on
ancient rhel distros. Unless somebody checks the code on recent enough
glibc... As far as I remember warn_unused_result is quite recent
feature.

> >> Ok. It would be nice to have a summary email (off-list) with all of
> >> these warnings, as they can lead to really bad problems. I may do like
> >> I've done in some directories as well and add -Wno-error with a
> >> comment stating why things were done that way.
> >
> > Will send.
> 
> Thanks. Subrata sent me a bunch of warnings-related errors so I'll
> need to follow up on them.  Now that tst_brk is reentrant (for better
> or for worse -- I needed to do this so people could use SAFE_CLOSE,
> etc in cleanup functions otherwise the compiler would whine that code
> doesn't return), the compiler isn't smart enough to realize that the
> following will always result in an immediate exit:
>
> int
> main(void)
> {
>     tst_brkm(TCONF, NULL, "gcc is dumb");
> }

Well, that's the whole reason for attribute __noreturn__. The compiler
is not smart enough and it's not easy to make it smarter, without a buch
of matematicians and a lot of work. And as such code leads, usually, to
bug, the gcc folks rather prints the warning. There are even parts of
gcc compiler, that are compiled with warnings disabled...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
