Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NbrvB-0003pM-VI
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 08:46:13 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nbrv9-0007XZ-OK
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 08:46:13 +0000
Received: by pxi27 with SMTP id 27so3647201pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Feb 2010 00:46:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001caa319$039c8660$0ad59320$@co.jp>
References: <000001caa319$039c8660$0ad59320$@co.jp>
Date: Mon, 1 Feb 2010 00:46:05 -0800
Message-ID: <364299f41002010046r315a6609xa3f4afd838cf0215@mail.gmail.com>
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

On Mon, Feb 1, 2010 at 12:31 AM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I understood that rt_sigaction01, rt_sigprocmask01 and rt_sigsuspend01
> tests failure is architecture(x86_64) specific issues.
> Sorry, I don't know how do I fix it, yet.
>
> But when I examined these issues, I noticed that rt_sigaction's test
> also has rt_sigaction{02-03} tests.
> Currently, rt_sigaction{02-03} are not run.
> I think that it's also necessary to run rt_sigaction{02-03} tests
> because rt_sigaction01 test well running at x86 architecture.
> How about add rt_sigaction{02-03} to the test case?
>
> If "./runtest/syscalls" is fixed, these tests succeed as follows:
>
> ------------
>
> Test Start Time: Mon Feb =A01 16:38:37 2010
> -----------------------------------------
> Testcase =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Result =A0 =A0 Exit =
Value
> -------- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ------ =A0 =A0 -----=
-----
> rt_sigaction01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
> rt_sigaction02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
> rt_sigaction03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
> -----------------------------------------------
> Total Tests: 3
> Total Failures: 0
> Kernel Version: 2.6.18-164.el5
> Machine Architecture: i686
> Hostname: 5-4.localdomain
>
> ------------
>
> Index:
> ./runtest/syscalls
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- runtest/syscalls.org =A0 =A0 =A0 =A02009-12-16 04:32:18.000000000 +09=
00
> +++ runtest/syscalls =A0 =A02010-02-01 16:48:43.000000000 +0900
> @@ -801,6 +801,8 @@
> =A0rmdir05 rmdir05
>
> =A0rt_sigaction01 rt_sigaction01
> +rt_sigaction02 rt_sigaction02
> +rt_sigaction03 rt_sigaction03
> =A0rt_sigprocmask01 rt_sigprocmask01
> =A0rt_sigprocmask02 rt_sigprocmask02
> =A0rt_sigqueueinfo01 rt_sigqueueinfo01
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Sounds like a plan. Will be committed in a few mins.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
