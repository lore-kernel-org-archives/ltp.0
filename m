Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Ogwzl-00059k-NQ
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 09:44:13 +0000
Date: Thu, 5 Aug 2010 12:00:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100805100044.GA11402@saboteur.suse.cz>
References: <20100722142216.GA3593@saboteur.suse.cz>
	<AANLkTikxgQkrxYRKgNe_CPrU9-pFKslpstzqMxDMN3pm@mail.gmail.com>
	<20100722183850.GA18490@saboteur.suse.cz>
	<AANLkTikuRkjhGOi_Azyb9Ij18ZNCuZhj65hP_fFj5goO@mail.gmail.com>
	<20100723085121.GA15257@saboteur.suse.cz>
	<4C4DB808.4060504@linux.vnet.ibm.com>
	<AANLkTimRxE3gSU+u_icof5XZ+D2HzRJzXuKxQV8NX_Ui@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimRxE3gSU+u_icof5XZ+D2HzRJzXuKxQV8NX_Ui@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix make install in ltp/testcacses/realtime/
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>>>>> When doing 'make install' in ltp/testcases/realtime/ the process s=
tops
> >>>>>> because the dummy makefile generated from empty Makefile.am is not
> >>>>>> correct makefile (has unmakeable targets). This could be easily fi=
xed by
> >>>>>> adding m4 to FILTER_OUT_DIRS.
> >>>>>>
> >>>>>> Patch attached.
> >>>>>>
> >>>>> I understand the issue that you're trying to address, but have you
> >>>>> tried to do make distclean from the top and then rerun the build? D=
oes
> >>>>> it work?
> >>>>>
> >>>> No, it broke even more, now 'make' doesn't work too. Anyway is there=
 a
> >>>> point for running Makefile generated from empty Makefile.am?
> >>>>
> >>> =A0 =A0 =A0The process is:
> >>>
> >>> make distclean
> >>> make autotools
> >>> ./configure {blah}
> >>>
> >>>
> >> git clone ltp-next
> >> make distclean
> >> make autotools
> >> ./configure
> >> cd testcases/realtime/
> >>
> > You have to run ./configure again here.
> =

> No. Running ./configure from the top will take care of this because of
> how configure.ac is setup.

Any update on this?

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
