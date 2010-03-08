Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NoX8X-0001up-JR
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 07:12:21 +0000
Received: from out07.sjc.mx.trendmicro.com ([216.99.131.23])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NoX8V-0008UQ-W3
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 07:12:21 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000301cabb68$7fb08c30$7f11a490$@co.jp>	
	<201003051529.20596.vapier@gentoo.org>
	<364299f41003051323y4c63e0dbx3d721c08296c9524@mail.gmail.com>
In-Reply-To: <364299f41003051323y4c63e0dbx3d721c08296c9524@mail.gmail.com>
Date: Mon, 8 Mar 2010 16:12:10 +0900
Message-ID: <000001cabe8e$ab63ac30$022b0490$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] Is there another method to download?
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
> Sent: Saturday, March 06, 2010 6:23 AM
> To: Mike Frysinger
> Cc: ltp-list@lists.sourceforge.net; Mitani
> Subject: Re: [LTP] Is there another method to download?
> =

> On Fri, Mar 5, 2010 at 12:29 PM, Mike Frysinger <vapier@gentoo.org>
> wrote:
> > On Thursday 04 March 2010 02:01:22 Mitani wrote:
> >> I tried to get source by using GIT.
> >> But It failed with following message:
> >>
> >> ------------
> >> # git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git
> ltp-dev
> >> Initialized empty Git repository in /home/mitani/wk/ltp-dev/.git/
> >> fatal: Unable to look up ltp.git.sourceforge.net (port 9418)
> (Temporary
> >> failure in name resolution)
> >> #
> >> ------------
> >>
> >> It seems to be caused by the fact that port 9418 does not open.
> >> This is a problem by me.
> >> But I think that there are some companies which don't open a port
> 9418
> >> due to the security. I think that it becomes the problem in those
> >> companies that GIT cannot be used.
> >>
> >> I'm saved very much if there is the method to download via HTTP.
> >
> > we have no control over this. =A0talk to sf.net about the issue.
> >
> > in the meantime, use the gitweb interface to download snapshots.
> =

>     Can you DNS resolve ltp.git.sourceforge.net from that machine?
> Thanks,
> -Garrett


I tried and succeeded to get from "ltp.git.sourceforge.net".

Thank you!

-Tomonori MItani





---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
