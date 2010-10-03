Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2CtT-0004Id-JG
	for ltp-list@lists.sourceforge.net; Sun, 03 Oct 2010 00:57:35 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2CtR-0008Kp-2k
	for ltp-list@lists.sourceforge.net; Sun, 03 Oct 2010 00:57:35 +0000
Received: by iwn2 with SMTP id 2so7053226iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 02 Oct 2010 17:57:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C8F8691.3050808@bull.net>
References: <4C8F8691.3050808@bull.net>
Date: Sat, 2 Oct 2010 17:57:27 -0700
Message-ID: <AANLkTimqhHtNiB3M4UphD0a_czp_e+_h56VUy18tn8VZ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] acltest01 Failed to find an available loopback device
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
To: "Jacky.Malcles" <Jacky.Malcles@bull.net>
Cc: ltp-list@lists.sourceforge.net

On Tue, Sep 14, 2010 at 7:28 AM, Jacky.Malcles <Jacky.Malcles@bull.net> wro=
te:
> hi garret,
>
> I get this when running acltest01:
>
> tag=3Dacl_test01 stime=3D1284123525
> cmdline=3D"export TCbin=3D$LTPROOT/testcases/bin;acl_test01"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> 10240+0 records in
> 10240+0 records out
> 10485760 bytes (10 MB) copied, 0.037594 seconds, 279 MB/s
> /opt/ltp/testcases/bin/acl_test01: line 128: loop_dev: command not found
> acltest01 =A0 =A01 =A0TCONF =A0: =A0[ losetup.1 ] Failed to find an avail=
able loopback
> device -- is the required support compiled in your kernel?
> <<<execution_status>>>
> ...
>
>
> So, if you agree, I suggest the following change,
> thanks,
> Jacky
>
> --- acl_test01.original 2010-09-14 14:49:48.000000000 +0200
> +++ acl_test01 =A02010-09-14 14:50:15.000000000 +0200
> @@ -125,7 +125,7 @@ else
>
> =A0 =A0 =A0 # Avoid hardcoded loopback device values (-f tries to find th=
e first
> =A0 =A0 =A0 # available loopback device name)!
> - =A0 =A0 =A0 if ! (LOOP_DEV=3D$(loop_dev -f) && [ "x$LOOP_DEV" =3D x ]);=
 then
> + =A0 =A0 =A0 if ! (LOOP_DEV=3D$(losetup -f) && [ "x$LOOP_DEV" =3D x ]); =
then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TCONF "[ losetup.1 ] Failed to find =
an available
> loopback device -- is the required support compiled in your kernel?"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 0
> =A0 =A0 =A0 fi

    Committed. Please provide a signed-off-by line next time.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
