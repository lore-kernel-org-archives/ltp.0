Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MYJ2G-0001uq-GZ
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:22:32 +0000
Received: from mail-yw0-f194.google.com ([209.85.211.194])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYJ28-00035q-H6
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:22:32 +0000
MIME-Version: 1.0
In-Reply-To: <1249387637.15587.29.camel@subratamodak.linux.ibm.com>
References: <d51f89b0908032310k20c3843am7ea069d03436a7a@mail.gmail.com>
	<1249387637.15587.29.camel@subratamodak.linux.ibm.com>
Date: Tue, 4 Aug 2009 17:46:25 +0530
Message-ID: <d51f89b0908040516i7c65740bi3e30e0972c8374fa@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: [LTP] Issue with rt_sigqueueinfo testcase in LTP.
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
To: ltp-list <ltp-list@lists.sf.net>

FYI...


---------- Forwarded message ----------
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Tue, Aug 4, 2009 at 5:37 PM
Subject: Re: Issue with rt_sigqueueinfo testcase in LTP.
To: rohit verma <rohit.170309@gmail.com>
Cc: maknayak@in.ibm.com


Hi Rohit,

On Tue, 2009-08-04 at 11:40 +0530, rohit verma wrote:
> Dear Manas Kumar Nayak,
>
> I have found an issue with rt_sigqueueinfo test-case.
>
> Following is the test output:
>
> rt_sigqueueinfo01 =A0 =A01 =A0PASS =A0: =A0Test Succeeded
> rt_sigqueueinfo01 =A0 =A01 =A0FAIL =A0: =A0Test Failed, errno=3D1 : Opera=
tion not permitted
> rt_sigqueueinfo01 =A0 =A01 =A0PASS =A0: =A0Test Succeeded
> rt_sigqueueinfo01 =A0 =A01 =A0FAIL =A0: =A0Test Failed, errno=3D1 : Opera=
tion not permitted
> rt_sigqueueinfo01 =A0 =A00 =A0WARN =A0: =A0tst_rmdir(): rmobj(/tmp/rt_3Fa=
SpK)
> failed: lstat(/tmp/rt_3FaSpK) failed; errno=3D2: No such file or
> directory
>
> I think the following lines are causing the failures:
>
> (Line - 164)
>
> uinfo.si_errno =3D 0;
> uinfo.si_code =3D 0;//SI_USER
> TEST(retval =3D syscall(__NR_rt_sigqueueinfo, getpid(), 17, &uinfo));
>
> Reason -
>
> You can observe the following comment & source when you look at the
> Linux source (v 2.6.29)
> (linux-2.6.29/kernel/signal.c)
>
> =A0 =A0 =A0 =A0 =A0 /* Not even root can pretend to send signals from the=
 kernel.
> =A0 =A0 =A0 =A0 =A0 =A0Nor can they impersonate a kill(), which adds sour=
ce info. =A0*/
> =A0 =A0 =A0 =A0 if (info.si_code >=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>
> which implies that si_code cannot be set to ' 0 ' (SI_USER) when
> invoking the rt_sigqueueinfo syscall.
>
>
> I am not sure how to fix this issue. But, a possible fix would be to
> remove the second set of fork &
> rt_sigqueueinfo invocations and use the first set (with SI_QUEUE). If
> needed, the loop count can be
> increased.

Please propose this over to the mailing list. Manas has just ported the
test case from Crackerjack to LTP. He may not be exactly aware of the
issues, as it was a blind port, which in one way was good, as the
porting generated issues, people interested discussed and solved
them ;-)

Regards--
Subrata

>
>




-- =

Regards,
Rohit

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
