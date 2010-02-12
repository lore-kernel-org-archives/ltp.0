Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1Ng1OL-0005Mr-WE
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 19:41:30 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ng1OJ-0005OG-MM
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 19:41:29 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1CJbv2G005639
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 12:37:57 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1CJfGQY022322
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 12:41:17 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1CJfFPa017569
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 12:41:16 -0700
Date: Fri, 12 Feb 2010 13:41:14 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100212194114.GB23537@us.ibm.com>
References: <000001caabb7$fe895b60$fb9c1220$@co.jp>
	<20100212175125.GC15333@us.ibm.com>
	<364299f41002121117i4fcc7b5bua47579a6ee2d661a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002121117i4fcc7b5bua47579a6ee2d661a@mail.gmail.com>
Subject: Re: [LTP] "pidns17" problem in "2010-02-11" cvs
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Fri, Feb 12, 2010 at 9:51 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > Quoting Mitani (mitani@ryobi.co.jp):
> >> Hi,
> >>
> >> I tried to test with "2010-02-11" cvs in RHEL5.4 system.
> >> But the test brings termination of connection.
> >>
> >> I examined the phenomenon and discovered that "pidns17" test made
> >> accident and sshd stopped after the test.
> >>
> >>
> >> I had some problems.
> >>
> >> 1. I think that "tst_exit()" must be added last of "cleanup()"
> >> =A0 =A0function.
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> --- ./testcases/kernel/containers/pidns/pidns17.c =A0 =A0 =A0 2009-12-=
07
> >> 05:55:16.000000000 +0900
> >> +++ ./testcases/kernel/containers/pidns/pidns17.c.new =A0 2010-02-12
> >> 16:26:31.000000000 +0900
> >> @@ -104,7 +104,6 @@
> >>
> >> =A0 =A0 =A0 =A0 /* cleanup and exit */
> >> =A0 =A0 =A0 =A0 CLEANUP();
> >> - =A0 =A0 =A0 tst_exit();
> >> =A0}
> >>
> >> =A0/******************************************************************=
*****
> >> @@ -136,7 +135,6 @@
> >>
> >> =A0 =A0 =A0 =A0 /* cleanup and exit */
> >> =A0 =A0 =A0 =A0 CLEANUP();
> >> - =A0 =A0 =A0 tst_exit();
> >> =A0} =A0 =A0 =A0/* End main */
> >>
> >> =A0/*
> >> @@ -147,4 +145,5 @@
> >> =A0{
> >> =A0 =A0 =A0 =A0 /* Clean the test testcase as LTP wants*/
> >> =A0 =A0 =A0 =A0 TEST_CLEANUP;
> >> + =A0 =A0 =A0 tst_exit();
> >> =A0}
> >
> > Yeah I'm afraid I don't understand what CLEANUP and tst_exit exactly
> > do. =A0Hopefully Garrett can give an educated answer.
> =

> Mitani's correct -- this is what should be done... CLEANUP is a
> constant that maps to cleanup in the event that tst_brkm is called,
> because linux_syscall_numbers.h's copy of syscall calls tst_brkm
> internally if ENOSYS is returned...

Cool, thanks

-serge

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
