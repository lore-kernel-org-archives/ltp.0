Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N0LqT-000229-SZ
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 21:02:17 +0000
Received: from mail-ew0-f208.google.com ([209.85.219.208])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N0LqP-00059t-FK
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 21:02:17 +0000
MIME-Version: 1.0
In-Reply-To: <OF87E660BB.5D2E0F9D-ON85257655.005F2225-86257655.005F2F51@us.ibm.com>
References: <OF87E660BB.5D2E0F9D-ON85257655.005F2225-86257655.005F2F51@us.ibm.com>
Date: Tue, 20 Oct 2009 14:01:58 -0700
Message-ID: <364299f40910201401q7d1a6c67k32198b5487b5db92@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Fw: LTP vs. SLES11 -- Some FAILs.
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
To: Robert Paulsen <rpaulsen@us.ibm.com>
Cc: ltp-list@lists.sf.net

On Tue, Oct 20, 2009 at 10:21 AM, Robert Paulsen <rpaulsen@us.ibm.com> wrot=
e:
>
> Hello,
>
> I ran the latest LTP (20090930) against SLES11:
>
> # cat /etc/issue
> Welcome to SUSE Linux Enterprise Server 11 (ppc64) - Kernel \r (\l).
> # uname -a
> Linux beavis 2.6.27.19-5-ppc64 #1 SMP 2009-02-28 04:40:21 +0100 ppc64 ppc=
64 ppc64 GNU/Linux
>
> These were all run via "runalltests" so are part of the default set of LTP
> tests that run.
>
> There were a number of errors. I didn't expect this as I thought that one
> way or another the LTP would have been validated against a standard distro
> like SLES11.
>
> Are these known failures? In the LTP or SLES11?
>
> Some of these tests apparently rely on kernel configurations and/or
> available resources like real memory that cannot be guaranteed on any
> arbitrary installation. Should such tests be run by default?
>
> Some of these tests just look like sloppy tests, for example the
> cron_allow01 an cron_deny01 tests.
>
> Some tests assume they will be built on the same system on which they are
> run. In his case that assumption was true but it seems like a very unsafe
> assumption, especially if a cross build is needed. Even without a cross
> build the build and test systems may not always be the same -- the reason
> for "make package" as describe in README.ltp-devel and why the Makefile h=
as
> a CROSS_COMPILE macro.
>
> Here are the fails from the log file:
>
> eventfd2_03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 1
> inotify01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 1
> inotify02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 1
> ppoll01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 2
> quotactl01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> timer_getoverrun01 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> timer_gettime01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 1
> utimes01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> Cap_bounds =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 127
> su01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0=
 1
> cron02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> cron_deny01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 1
> cron_allow01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> at_deny01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 1
> at_allow01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> timer_delete02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> Numa-testcases =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> hugemmap03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> hugemmap04 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 1
> hugeshmat01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 6
> hugeshmat02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 6
> hugeshmat03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 2
> hugeshmctl01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 6
> hugeshmctl02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 6
> hugeshmctl03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 2
> hugeshmdt01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0 6
> hugeshmget01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 2
> hugeshmget02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 6
> hugeshmget03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 6
> hugeshmget05 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAIL =A0 =A0 =A0 2
>
> A number of tests FAILed despite not showing in the above list. Here is s=
ome info from the detailed output file:
>
> pid_namespace4 =A0 =A01 =A0TFAIL =A0: =A0Container init is killed by SIGK=
ILL !!!
> pid_namespace4 =A0 =A02 =A0TFAIL =A0: =A0Container init pid got killed by=
 signal 9
> pidns12 =A0 =A0 1 =A0TFAIL =A0: =A0cinit: signalling PID (from other name=
space) is not 0, but 27810.
> quotactl01 =A0 =A01 =A0TFAIL =A0: =A0quotactl01 failed, cmd=3D0x800002: T=
EST_ERRNO=3DEFAULT(14): Bad address
> quotactl01 =A0 =A02 =A0TFAIL =A0: =A0quotactl01 failed, cmd=3D0x800003: T=
EST_ERRNO=3DEFAULT(14): Bad address
> quotactl01 =A0 =A03 =A0TFAIL =A0: =A0quotactl01 failed, cmd=3D0x800007: T=
EST_ERRNO=3DEFAULT(14): Bad address
> quotactl01 =A0 =A04 =A0TFAIL =A0: =A0quotactl01 failed, cmd=3D0x800008: T=
EST_ERRNO=3DEFAULT(14): Bad address
> quotactl01 =A0 =A05 =A0TFAIL =A0: =A0quotactl01 failed, cmd=3D0x800005: T=
EST_ERRNO=3DEFAULT(14): Bad address
> quotactl01 =A0 =A06 =A0TFAIL =A0: =A0quotactl01 failed, cmd=3D0x800006: T=
EST_ERRNO=3DEFAULT(14): Bad address
> quotactl01 =A0 =A07 =A0TFAIL =A0: =A0quotactl01 failed, cmd=3D0x800004: T=
EST_ERRNO=3DEFAULT(14): Bad address
> quotactl01 =A0 =A08 =A0TFAIL =A0: =A0quotactl01 failed, cmd=3D0x800001: T=
EST_ERRNO=3DEFAULT(14): Bad address

Hi Robert,
    I'm not sure about the snapshot you're referring to, but the
latest version no longer uses CROSS_COMPILE. You instead must specify
CC, CXX, LD, etc either via configure or manually in config.mk, and
then move it over to $(abs_top_builddir)/include/mk/config.mk; the
preferred method is the former one.
    Some points:
    1. quotactl01, etc might have issues because they're half-baked
from the point of view that they were functionally moved over to
tst_res.c's output format, but instead don't call tst_exit(3) at the
end (which is required if you want a sensible exit code). These items
need to be found and squashed in the tree.
    2. genhtml.pl was broken because it's simple parsing method wasn't
updated to match the fact that it's now TPASS, TFAIL instead of PASS,
FAIL, etc. I fixed it a week ago.
    That aside, part of the reason I've written up execltp is to parse
the exec logs (as opposed to the output log because the output log is
all over the place) and find problems using the exec logs depending on
the tst_res format to provide all of the details -- I've found that
many test writers and porters to LTP have been inconsistent when
porting tests, and thus issues with results are harder to find than
they should be.
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
