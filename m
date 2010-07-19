Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Oammt-00048y-Vs
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 09:37:27 +0000
Date: Mon, 19 Jul 2010 11:35:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100719093511.GA13526@saboteur.suse.cz>
References: <9603429.236361279111653386.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1263127425.237831279112632038.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<4C3D7641020000E8000664BA@sinclair.provo.novell.com>
	<AANLkTimPGnf0duGznWcBDPd-wePqLfWUCUzMsFdFl7CO@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimPGnf0duGznWcBDPd-wePqLfWUCUzMsFdFl7CO@mail.gmail.com>
Subject: Re: [LTP] Is there a good way to check kernel config in LTP?
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
Cc: ltp-list <ltp-list@lists.sf.net>

> >> so MAX_SWAPFILES is not 30 anymore, it's 29. While LTP defines MAX_SWA=
PFILES
> >> to 30 in include/swaponoff.h(hmmm....hardcode, I don't think it's a go=
od
> >> idea :-|).
> >>
> >> So the way to solve(maybe) the problem is clear: change MAX_SWAPFILES
> >> to 29 when CONFIG_MEMORY_FAILURE is enabled. My question is: is there
> >> a good way to check whether a kernel option is enabled or not? I searc=
hed
> >> in the old discussions in this maillist and found nothing. I want to k=
now if
> >>
> >> the developers have some new ideas?
> >>
> >
> > I've seen 28 as the MAX as well, it all depends on the config options. =
=A0I've been looking at re-architecting the test to do some sort of repeat =
test to the max number of successful swap creations and then verifying that=
 the same number is reachable at least 2 times. =A0MAX_SWAPFILES is never e=
xported to userspace. =A0It's a compile time #define that depends on the ke=
rnel config options.
> =

>     What about /proc/config.gz (or something similar)? Seems like a
> simple enough thing to check for absolute clarity... don't remember
> the kernel option for that though.

As far as I know this option is disabled at least for debian see:

http://wiki.debian.org/KernelFAQ

So this would lead to state where the test looks for config in different
locations and this is IMHO too fragile to maintain.

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
