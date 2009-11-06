Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6UjT-0003qz-3F
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:44:27 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6UjK-0005P8-1g
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:44:27 +0000
Received: by pwi18 with SMTP id 18so856029pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Nov 2009 11:44:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200911061439.22257.vapier@gentoo.org>
References: <20091106095745.GA25377@basil.fritz.box>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<20091106191343.GC819@basil.fritz.box>
	<200911061439.22257.vapier@gentoo.org>
Date: Fri, 6 Nov 2009 11:44:11 -0800
Message-ID: <364299f40911061144w73d5d382i6c7b9832ddab99a6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>

On Fri, Nov 6, 2009 at 11:39 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Friday 06 November 2009 14:13:43 Andi Kleen wrote:
>> > I've considered adding a configure check for the make version. I'm
>> > probably going to do it this weekend to avoid support issues like
>> > these.
>>
>> That's not a solution.
>>
>> Please just fix the makefiles or revert this misguided change
>> and give us working makefiles back.
>>
>> From a quick look at the mailing list archives that doesn't
>> even seem to be the only problem with this "improvement".
>
> again, please stop wasting our time with your "revert it" comments. =A0it=
 isnt
> going to happen. =A0especially considering you apparently have no signfic=
ant
> plans in helping maintain the huge code base that is LTP.
>
> we can look at working around bugs in make-3.80 if/since there are a numb=
er of
> people who would like this functionality.



I'll see whether or not there are other ways to skin the proverbial
can to get make 3.80 to work, but the problem is that what I'm going
to be providing in make <3.81 will be hacks, not solutions to fill in
functional gaps.

Also, mass deploying (IMO) make 3.81 shouldn't be that hard if the IT
infrastructure is setup properly with NFS or some other mass-package
deployment system. It's simply:

./configure [config-options]
make all install

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
