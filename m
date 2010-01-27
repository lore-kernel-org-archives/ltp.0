Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Na3mD-0005FL-Rc
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 09:01:29 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Na3mC-0002Kk-PO
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 09:01:29 +0000
Received: by pxi38 with SMTP id 38so3907pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jan 2010 01:01:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B5FCC2D.7070304@jp.fujitsu.com>
References: <4B5FCC2D.7070304@jp.fujitsu.com>
Date: Wed, 27 Jan 2010 01:01:21 -0800
Message-ID: <364299f41001270101s6821a3a3l64bf928e599073cc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix aio_suspend/3-1
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
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 26, 2010 at 9:16 PM, Yasuaki Ishimatsu
<isimatu.yasuaki@jp.fujitsu.com> wrote:
> Hi all
>
> When the aio_suspend/3-1.test ran, SIGSEGV occured with following message
> on my x86_64 box.
>
> ---
> /bin/sh: line 38: 10675 Segmentation fault =A0 =A0 =A0./t0 240 conformanc=
e/interfaces/aio_suspend/3-1.test
>> $COMPLOG 2>&1
> ---
>
> This test does not initialize a list[1] array as follows.
>
> ---
> =A040 int main()
> ...
> =A088 =A0 =A0 =A0 =A0 list[0] =3D NULL;
> =A089 =A0 =A0 =A0 =A0 list[2] =3D &aiocb[0];
> =A090 =A0 =A0 =A0 =A0 list[3] =3D NULL;
> =A091 =A0 =A0 =A0 =A0 list[4] =3D NULL;
> =A092 =A0 =A0 =A0 =A0 list[5] =3D &aiocb[1];
> =A093 =A0 =A0 =A0 =A0 list[6] =3D &aiocb[2];
> =A094 =A0 =A0 =A0 =A0 list[7] =3D NULL;
> ...
> ---
>
> So, list[1] holds a strange value. Since aio_suspend() uses this value as=
 address,
> SIGSEGV occurred.
>
> When applying this patch, this test succeeds as follows.
>
> ---
> conformance/interfaces/aio_suspend/3-1: execution: PASS
> ---
>
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>
> Index: ltp-2010-01-27/testcases/open_posix_testsuite/conformance/interfac=
es/aio_suspend/3-1.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp-2010-01-27.orig/testcases/open_posix_testsuite/conformance/interf=
aces/aio_suspend/3-1.c
> 2010-01-27 11:44:30.000000000 +0900
> +++ ltp-2010-01-27/testcases/open_posix_testsuite/conformance/interfaces/=
aio_suspend/3-1.c
> 2010-01-27 11:45:23.000000000 +0900
> @@ -82,6 +82,7 @@ int main()
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0list[0] =3D NULL;
> + =A0 =A0 =A0 list[1] =3D NULL;
> =A0 =A0 =A0 =A0list[2] =3D &aiocb[0];
> =A0 =A0 =A0 =A0list[3] =3D NULL;
> =A0 =A0 =A0 =A0list[4] =3D NULL;

    Wouldn't it just be better to memset(&list, 0, sizeof(list)) the
array and just set that one array value to &aiocb[0]? Seems like a
much better idea...
Thanks,
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
