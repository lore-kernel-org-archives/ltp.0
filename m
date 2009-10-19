Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mzi2L-0005fu-6I
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 02:31:53 +0000
Received: from mail-px0-f181.google.com ([209.85.216.181])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mzi2C-0002TK-35
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 02:31:53 +0000
Received: by pxi11 with SMTP id 11so461122pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 18 Oct 2009 19:31:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910141841o53235062k4b2ce3ff508ac247@mail.gmail.com>
References: <364299f40910141841o53235062k4b2ce3ff508ac247@mail.gmail.com>
Date: Sun, 18 Oct 2009 19:31:38 -0700
Message-ID: <364299f40910181931y21b2d8chcdd3c77e5e64f785@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [issue 16] ping01 shouldn't use hostname
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

On Wed, Oct 14, 2009 at 6:41 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> <output test=3D"ipv6_noexpect : ping6">
> ping01 =A0 =A0 =A00 =A0TINFO =A0: =A0ping with 8 16 32 64 128 256 512 102=
4 2048
> 4064 ICMP packets
>
> ping01 =A0 =A0 =A00 =A0TINFO =A0: =A0calling ping with packet size =3D 8
>
> ping: unknown host nova_k5
>
> ping01 =A0 =A0 =A00 =A0TINFO =A0: =A0Cleaning up.
>
> ping01 =A0 =A0 =A01 =A0TFAIL =A0: =A0Test broken: failed: ping -c 5 -s 8 =
nova_k5
>
> ping01 =A0 =A0 =A00 =A0TINFO =A0: =A0Cleaning up.
> </output>

This change (which I'm committing to cvs right now) changes the
default to the loopback address:

gcooper@orangebox
/scratch/ltp-dev2/ltp/testcases/network/tcp_cmds/ping $ ./ping01
ping01      0  TINFO  :  ping with 8 16 32 64 128 256 512 1024 2048
4064 ICMP packets
ping01      0  TINFO  :  calling ping with packet size =3D 8
ping01      0  TINFO  :  calling ping with packet size =3D 16
ping01      0  TINFO  :  calling ping with packet size =3D 32
ping01      0  TINFO  :  calling ping with packet size =3D 64
ping01      0  TINFO  :  calling ping with packet size =3D 128
ping01      0  TINFO  :  calling ping with packet size =3D 256
ping01      0  TINFO  :  calling ping with packet size =3D 512
ping01      0  TINFO  :  calling ping with packet size =3D 1024
ping01      0  TINFO  :  calling ping with packet size =3D 2048
ping01      0  TINFO  :  calling ping with packet size =3D 4064
ping01      0  TINFO  :  Cleaning up.
ping01      1  TPASS  :  Test successful
gcooper@orangebox /scratch/ltp-dev2/ltp/testcases/network/tcp_cmds/ping $

The default can still be changed by specifying the RHOST environment variab=
le.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: ping01
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/network/tcp_cmds/ping/ping01,v
retrieving revision 1.6
diff -u -r1.6 ping01
--- ping01      9 Oct 2009 17:56:07 -0000       1.6
+++ ping01      19 Oct 2009 02:30:42 -0000
@@ -48,9 +48,9 @@

     tst_setup

-    exists hostname ping
+    exists ping

-    RHOST=3D${RHOST:-`hostname`}
+    RHOST=3D${RHOST:-127.0.0.1}
 }

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
