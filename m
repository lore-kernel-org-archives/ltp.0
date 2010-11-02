Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PDAaE-0007Ji-GC
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 06:43:02 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PDAaD-0007x2-EB
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 06:43:02 +0000
Received: by wwb31 with SMTP id 31so6412202wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Nov 2010 23:42:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000b01cb764a$12ae2050$380a60f0$@co.jp>
References: <000001cb74af$8658b390$930a1ab0$@co.jp>
	<AANLkTimQc+8+ytEWT3zXVE1dCf-SKZp-hrt7RRkXUDX4@mail.gmail.com>
	<000b01cb764a$12ae2050$380a60f0$@co.jp>
Date: Mon, 1 Nov 2010 23:42:55 -0700
Message-ID: <AANLkTikYjD9UT5Tw7rkY9QJcN1kgKwu21wv6+6CORfVK@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Wed, Oct 27, 2010 at 7:44 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Tuesday, October 26, 2010 3:57 PM
>> To: Mitani
>> Cc: ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
>>
>> On Mon, Oct 25, 2010 at 6:45 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> > Hi,
>> >
>> > I reported that build failure of POSIX test set
>> "conformance/interfaces/
>> > sched_yield/1-1" was still left in RHEL4.8 system:
>> >
>> >
>> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg1071
>> 3.html
>> >
>> > In addition, build of the following tests failed by the reason of
>> > "undefined reference":
>>
>> =A0 =A0 Some versions of gcc didn't function properly with -lpthread; try
>> -pthread instead at the top-level LDLIBS file and see whether or not
>> it works for you.
>> HTH,
>> -Garrett
>
> Hi,
>
> I tried to use "-pthread" instead of "-lpthread".
> But "sched_yield/1-1" failed in my all archtectures (RHEL4.8-x86, x86_64,
> ia64).
> Other 27 tests, too.

What does `man pthread_barrierattr_getpshared' say?
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
