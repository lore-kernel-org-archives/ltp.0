Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X980j-0003cS-RI
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 07:27:49 +0000
Date: Mon, 21 Jul 2014 09:27:10 +0200
From: chrubis@suse.cz
Message-ID: <20140721072710.GA14496@rei>
References: <CAHTgTXWCNZzL+6ptrMgwR5d2UA4dcSka_C=off87axRqsgbm1Q@mail.gmail.com>
	<20140715185406.GA10046@rei>
	<CAHTgTXVrf6yFoD7_tPmJSO1CZFsx19DyA-stfYTqujpBUUF0sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHTgTXVrf6yFoD7_tPmJSO1CZFsx19DyA-stfYTqujpBUUF0sQ@mail.gmail.com>
Subject: Re: [LTP] GCC_WARN_OLDSTYLE build error
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
To: Vinson Lee <vlee@twopensource.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > That looks like the variable from config.mk.in wasn't substitued
> > correctly.
> >
> > Does it work when you readd the -I m4 to the automake.mk that this patch
> > has removed?
> >
> > Does the 'make autotools' print any warnings for AC_CONFIG_MACRO_DIR?
> >
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> 
> 'make autotools' does not print any warnings.
> 
> The build passes if I readd '-I m4' to automake.mk.

I've pushed a patch that readds it to the automake.mk, the problem is
that AC_CONFIG_MACRO_DIR() was broken and works only in recent enough
autotools. See the reply to Joseph for more information.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
