Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PdyiL-0005bp-0A
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 05:30:13 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdyiK-0003rx-5m
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 05:30:12 +0000
Received: by wyb40 with SMTP id 40so3412706wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 14 Jan 2011 21:30:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTimKGoNfnr0s5PgBxzx+hZOW_8j-k8Dewbw=2e8M@mail.gmail.com>
References: <AANLkTimKGoNfnr0s5PgBxzx+hZOW_8j-k8Dewbw=2e8M@mail.gmail.com>
Date: Fri, 14 Jan 2011 21:30:02 -0800
Message-ID: <AANLkTi=v15-cWirjBbNfks5GVmHPqXQzxo4dOOhDcodw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Bug Fix] fcntl15 is not completely ported to uClinux
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
To: Vivi <violetleigh@gmail.com>
Cc: LTP mailing list <ltp-list@lists.sourceforge.net>

On Wed, Dec 29, 2010 at 1:35 AM, Vivi <violetleigh@gmail.com> wrote:
> The code of fcntl15 is not completely ported to uClinux.
> So it will fail on uclinux platform.
>
> Bellow is the patch:
> --
> Index: testcases/kernel/syscalls/fcntl/fcntl15.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- testcases/kernel/syscalls/fcntl/fcntl15.c
> +++ testcases/kernel/syscalls/fcntl/fcntl15.c
> @@ -185,12 +185,17 @@
> =A0}

I manually applied the patch, but next time please submit a kosher version.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
