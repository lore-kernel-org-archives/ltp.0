Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MaWzj-0007wR-TR
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 15:41:07 +0000
Received: from qw-out-1920.google.com ([74.125.92.148])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MaWzf-0001p8-Di
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 15:41:07 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1069332qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 10 Aug 2009 08:40:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1249892416.5187.10.camel@subratamodak.linux.ibm.com>
References: <1842FA33-8C6C-4BE1-8FB4-B8836F1C8F6E@kernel.crashing.org>
	<364299f40908061017g44fd05ecv9c6454ebf04badb4@mail.gmail.com>
	<2A1B6719-9C0B-4271-8A81-1730F79F5E33@kernel.crashing.org>
	<1249892416.5187.10.camel@subratamodak.linux.ibm.com>
Date: Mon, 10 Aug 2009 08:40:57 -0700
Message-ID: <364299f40908100840w329abda8q178a3b8ace628bfe@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] RANLIB not set?
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
To: subrata@linux.vnet.ibm.com
Cc: LTP <ltp-list@lists.sourceforge.net>

On Mon, Aug 10, 2009 at 1:20 AM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2009-08-07 at 08:14 -0500, Kumar Gala wrote:
>> On Aug 6, 2009, at 12:17 PM, Garrett Cooper wrote:
>>
>> > On Thu, Aug 6, 2009 at 9:18 AM, Kumar
>> > Gala<galak@kernel.crashing.org> wrote:
>> >> I'm seeing this on fedora 11 on ppc64:
>> >>
>> >> make[3]: Leaving directory `/root/ltp/testcases/network/ipv6'
>> >> make[3]: Entering directory `/root/ltp/testcases/network/lib6'
>> >> cc -Wall =A0-I../../../include -g -D_GNU_SOURCE =A0 -c -o runcc.o run=
cc.c
>> >> ar cr runcc.a runcc.o
>> >> runcc.a
>> >> make[3]: runcc.a: Command not found
>> >> make[3]: *** [runcc.a] Error 127
>> >> make[3]: Leaving directory `/root/ltp/testcases/network/lib6'
>> >> make[2]: *** [all] Error 2
>> >> make[2]: Leaving directory `/root/ltp/testcases/network'
>> >> make[1]: *** [all] Error 2
>> >> make[1]: Leaving directory `/root/ltp/testcases'
>> >> make: *** [all] Error 2
>> >>
>> >> - k
>> >
>> > =A0 =A0Make sure to export CROSS_COMPILER=3D1 at the top-level make, or
>> > define RANLIB=3D$(CROSS_COMPILE)ranlib, where $(CROSS_COMPILE) is the
>> > prefix for your compiler set, e.g. $(CROSS_COMPILE)gcc.
>> > =A0 =A0One of the many things that will be fixed in a more kosher mann=
er
>> > in the next couple months.
>> > Thanks,
>> > -Garrett
>>
>> I see you committed a change to the lib6/Makefile for ranlib. =A0I
>> believe we need a similar patch to the toplevel Makefile since it
>> exports RANLIB:
>>
>
> True. But, can you create a patch from LTPROOT, as, the below fails to
> apply:
>
> patching file Makefile
> Hunk #1 FAILED at 9.
> 1 out of 1 hunk FAILED -- saving rejects to file Makefile.rej
>
> Regards--
> Subrata
>
>> diff --git a/Makefile b/Makefile
>> index 953eddf..9f8056a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -9,6 +9,8 @@ AR=3D$(CROSS_COMPILER)ar
>> =A0 RANLIB=3D$(CROSS_COMPILER)ranlib
>> =A0 endif
>>
>> +RANLIB =A0 =A0 =A0 =A0 ?=3D ranlib
>> +

Hi Kumar,
    The suggestion you made (noble as it may have been) is completely
useless as you're not exporting the variable in the Makefile (and thus
the value goes out of scope when you drop into the lower level
Makefiles). Please see this link for more details:
http://www.gnu.org/software/make/manual/make.html#Variables_002fRecursion
    All in all, please be patient... give me another 2 weeks and I'll
have a better solution (the new Makefile infrastructure) back in HEAD.
I just did the quick fix because it was gating any building off of
HEAD.
Thanks,
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
