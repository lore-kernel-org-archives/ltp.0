Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PGNQI-0007IU-PE
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 03:02:02 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGNQG-0000Oi-NW
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 03:02:02 +0000
Received: by wyi11 with SMTP id 11so649766wyi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Nov 2010 19:01:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000301cb8146$a1f23510$e5d69f30$@co.jp>
References: <000301cb8146$a1f23510$e5d69f30$@co.jp>
Date: Wed, 10 Nov 2010 19:01:54 -0800
Message-ID: <AANLkTi=RO0geG8w_tZa-RRBinF96jDa=+coXpBrBjfgu@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "clock_getcpuclockid/5-1" test
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
Cc: ltp-list@lists.sourceforge.net, =?Big5?B?t+2ueSCwt6Wr?= <toza@ryobi.co.jp>

2010/11/10 Mitani <mitani@ryobi.co.jp>:
> Hi,
>
> Build of POSIX "conformance/interfaces/clock_getcpuclockid/5-1.c" test
> failed
> with following message:
> ------------
> conformance/interfaces/clock_getcpuclockid/5-1 compile FAILED; SKIPPING
> ../../../conformance/interfaces/clock_getcpuclockid/5-1.c: In function
> 'main':
> ../../../conformance/interfaces/clock_getcpuclockid/5-1.c:54: error:
> expected ';' before 'if'
> ------------
>
> Environment is as follows:
> =A0- RHEL5.5 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)
> =A0- RHEL4.8 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)
>
>
> I noticed some mistakes.
>
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclock=
id/
> 5-1.c =A0 2010-11-09 19:00:43.000000000 +0900
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclock=
id/
> 5-1.c =A0 2010-11-11 10:00:47.000000000 +0900
> @@ -50,14 +50,14 @@
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Try and get the cpu clock ID for init(1) :)... */
> - =A0 =A0 =A0 error =3D clock_getcpuclockid(1, &clockid_1)
> + =A0 =A0 =A0 error =3D clock_getcpuclockid(1, &clockid_1);
> =A0 =A0 =A0 =A0if (error =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("clock_getcpuclockid(1, ..) passed =
unexpectedly\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTS_UNRESOLVED;
> =A0 =A0 =A0 =A0} else if (error !=3D EPERM) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("clock_getcpuclockid(1, ..) failed =
with an improper "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"error (%d !=3D %d)\n", EP=
ERM, error);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTS_FAILED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTS_FAIL;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0printf("Test PASSED\n");
> =A0 =A0 =A0 =A0return PTS_PASS;

    Yeah... I probably committed some WIP code. Patch committed.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
