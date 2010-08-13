Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OjnrV-0003ro-7l
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:35:29 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OjnrR-0002c6-0O
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:35:29 +0000
Received: by fxm6 with SMTP id 6so1743010fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Aug 2010 23:35:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cb3834$4969dac0$dc3d9040$@co.jp>
References: <000001cb3834$4969dac0$dc3d9040$@co.jp>
Date: Thu, 12 Aug 2010 23:35:19 -0700
Message-ID: <AANLkTikOLq=3jQ61cdu3+__d8wJ9vNUxWn6_cYCNVb_d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "hugeshmat01" test
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

2010/8/9 Mitani <mitani@ryobi.co.jp>:
> Hi,
>
> I tried to run hugeshmat01 testcase, but it failed.
> This testcase failed in following systems.
> =A0 - RHEL5.5-ia64
> =A0 - RHEL4.8-x86_64
> =A0 - RHEL4.8-ia64
>
> I used latest git:
> =A0 ltp-dev-7c67a09a10268b5f9f503e0254f1f0f9f5ac2b69.tar.gz
> This testcase failed also in previous gits.
>
>
> RHEL5.5-ia64 log:
> ------------
> hugeshmat01 =A0 =A01 =A0TPASS =A0: =A0conditions and functionality are co=
rrect
> hugeshmat01 =A0 =A02 =A0TFAIL =A0: =A0hugeshmat01 call failed - errno =3D=
 22 : Invalid
> argument
> hugeshmat01 =A0 =A03 =A0TBROK =A0: =A0Remaining cases broken
> ------------
>
> It is caused by "EINVAL" failure of shmat().
>
> ---(hugeshmat01.c)---------
> [...]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i=3D0; i<TST_TOTAL; i++) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Use TEST macro to make =
the call
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0errno =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0addr =3D shmat(*(TC[i].shm=
id), (void *)(TC[i].addr),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TC[i]=
.flags);
> [...]
> ------------
>
> In second loop (i=3D1), arguments of shemat() are followings:
>
> =A0 shmat(id, 0x10000000eee, SHM_RND)
>
> This test expects that the return value of shmat() is rounded down to
> a multiple of SHMLBA.
> But shmat() failed in some systems.
> I deduced that "0x10000000eee" address may be outside of hugepages area.
>
> So I used the return value of first loop's shmat() instead of fixed
> address ("0x10000000eee").
> And the test succeeded.

The question I have to pose is: why would it do this if the other
address was deallocated?

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
