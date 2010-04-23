Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O5D02-0003Oe-Bo
	for ltp-list@lists.sourceforge.net; Fri, 23 Apr 2010 07:08:30 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O5D00-0003re-59
	for ltp-list@lists.sourceforge.net; Fri, 23 Apr 2010 07:08:30 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3N74ShF028373
	for <ltp-list@lists.sourceforge.net>; Fri, 23 Apr 2010 01:04:28 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3N78M4B143952
	for <ltp-list@lists.sourceforge.net>; Fri, 23 Apr 2010 01:08:22 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3N08LY9029925
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 18:08:21 -0600
Date: Fri, 23 Apr 2010 12:38:08 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100423070808.GA3329@linux.vnet.ibm.com>
References: <n2wda0c1e761004221440xcdd24149lbfec28b682473d45@mail.gmail.com>
	<j2x42aa607e1004221638o1d369793idd2bd41b5da66b1a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <j2x42aa607e1004221638o1d369793idd2bd41b5da66b1a@mail.gmail.com>
Subject: Re: [LTP] [PATCH] linkat01: use . instead of /tmp
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
To: Henry Yei <hyei@mvista.com>, Bryan Freed <bfreed@google.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Apr 22, 2010 at 04:38:12PM -0700, Henry Yei wrote:
> Bryan, I've confirmed that the linkat01 test passes with this fix on
> x86 with 2.6.21 kernel and arm on 2.6.33 kernel. Thanks!
> =

> Henry Yei <hyei@mvista.com>

Thanks Bryan & Henry.

Merged into tree.
23e7806fec4c6be42fdf577559df5498cce45118

-Rishi
> =

> On Thu, Apr 22, 2010 at 2:40 PM, Bryan Freed <bfreed@google.com> wrote:
> > I have a fix for a failing LTP testcase. =A0Section 6 of the online LTP=
 doc
> > http://ltp.sourceforge.net/documentation/how-to/ltp.php#_7 says I can
> > request a test be added by sending to this list, and it looks from the
> > archive like the subject line for patches should contain "[LTP][PATCH]"=
, so
> > here goes. =A0There appears to be no standard diff format, so I will us=
e what
> > is convenient...
> > Running the ltp suite on ChromeOS (x86 with a 2.6.32 kernel) fails link=
at01
> > testcase 21:
> >
> > linkat01 =A0 21 =A0TFAIL =A0: =A0linkat() failed: TEST_ERRNO=3DEXDEV(18=
): Invalid
> > cross-device link
> > This is probably because my /tmp is mounted from someplace other than t=
he
> > filesystem that contains newdirfd.
> > The goal of testcase 21 is to demonstrate that linking a directory will=
 fail
> > EPERM. =A0The fix is to use olddir/. instead of /tmp.
> > diff -urN
> > ltp-full-20091231_vanilla/testcases/kernel/syscalls/linkat/linkat01.c
> > ltp-full-20091231/testcases/kernel/syscalls/linkat/linkat01.c
> > --- ltp-full-20091231_vanilla/testcases/kernel/syscalls/linkat/linkat01=
.c
> > =A0 =A0 2009-11-26 23:43:12.000000000 -0800
> > +++ ltp-full-20091231/testcases/kernel/syscalls/linkat/linkat01.c
> > 2010-04-12 16:28:59.000000000 -0700
> > @@ -158,7 +158,7 @@
> > =A0=A0 =A0 =A0 =A0{ &cwd_fd, "/proc/cpuinfo", &newdirfd, TEST_FILE1, 0,
> > =A0=A0 =A0 =A0 =A0 =A00, 0, EXDEV },
> > =A0=A0 =A0 =A0 =A0/* 21. directory link */
> > - =A0 =A0 =A0 { &cwd_fd, "/tmp", &newdirfd, TEST_FILE1, 0,
> > + =A0 =A0 =A0 { &olddirfd, ".", &newdirfd, TEST_FILE1, 0,
> > =A0=A0 =A0 =A0 =A0 =A00, 0, EPERM },
> > =A0=A0 =A0 =A0 =A0/* 22. invalid flag */
> > =A0=A0 =A0 =A0 =A0{ &olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 1,
> >
> > Let me know if this is the incorrect process for upstreaming LTP patche=
s.
> > bryan.
> > -----------------------------------------------------------------------=
-------
> >
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >
> >
> =

> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- =

Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
