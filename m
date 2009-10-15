Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyPi0-0003RO-8o
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 12:45:32 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyPhg-0003Nw-Oj
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 12:45:19 +0000
Received: by pzk26 with SMTP id 26so724642pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Oct 2009 05:45:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910150543n6d370096q15bdc6e7e930bff0@mail.gmail.com>
References: <200910011340.32046.chandru@in.ibm.com>
	<1255552134.4892.12.camel@subratamodak.linux.ibm.com>
	<364299f40910141825k6d8a8e15w5843dd9d2574d262@mail.gmail.com>
	<200910151414.13027.chandru@in.ibm.com>
	<364299f40910150543n6d370096q15bdc6e7e930bff0@mail.gmail.com>
Date: Thu, 15 Oct 2009 05:45:06 -0700
Message-ID: <364299f40910150545t1aa8e539q474398012b2c0310@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH V2] ppoll01: add signal() syscall to register the
	signal handler
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
To: Chandru <chandru@in.ibm.com>
Cc: vapier@gentoo.org, ltp-list@lists.sourceforge.net

On Thu, Oct 15, 2009 at 5:43 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Oct 15, 2009 at 1:44 AM, Chandru <chandru@in.ibm.com> wrote:
>> On Thursday 15 October 2009 06:55:29 Garrett Cooper wrote:
>>> Just curious -- was the issue seen at the following point in the code
>>> previously?
>>>
>>> 361 =A0 =A0 =A0 =A0 =A0 =A0 TEST(sys_ret =3D syscall(__NR_ppoll, p_fds,=
 nfds, p_ts,
>>> p_sigmask, sigsetsize)); /* <-- Blocks here indefinitely */
>>> 362 =A0 =A0 =A0 =A0 =A0 =A0 sys_errno =3D errno;
>>> 363 =A0 =A0 =A0 =A0 =A0 =A0 if (sys_ret <=3D 0 || tc->ret < 0)
>>> 364 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto TEST_END;
>>> 365
>>> 366 =A0 =A0 =A0 =A0 =A0 =A0 cmp_ok =3D fds[0].revents =3D=3D tc->expect=
_revents;
>>>
>>> I've seen this issue 1 out of the 8 or 9 times I've run this test.
>>
>> Nope, without the patch we only see case00 completing and the test exits=
 while in the middle of case01
>>
>> # ./ppoll01
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case00) START
>> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
>> RESULT: return value(ret)=3D =A0 =A0 =A0 1 errno=3D0 (Success)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case00) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case01) START
>> #
>>
>>
>> With the patch we see the output as follows...
>>
>> # ./ppoll01
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case00) START
>> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
>> RESULT: return value(ret)=3D =A0 =A0 =A0 1 errno=3D0 (Success)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case00) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case01) START
>> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
>> RESULT: return value(ret)=3D =A0 =A0 =A0 0 errno=3D0 (Success)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case01) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case02) START
>> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
>> RESULT: return value(ret)=3D =A0 =A0 =A0 0 errno=3D0 (Success)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case02) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case03) START
>> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
>> RESULT: return value(ret)=3D =A0 =A0 =A0 1 errno=3D0 (Success)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case03) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case04) START
>> EXPECT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> RESULT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case04) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case05) START
>> EXPECT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> RESULT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case05) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case06) START
>> EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
>> RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case06) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case07) START
>> EXPECT: return value(ret)=3D-1 errno=3D14 (Bad address)
>> RESULT: return value(ret)=3D-1 errno=3D14 (Bad address)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case07) END =3D> OK
>> ppoll01 =A0 =A0 1 =A0TPASS =A0: =A0ppoll01 call succeeded
>
> =A0 =A0Interesting. The cause may be the same, but the effect may be
> different, as this is blocking with this section of the test:
>
> =A0 =A0 =A0 =A0case MINUS_NSEC:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ts.tv_sec =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ts.tv_nsec =3D -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p_ts =3D &ts;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0Which is fine, but depending on whether or not a previous testcase
> fails with EOK and a return code of 0. Example:

Sorry -- incomplete thought.

Depending on whether or not it fails with a return code of 0 -- it may
be in our best interest to retry a finite number of times, then give
up and cordon off that testcase so that it can't run and thus block
indefinitely.

> #define _GNU_SOURCE
> #include <signal.h>
> #include <poll.h>
> #include <errno.h>
> #include <string.h>
>
> int main (void) {
>
> =A0 =A0 =A0 =A0struct pollfd fds;
> =A0 =A0 =A0 =A0struct timespec timeout;
> =A0 =A0 =A0 =A0sigset_t sigmask;
>
> =A0 =A0 =A0 =A0sigemptyset(&sigmask);
>
> =A0 =A0 =A0 =A0timeout.tv_sec =3D 0;
> =A0 =A0 =A0 =A0timeout.tv_nsec =3D 5e8; /* .5 sec */
>
> =A0 =A0 =A0 =A0if (ppoll(&fds, 1, &timeout, &sigmask) <=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("ppoll");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 1;
> }
>
> gcooper@orangebox ~ $ ./ppoll_test
> ppoll: Success
>
> =A0 =A0The manpage doesn't say that it shouldn't set errno to ETIME, etc,
> so this is a legitimate return value (despite the fact that the
> testcase fails claiming that the subtestcase failed and the call
> succeeded, IIRC -- or maybe it was another test...).
> =A0 =A0I'll definitely keep my eyes peeled for this particular issue
> though in the future.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
