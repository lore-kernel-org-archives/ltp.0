Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1N2hSY-0007MV-5e
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 08:31:18 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N2hSM-0002On-H4
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 08:31:13 +0000
Date: Tue, 27 Oct 2009 10:29:16 +0100
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
References: <op.u00vt9vju2flwt@debian>
	<1255436013.8438.34.camel@subratamodak.linux.ibm.com>
	<1255890120.5359.18.camel@subratamodak.linux.ibm.com>
	<op.u2dtmvt9u2flwt@debian>
	<364299f40910252049g2b30f5afq1f689ccbb820e05b@mail.gmail.com>
Message-ID: <op.u2gcm2uyu2flwt@debian>
In-Reply-To: <364299f40910252049g2b30f5afq1f689ccbb820e05b@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Mon, 26 Oct 2009 04:49:57 +0100, Garrett Cooper <yanegomi@gmail.com>  =

wrote:

> 2009/10/25 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
>> On Sun, 18 Oct 2009 20:22:00 +0200, Subrata Modak
>> <subrata@linux.vnet.ibm.com> wrote:
>>
>>> Jiri,
>>>
>>> Any further thoughts on this ?
>>
>> Yes, see the attachment.
>>
>> I created the directories for the different tests (rt_sigtimedwait,
>> sigwaitinfo etc.), but to avoid copy-pasting the code, they share the  =

>> same
>> source. Please, tell me if that is OK.
>>
>> Regards
>> =A0 =A0Jiri Palecek
>>>
>>> On Tue, 2009-10-13 at 17:43 +0530, Subrata Modak wrote:
>>>>
>>>> Hey Jiri,
>>>>
>>>> On Tue, 2009-09-29 at 16:28 +0200, Ji=F8=ED Pale=E8ek wrote:
>>>> > Hello,
>>>> >
>>>> > I've decided to create a test for the rt_sigwaitinfo syscall. There  =

>>>> are
>>>> > other functions with similar interface (defined by POSIX) in libc -
>>>> > particularly sigwait, sigtimedwait and sigwaitinfo. The  =

>>>> rt_sigwaitinfo
>>>>
>>>> The sigwait, sigtimedwait and sigwaitinfo testcases are not in LTP.
>>>>
>>>> > test could easily tests these too, so I wonder whether we want to  =

>>>> test
>>>> > these too, and if yes, whether these tests can be located in the  =

>>>> same
>>>> > executable.
>>>>
>>>> If you already have the logic to write the above tests, then please
>>>> create separate tests for sigwait, sigtimedwait and sigwaitinfo
>>>> (separate directories as well), and separate for rt_sigwaitinfo  =

>>>> syscall.
>>>>
>>>> Regards--
>>>> Subrata
>
>     The Makefiles need to be rewritten because a) they don't use the
> new infrastructure, and b) they break requirements for
> out-of-build-tree support. Please read README.mk-devel and ping me
> with any questions you may have.

I read the document, but I'm not sure I understand it. What are the actual  =

requirements on makefile rules that are needed? I looked at the  =

commands/unzip makefile, and I can't see where does $(ZIPFILE) come from,  =

and how does it and $(DIR) address out-of-tree build.

I think I'm gonna refactor the code so I don't need that special make rule.

Regards
     Jiri Palcek

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
