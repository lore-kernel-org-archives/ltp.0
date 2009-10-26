Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N2Gay-0001FE-Sq
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 03:50:12 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N2Gap-00061E-N6
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 03:50:07 +0000
Received: by pwj6 with SMTP id 6so1584386pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Sun, 25 Oct 2009 20:49:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <op.u2dtmvt9u2flwt@debian>
References: <op.u00vt9vju2flwt@debian>
	<1255436013.8438.34.camel@subratamodak.linux.ibm.com>
	<1255890120.5359.18.camel@subratamodak.linux.ibm.com>
	<op.u2dtmvt9u2flwt@debian>
Date: Sun, 25 Oct 2009 20:49:57 -0700
Message-ID: <364299f40910252049g2b30f5afq1f689ccbb820e05b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] New test?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?ISO-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

2009/10/25 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
> On Sun, 18 Oct 2009 20:22:00 +0200, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
>
>> Jiri,
>>
>> Any further thoughts on this ?
>
> Yes, see the attachment.
>
> I created the directories for the different tests (rt_sigtimedwait,
> sigwaitinfo etc.), but to avoid copy-pasting the code, they share the same
> source. Please, tell me if that is OK.
>
> Regards
> =A0 =A0Jiri Palecek
>>
>> On Tue, 2009-10-13 at 17:43 +0530, Subrata Modak wrote:
>>>
>>> Hey Jiri,
>>>
>>> On Tue, 2009-09-29 at 16:28 +0200, Ji=F8=ED Pale=E8ek wrote:
>>> > Hello,
>>> >
>>> > I've decided to create a test for the rt_sigwaitinfo syscall. There a=
re
>>> > other functions with similar interface (defined by POSIX) in libc -
>>> > particularly sigwait, sigtimedwait and sigwaitinfo. The rt_sigwaitinfo
>>>
>>> The sigwait, sigtimedwait and sigwaitinfo testcases are not in LTP.
>>>
>>> > test could easily tests these too, so I wonder whether we want to test
>>> > these too, and if yes, whether these tests can be located in the same
>>> > executable.
>>>
>>> If you already have the logic to write the above tests, then please
>>> create separate tests for sigwait, sigtimedwait and sigwaitinfo
>>> (separate directories as well), and separate for rt_sigwaitinfo syscall.
>>>
>>> Regards--
>>> Subrata

    The Makefiles need to be rewritten because a) they don't use the
new infrastructure, and b) they break requirements for
out-of-build-tree support. Please read README.mk-devel and ping me
with any questions you may have.
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
