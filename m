Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PFlqy-00022Z-Lx
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 10:55:04 +0000
Received: from out20.sjc.mx.trendmicro.com ([216.99.131.77])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PFlqw-0000o0-NW
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 10:55:04 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cb74af$8658b390$930a1ab0$@co.jp>	<AANLkTimQc+8+ytEWT3zXVE1dCf-SKZp-hrt7RRkXUDX4@mail.gmail.com>	<000b01cb764a$12ae2050$380a60f0$@co.jp>	<AANLkTikYjD9UT5Tw7rkY9QJcN1kgKwu21wv6+6CORfVK@mail.gmail.com>	<000001cb7ce8$d8c95080$8a5bf180$@co.jp>
	<AANLkTin1JCcuvaX+6M4LxBJea14DWYoU4Tyq++N7gEr+@mail.gmail.com>
In-Reply-To: <AANLkTin1JCcuvaX+6M4LxBJea14DWYoU4Tyq++N7gEr+@mail.gmail.com>
Date: Tue, 9 Nov 2010 19:54:53 +0900
Message-ID: <000001cb7ffc$8a36e290$9ea4a7b0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Tuesday, November 09, 2010 6:28 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
> =

> On Fri, Nov 5, 2010 at 5:56 AM, Mitani <mitani@ryobi.co.jp> wrote:
> >> -----Original Message-----
> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> Sent: Tuesday, November 02, 2010 3:43 PM
> >> To: Mitani
> >> Cc: ltp-list@lists.sourceforge.net
> >> Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
> >>
> >> On Wed, Oct 27, 2010 at 7:44 PM, Mitani <mitani@ryobi.co.jp> wrote:
> >> >> -----Original Message-----
> >> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> >> Sent: Tuesday, October 26, 2010 3:57 PM
> >> >> To: Mitani
> >> >> Cc: ltp-list@lists.sourceforge.net
> >> >> Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
> >> >>
> >> >> On Mon, Oct 25, 2010 at 6:45 PM, Mitani <mitani@ryobi.co.jp>
> wrote:
> >> >> > Hi,
> >> >> >
> >> >> > I reported that build failure of POSIX test set
> >> >> "conformance/interfaces/
> >> >> > sched_yield/1-1" was still left in RHEL4.8 system:
> >> >> >
> >> >> >
> >> >>
> >>
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg1071
> >> >> 3.html
> >> >> >
> >> >> > In addition, build of the following tests failed by the reason
> >> of
> >> >> > "undefined reference":
> >> >>
> >> >> =A0 =A0 Some versions of gcc didn't function properly with
> -lpthread;
> >> try
> >> >> -pthread instead at the top-level LDLIBS file and see whether
> or
> >> not
> >> >> it works for you.
> >> >> HTH,
> >> >> -Garrett
> >> >
> >> > Hi,
> >> >
> >> > I tried to use "-pthread" instead of "-lpthread".
> >> > But "sched_yield/1-1" failed in my all archtectures (RHEL4.8-x86,
> >> x86_64,
> >> > ia64).
> >> > Other 27 tests, too.
> >>
> >> What does `man pthread_barrierattr_getpshared' say?
> =

> ...
> =

> > "man pthread_barrierattr_getpshared" in my system "RHEL4.8-x86_64".
> >
> > ------------
> > [root@RHEL48-LTP-EM64T make]# man pthread_barrierattr_getpshared
> > PTHREAD_BARRIERATTR_GETPSHARED(P)
> > PTHREAD_BARRIERATTR_GETPSHARED(P)
> >
> > NAME
> > =A0 =A0 =A0 pthread_barrierattr_getpshared,
> pthread_barrierattr_setpshared - get
> > and set the
> > =A0 =A0 =A0 process-shared attribute of the barrier =A0attributes =A0ob=
ject
> > (ADVANCED =A0REALTIME
> > =A0 =A0 =A0 THREADS)
> =

> RHEL sucks for compiling stuff (I remember because it used to be a
> reference platform when I was doing the Makefile work). Try swapping
> around -lrt and -lpthread in the LDLIBS file and see whether or not
> things work. If not, then I'd talk to Redhat and figure out what it
> doesn't work.
> -Garrett

I tried to build "sched_yield", and found that they succeeded to build =

in my system (all of RHEL4.8 - x86, x86_64, ia64).
I didn't notice that "-lpthread" added to "Makefile" of "sched_yield" =

from 2010/10/29 git.

It was October 27 that I tried "-pthread" last. After that, I merely =

revised "LDLIBS" automatically and did make with it.
Sorry!

Thank you--

-Tomonori Mitani



---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
