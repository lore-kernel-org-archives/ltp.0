Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N7kyI-00066k-Os
	for ltp-list@lists.sourceforge.net; Tue, 10 Nov 2009 07:16:58 +0000
Received: from mail-vw0-f198.google.com ([209.85.212.198])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N7kyC-0003Ep-Hb
	for ltp-list@lists.sourceforge.net; Tue, 10 Nov 2009 07:16:58 +0000
Received: by vws36 with SMTP id 36so1193855vws.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Nov 2009 23:16:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A078017CB194@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078016A156A@svexch01.mvista.com>
	<364299f40910271957g6fc5147bgfbf3fe4c08d73b7@mail.gmail.com>
	<8368651DACC1964480F951191B94A078016A1648@svexch01.mvista.com>
	<1257170357.4977.57.camel@subratamodak.linux.ibm.com>
	<8368651DACC1964480F951191B94A078016A1ACE@svexch01.mvista.com>
	<1257788375.7677.72.camel@subratamodak.linux.ibm.com>
	<8368651DACC1964480F951191B94A078017CB194@svexch01.mvista.com>
Date: Mon, 9 Nov 2009 23:16:45 -0800
Message-ID: <364299f40911092316q223d2073oc610dffc7474722b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1,
	5: pass correct valuefor 	sigset_t for mips
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Mon, Nov 9, 2009 at 2:12 PM, Henry Yei <hyei@mvista.com> wrote:
>> -----Original Message-----
>> From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com]
>> Sent: Monday, November 09, 2009 9:40 AM
>> To: Henry Yei
>> Cc: Garrett Cooper; LTP Mailing List
>> Subject: RE: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass correct
>> valuefor sigset_t for mips
>>
>> On Mon, 2009-11-02 at 14:09 -0800, Henry Yei wrote:
>> > Subrata,
>> >
>> > I've included Nicolas Joly's suggested removal of progdir to force
>> the test to create all test files in the temp directory in the attached
>> patch.
>> >
>> > I'm not sure why tst_exit() is needed when calling cleanup(), as it
>> would be called by cleanup(). I can add it back, if needed. Any other
>> comments on the the appropriateness of "sizeof(sigmask)" would also be
>> welcomed. There are a few other tests with similar issues.
>> >
>>
>> Henry,
>>
>> Probably because of heavy changes recently, this patch is not applying
>> properly. Can you please rebase your changes:
>>
>> patching file testcases/kernel/syscalls/ppoll/ppoll01.c
>> Hunk #3 FAILED at 98.
>> Hunk #4 FAILED at 127.
>> Hunk #5 FAILED at 185.
>> Hunk #6 FAILED at 252.
>> 4 out of 6 hunks FAILED -- saving rejects to file
>> testcases/kernel/syscalls/ppoll/ppoll01.c.rej
>>
>> Regards--
>> Subrata
>>
>> > > -----Original Message-----
>> > > From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com]
>> > > Sent: Monday, November 02, 2009 5:59 AM
>> > > To: Henry Yei
>> > > Cc: Garrett Cooper; LTP Mailing List
>> > > Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass correct
>> > > valuefor sigset_t for mips
>> > >
>> > > Any further work on this patch ?
>> > >
>> > > Regards--
>> > > Subrata
>> > >
>> > > On Wed, 2009-10-28 at 12:08 -0700, Henry Yei wrote:
>> > > > > -----Original Message-----
>> > > > > From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> > > > > Sent: Tuesday, October 27, 2009 7:57 PM
>> > > > > To: Henry Yei
>> > > > > Cc: LTP Mailing List
>> > > > > Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass
>> correct
>> > > > > value for sigset_t for mips
>> > > > >
>> > > > > On Tue, Oct 27, 2009 at 6:32 PM, Henry Yei <hyei@mvista.com>
>> wrote:
>> > > > > > All,
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > > The patch attached =A0for ppoll01:
>> > > > > >
>> > > > > > cleans up spacing and code style
>> > > > > >
>> > > > > > removes unneeded/broken debug option parsing
>> > > > > >
>> > > > > > if test fails, it prints out the last failed errno, rather
>> than
>> > > just
>> > > > > the
>> > > > > > last errno(which may have been successful)
>> > > > > >
>> > > > > > passes in correct size of sigset_t for mips
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > > Signed-off by: Henry Yei <hyei@mvista.com>
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > > This patch was tested/passed on x86, mips(little endian), and
>> > > > > ppc_82xx .
>> > > > >
>> > > > > 1. Please keep tst_exit() at the bottom.
>> > > > > 2. Why can't we do sizeof(sigsetmask) ?
>> > > > >
>> > > > > Thanks,
>> > > > > -Garrett
>> > > >
>> > > > Garrett,
>> > > >
>> > > > You want me to put tst_exit() at the bottom, even though it is
>> called
>> > > within cleanup()?
>> > > > You mean sizeof(sigmask) ~ sizeof(sigset_t), right? That code was
>> > > commented out since version 1.1 which I thought was odd too, so I
>> did
>> > > check sizeof(sigmask).
>> > > > However, sizeof(sigmask) on mips returns 128 which does not seem
>> > > correct. I haven't checked the other architectures, but I suspect
>> some
>> > > might have a similar mismatch. Apparently sigset_t may have
>> different
>> > > values when returned from glibc vs kernel space. More information
>> from
>> > > this post:
>> > > >
>> > > > http://lists.uclibc.org/pipermail/uclibc/2009-January/041850.html
>
>
> Subrata,
>
> I've included the ppoll01 patch which should apply cleanly to the latest =
in CVS.
>

Hi Henry,
    Could you change this line:

+				tst_resm(TFAIL, "%s failed - errno =3D %d : %s", TCID,
+						last_failed_errno, strerror(last_failed_errno));

    to this please?

+				tst_resm(TFAIL | TTERRNO, "%s failed", TCID);

    last_failed_errno should become TEST_ERRNO if this change is done, IIRC.

Thanks!
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
