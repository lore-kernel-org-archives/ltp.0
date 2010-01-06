Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSLlq-0005dI-CE
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 02:37:14 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSLlk-0001Fm-UE
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 02:37:14 +0000
Received: by pwj11 with SMTP id 11so11663427pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 18:37:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OFBE2FC11C.E215D8EA-ON852576A2.007E66E5-852576A2.008144FB@us.ibm.com>
References: <mailman.274940.1262712842.5825.ltp-list@lists.sourceforge.net>
	<OFBE2FC11C.E215D8EA-ON852576A2.007E66E5-852576A2.008144FB@us.ibm.com>
Date: Tue, 5 Jan 2010 18:37:03 -0800
Message-ID: <364299f41001051837l4e62569em36054556b63d7bca@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] install instructions
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
To: Mark Ver <markver@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 5, 2010 at 3:31 PM, Mark Ver <markver@us.ibm.com> wrote:
> Hi,
>
> Can we patch the install instructions with something like:
> --
>
> --- INSTALL.orig =A0 =A0 =A0 =A02010-01-05 17:40:32.000000000 -0500
> +++ INSTALL =A0 =A0 2010-01-05 17:40:43.000000000 -0500
> @@ -127,12 +127,19 @@
> =A03> ./configure
> =A04> make all
> =A05> make install
> -6> ./runalltests.sh
> +6> cd /opt/ltp
> +7> ./runalltests.sh
>
> -*NOTE: The LTP assumes the existence of the nobody, bin, and daemon users
> and
> +*NOTE:
> +- The LTP assumes the existence of the nobody, bin, and daemon users and
> =A0their groups. =A0If these IDs do not exist, certain tests will fail. T=
he
> users
> =A0and groups IDs should be the same, i.e. if user "nobody" is 99, then i=
t's
> =A0group should also be "99". The names of the groups are irrelevant.
> +- The execution directory where binaries are "installed" is now separate
> from
> +the build and source directories. =A0The default execution directory
> is /opt/ltp
> +and may be modified by setting a value for prefix, ex:
> + =A0 =A0make prefix=3D/tmp/ltptest all
> + =A0 =A0make prefix=3D/tmp/ltptest install

Hi Mark,

I agree with the suggestion -- I just don't agree with the method of
going about solving the problem. Here's what I have:

Index: INSTALL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/INSTALL,v
retrieving revision 1.34
diff -u -r1.34 INSTALL
--- INSTALL     12 Nov 2009 12:08:09 -0000      1.34
+++ INSTALL     6 Jan 2010 02:35:43 -0000
@@ -127,13 +127,15 @@
 3> ./configure
 4> make all
 5> make install
-6> ./runalltests.sh
-
-*NOTE: The LTP assumes the existence of the nobody, bin, and daemon users =
and
-their groups.  If these IDs do not exist, certain tests will fail. The use=
rs
-and groups IDs should be the same, i.e. if user "nobody" is 99, then it's
-group should also be "99". The names of the groups are irrelevant.
+6> cd /opt/ltp
+7> ./runalltests.sh

+*NOTE:
+- LTP assumes the existence of the nobody, bin, and daemon users and their
+groups.  If these IDs do not exist, certain tests will fail. The users and
+groups IDs should be the same, i.e. if user "nobody" is 99, then it's group
+should also be "99". The names of the groups are irrelevant.
+- The installation directory is /opt/ltp by default. Please see "Using aut=
oconf
" above and specify the appropriate path via --prefix. DESTDIR=3D is also h=
onored
for install and will install into $DESTDIR/$prefix, if you want to install =
into
a chroot or a rootfs for instance.

 Detailed Installation
 --------------------

Look good?
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
