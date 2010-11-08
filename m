Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFZFf-00029N-Nc
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:27:43 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFZFe-00018m-DZ
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:27:43 +0000
Received: by wye20 with SMTP id 20so242839wye.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Nov 2010 13:27:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001cb7ce8$d8c95080$8a5bf180$@co.jp>
References: <000001cb74af$8658b390$930a1ab0$@co.jp>
	<AANLkTimQc+8+ytEWT3zXVE1dCf-SKZp-hrt7RRkXUDX4@mail.gmail.com>
	<000b01cb764a$12ae2050$380a60f0$@co.jp>
	<AANLkTikYjD9UT5Tw7rkY9QJcN1kgKwu21wv6+6CORfVK@mail.gmail.com>
	<000001cb7ce8$d8c95080$8a5bf180$@co.jp>
Date: Mon, 8 Nov 2010 13:27:35 -0800
Message-ID: <AANLkTin1JCcuvaX+6M4LxBJea14DWYoU4Tyq++N7gEr+@mail.gmail.com>
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

On Fri, Nov 5, 2010 at 5:56 AM, Mitani <mitani@ryobi.co.jp> wrote:
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Tuesday, November 02, 2010 3:43 PM
>> To: Mitani
>> Cc: ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
>>
>> On Wed, Oct 27, 2010 at 7:44 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> >> -----Original Message-----
>> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> >> Sent: Tuesday, October 26, 2010 3:57 PM
>> >> To: Mitani
>> >> Cc: ltp-list@lists.sourceforge.net
>> >> Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
>> >>
>> >> On Mon, Oct 25, 2010 at 6:45 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> >> > Hi,
>> >> >
>> >> > I reported that build failure of POSIX test set
>> >> "conformance/interfaces/
>> >> > sched_yield/1-1" was still left in RHEL4.8 system:
>> >> >
>> >> >
>> >>
>> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg1071
>> >> 3.html
>> >> >
>> >> > In addition, build of the following tests failed by the reason
>> of
>> >> > "undefined reference":
>> >>
>> >> =A0 =A0 Some versions of gcc didn't function properly with -lpthread;
>> try
>> >> -pthread instead at the top-level LDLIBS file and see whether or
>> not
>> >> it works for you.
>> >> HTH,
>> >> -Garrett
>> >
>> > Hi,
>> >
>> > I tried to use "-pthread" instead of "-lpthread".
>> > But "sched_yield/1-1" failed in my all archtectures (RHEL4.8-x86,
>> x86_64,
>> > ia64).
>> > Other 27 tests, too.
>>
>> What does `man pthread_barrierattr_getpshared' say?

...

> "man pthread_barrierattr_getpshared" in my system "RHEL4.8-x86_64".
>
> ------------
> [root@RHEL48-LTP-EM64T make]# man pthread_barrierattr_getpshared
> PTHREAD_BARRIERATTR_GETPSHARED(P)
> PTHREAD_BARRIERATTR_GETPSHARED(P)
>
> NAME
> =A0 =A0 =A0 pthread_barrierattr_getpshared, pthread_barrierattr_setpshare=
d - get
> and set the
> =A0 =A0 =A0 process-shared attribute of the barrier =A0attributes =A0obje=
ct
> (ADVANCED =A0REALTIME
> =A0 =A0 =A0 THREADS)

RHEL sucks for compiling stuff (I remember because it used to be a
reference platform when I was doing the Makefile work). Try swapping
around -lrt and -lpthread in the LDLIBS file and see whether or not
things work. If not, then I'd talk to Redhat and figure out what it
doesn't work.
-Garrett

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
