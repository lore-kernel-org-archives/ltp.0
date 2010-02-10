Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nf1Nr-0001Dv-Df
	for ltp-list@lists.sourceforge.net; Wed, 10 Feb 2010 01:28:51 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nf1Nq-0006Nv-I7
	for ltp-list@lists.sourceforge.net; Wed, 10 Feb 2010 01:28:51 +0000
Received: by pxi9 with SMTP id 9so1010100pxi.24
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Feb 2010 17:28:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001caa9ef$56c61360$04523a20$@co.jp>
References: <000001caa319$039c8660$0ad59320$@co.jp>
	<364299f41002010046r315a6609xa3f4afd838cf0215@mail.gmail.com>
	<000001caa9ef$56c61360$04523a20$@co.jp>
Date: Tue, 9 Feb 2010 17:28:44 -0800
Message-ID: <364299f41002091728x382c9f7bj83672b1ed2dc26bf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] rt_sigaction{02-03} tests validation
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Tue, Feb 9, 2010 at 5:21 PM, Mitani <mitani@ryobi.co.jp> wrote:
>
>
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Monday, February 01, 2010 5:46 PM
>> To: Mitani
>> Cc: ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] rt_sigaction{02-03} tests validation
>>
>> On Mon, Feb 1, 2010 at 12:31 AM, Mitani <mitani@ryobi.co.jp> wrote:
>> > Hi,
>> >
>> > I understood that rt_sigaction01, rt_sigprocmask01 and rt_sigsuspend01
>> > tests failure is architecture(x86_64) specific issues.
>> > Sorry, I don't know how do I fix it, yet.
>> >
>> > But when I examined these issues, I noticed that rt_sigaction's test
>> > also has rt_sigaction{02-03} tests.
>> > Currently, rt_sigaction{02-03} are not run.
>> > I think that it's also necessary to run rt_sigaction{02-03} tests
>> > because rt_sigaction01 test well running at x86 architecture.
>> > How about add rt_sigaction{02-03} to the test case?
>> >
>> > If "./runtest/syscalls" is fixed, these tests succeed as follows:
>> >
>> > ------------
>> >
>> > Test Start Time: Mon Feb =A01 16:38:37 2010
>> > -----------------------------------------
>> > Testcase =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Result =A0 =A0 Ex=
it Value
>> > -------- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ------ =A0 =A0 --=
--------
>> > rt_sigaction01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
>> > rt_sigaction02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
>> > rt_sigaction03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
>> > -----------------------------------------------
>> > Total Tests: 3
>> > Total Failures: 0
>> > Kernel Version: 2.6.18-164.el5
>> > Machine Architecture: i686
>> > Hostname: 5-4.localdomain
>> >
>> > ------------
>> >
>> > Index:
>> > ./runtest/syscalls
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- runtest/syscalls.org =A0 =A0 =A0 =A02009-12-16 04:32:18.000000000 =
+0900
>> > +++ runtest/syscalls =A0 =A02010-02-01 16:48:43.000000000 +0900
>> > @@ -801,6 +801,8 @@
>> > =A0rmdir05 rmdir05
>> >
>> > =A0rt_sigaction01 rt_sigaction01
>> > +rt_sigaction02 rt_sigaction02
>> > +rt_sigaction03 rt_sigaction03
>> > =A0rt_sigprocmask01 rt_sigprocmask01
>> > =A0rt_sigprocmask02 rt_sigprocmask02
>> > =A0rt_sigqueueinfo01 rt_sigqueueinfo01
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Sounds like a plan. Will be committed in a few mins.
>> Thanks!
>> -Garrett
>
>
>
> Hi, Garrett,
>
> I tested it in x86 systems, but it seems still not fixed yet.
> Is there some problems?
> If it needs further revision, I'm glad when I get your help.
>
> I'm sorry for troubling you when you are busy.

    Done. Thanks for the reminder :).
-Garrett

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
