Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OdOiO-0001GC-IJ
	for ltp-list@lists.sourceforge.net; Mon, 26 Jul 2010 14:31:36 +0000
Date: Mon, 26 Jul 2010 16:27:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100726142715.GA18910@saboteur.suse.cz>
References: <20100722133111.GA30090@saboteur.suse.cz>
	<AANLkTimAD6agCAWt4g3R1V0jvAKvTMe7wgOvDZ7cCH8v@mail.gmail.com>
	<20100722181736.GA5936@saboteur.suse.cz>
	<AANLkTikTXuwc4hGrLRqkcoE12_6RMhNP7fW2oBLHafA0@mail.gmail.com>
	<20100723101338.GB19210@saboteur.suse.cz>
	<AANLkTim+_Ue6Vp4z-0KCFnzvJG4nvG0qO9fN73xG6WMe@mail.gmail.com>
	<20100726095517.GB4609@saboteur.suse.cz>
	<AANLkTikBASNfcrhisVrkd6K_sMc-soWbkWJ7j5G4UGXk@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikBASNfcrhisVrkd6K_sMc-soWbkWJ7j5G4UGXk@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix pthread_mutex_getprioceiling testcase
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
> >> =A0 =A0 I just now noticed the PTHREAD_PRIO_PROTECT portion of the pat=
ch.
> >> The testcase passes now (I can vouch for it passing on FreeBSD), but
> >> none of the POSIX specs I read mention anything about this being a
> >> hard requirement. So something needs to be figured out as far as
> >> whether or not the specs are broken, or this an issue with the
> >> pthreads implementation on both FreeBSD and Linux.
> >
> > Yes, I was unable to find this in the posix too. I consulted our glibc
> > maintainer and all I've got was "it doesn't work without
> > PTHREAD_PRIO_PROTECT". And even free pages from O'Reilly "A POSIX
> > Standart for Better Mutiprocessing" seems to suggest that. I'll try to
> > get that book as it seems to be only source of documentation for
> > realtime threads I know about. Anyway it does make sense to return
> > priority only for mutexes that can be prioritized.
> =

>     I just committed a slightly modified version of your III patch.
> I'll have to chase down the POSIX people about this discrepancy...

Okay ;).

Still there are other pthread tests to fix. May be we sould make the
function print_pthread_error() library call so that it could be used
from other openposix pthread tests.

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share =

of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
