Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MTTaj-0004FV-BR
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 04:38:09 +0000
Received: from mail-px0-f174.google.com ([209.85.216.174])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTTab-0006S0-Jg
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 04:38:09 +0000
MIME-Version: 1.0
In-Reply-To: <200907211728.56027.vapier@gentoo.org>
References: <20090721.182542.1000278277145531816.caiqian@cclom.cn>
	<364299f40907210721q365aa8fdu21a1b2ff254bc60a@mail.gmail.com>
	<200907211728.56027.vapier@gentoo.org>
Date: Tue, 21 Jul 2009 21:38:00 -0700
Message-ID: <364299f40907212138rb1f671eke3aabd6587c0f925@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP Intermediate Release for JULY 2009 Build Failures
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
Cc: ltp-list@lists.sourceforge.net, ltp-list@lists.sf.net

On Tue, Jul 21, 2009 at 2:28 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Tuesday 21 July 2009 10:21:44 Garrett Cooper wrote:
>> I was tempted to fix the format string error, but I don't know what
>> the potential implications are of switching the data type from
>> u_int64_t to unsigned long long...
>
> dont do that. =A0just use the proper format string from inttypes.h.
> uint64_t f;
> printf("f =3D %"PRIu64"\n", f);
>
>> +/* Dummy function reference to avoid compiler warning from
>> linux_syscall_numbers.h. */
>> +extern void cleanup() { }
>
> this is incorrect for a few reasons. =A0it should read:
> +/* Dummy function as syscall() from linux_syscall_numbers.h uses cleanup=
() */
> void cleanup() { }
> -mike

    Ok. I'll fix it again, recompile, and test.
    Thanks for the review Mike :) (even though it's a bit post-mortem
now). I do lack a bit when it comes to C coding style and that's one
area that I want to improve upon.
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
