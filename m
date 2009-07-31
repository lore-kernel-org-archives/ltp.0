Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWnnN-0002ML-5f
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 08:48:57 +0000
Received: from rv-out-0708.google.com ([209.85.198.250])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWnnF-0000wH-J3
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 08:48:57 +0000
Received: by rv-out-0708.google.com with SMTP id b17so514833rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Fri, 31 Jul 2009 01:48:42 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 31 Jul 2009 01:48:42 -0700
Message-ID: <364299f40907310148q75cee4f7q1cb8117360459a29@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Remove getgid02 from all runtest files (was "[PATCH]
	Remove getgid02 from ltplite runtest file")
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
To: LTP list <ltp-list@lists.sourceforge.net>

On Fri, Jul 31, 2009 at 1:44 AM, Garrett Cooper<yanegomi@gmail.com> wrote:
> Looks like someone removed the source file but forgot to remove the
> reference to it in the ltplite runtest file. This fixes that.
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Index: runtest/ltplite
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/runtest/ltplite,v
> retrieving revision 1.20.2.1
> diff -u -r1.20.2.1 ltplite
> --- runtest/ltplite =A0 =A0 27 Jul 2009 00:21:16 -0000 =A0 =A0 =A01.20.2.1
> +++ runtest/ltplite =A0 =A0 31 Jul 2009 08:43:22 -0000
> @@ -287,7 +287,6 @@
> =A0geteuid01 geteuid01
>
> =A0getgid01 getgid01
> -getgid02 getgid02
> =A0getgid03 getgid03
>
> =A0getgroups01 getgroups01
>

And it appears that I missed some spots...

This removes _all_ references to getgid02 from _all_ of the runtest files:

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: runtest/ltplite
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/runtest/ltplite,v
retrieving revision 1.20.2.1
diff -u -r1.20.2.1 ltplite
--- runtest/ltplite     27 Jul 2009 00:21:16 -0000      1.20.2.1
+++ runtest/ltplite     31 Jul 2009 08:46:55 -0000
@@ -287,7 +287,6 @@
 geteuid01 geteuid01

 getgid01 getgid01
-getgid02 getgid02
 getgid03 getgid03

 getgroups01 getgroups01
Index: runtest/stress.part3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/runtest/stress.part3,v
retrieving revision 1.65
diff -u -r1.65 stress.part3
--- runtest/stress.part3        27 May 2009 13:36:35 -0000      1.65
+++ runtest/stress.part3        31 Jul 2009 08:46:55 -0000
@@ -226,7 +226,6 @@
 geteuid01 geteuid01

 getgid01 getgid01
-getgid02 getgid02
 getgid03 getgid03

 getgroups01 getgroups01
Index: runtest/syscalls
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/runtest/syscalls,v
retrieving revision 1.297
diff -u -r1.297 syscalls
--- runtest/syscalls    6 Jul 2009 14:42:40 -0000       1.297
+++ runtest/syscalls    31 Jul 2009 08:46:55 -0000
@@ -344,8 +344,6 @@

 getgid01 getgid01
 getgid01_16 getgid01_16
-# getgid02 is moved to getegid.
-# getgid02 getgid02
 getgid03 getgid03
 getgid03_16 getgid03_16

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
