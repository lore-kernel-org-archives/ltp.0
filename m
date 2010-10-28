Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PBIU1-00058t-3T
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 02:44:53 +0000
Received: from out17.sjc.mx.trendmicro.com ([216.99.131.74])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PBITz-0007kH-GW
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 02:44:53 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cb74af$8658b390$930a1ab0$@co.jp>
	<AANLkTimQc+8+ytEWT3zXVE1dCf-SKZp-hrt7RRkXUDX4@mail.gmail.com>
In-Reply-To: <AANLkTimQc+8+ytEWT3zXVE1dCf-SKZp-hrt7RRkXUDX4@mail.gmail.com>
Date: Thu, 28 Oct 2010 11:44:42 +0900
Message-ID: <000b01cb764a$12ae2050$380a60f0$@co.jp>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Tuesday, October 26, 2010 3:57 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
> 
> On Mon, Oct 25, 2010 at 6:45 PM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi,
> >
> > I reported that build failure of POSIX test set
> "conformance/interfaces/
> > sched_yield/1-1" was still left in RHEL4.8 system:
> >
> >
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg1071
> 3.html
> >
> > In addition, build of the following tests failed by the reason of
> > "undefined reference":
> 
>     Some versions of gcc didn't function properly with -lpthread; try
> -pthread instead at the top-level LDLIBS file and see whether or not
> it works for you.
> HTH,
> -Garrett

Hi,

I tried to use "-pthread" instead of "-lpthread".
But "sched_yield/1-1" failed in my all archtectures (RHEL4.8-x86, x86_64,
ia64).
Other 27 tests, too.


Thanks--

-Tomonori Mitani



------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
