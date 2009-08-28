Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mgwag-0002u6-5Z
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 08:13:46 +0000
Received: from mail-qy0-f204.google.com ([209.85.221.204])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MgwaZ-0001n3-RM
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 08:13:46 +0000
Received: by qyk42 with SMTP id 42so1053901qyk.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 28 Aug 2009 01:13:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200908270737.32793.vapier@gentoo.org>
References: <alpine.LRH.2.00.0908261719130.29807@vixen.sonytel.be>
	<200908270606.16787.vapier@gentoo.org>
	<alpine.LRH.2.00.0908271311410.22490@vixen.sonytel.be>
	<200908270737.32793.vapier@gentoo.org>
Date: Fri, 28 Aug 2009 01:13:33 -0700
Message-ID: <364299f40908280113h19ffa7dbwe0c1a52efe81112f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] su01: Yellow Dog Linux doesn't support passwd -e
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, ltp-list@lists.sourceforge.net

On Thu, Aug 27, 2009 at 4:37 AM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Thursday 27 August 2009 07:12:01 Geert Uytterhoeven wrote:
>> On Thu, 27 Aug 2009, Mike Frysinger wrote:
>> > On Thursday 27 August 2009 05:49:49 Geert Uytterhoeven wrote:
>> > > Next question: Does Google Translator do bash =3D> expect? ;-)
>> >
>> > not sure what you mean ... program options are not translated
>>
>> The script that does the test is written in expect.
>
> not sure whether you want to convert it all to expect (TCL) or you actual=
ly
> meant "expect =3D> bash". =A0while converting POSIX shell to TCL is prett=
y easy,
> going the other way is largely infeasible. =A0expect does the right thing=
 with
> ttys and sessions and such which are either a huge hack under POSIX shell=
 or
> downright impossible.
>
> in either case, i'm not interested in converting anything as i dont use t=
hese
> tests ;)

    Unless you plan on writing an application in C which will do the
work of reading from stdout / stderr and writing to stdin, I would
call it a moot point. Even then, I would think it unwise to do that...
HTH,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
