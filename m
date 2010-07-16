Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OZtaU-0005bz-Jr
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 22:40:58 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZtaS-0003gQ-F1
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 22:40:58 +0000
Received: by mail-iw0-f175.google.com with SMTP id 34so3631038iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Jul 2010 15:40:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1279260750.4313.2.camel@sumit>
References: <1279260750.4313.2.camel@sumit>
Date: Fri, 16 Jul 2010 15:40:56 -0700
Message-ID: <AANLkTim24-2qBm2ecg1kO3TE6v32wM3375dH9oEGutc8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/2] runtest/multicast: wrong TCsrc path exported
	for multicast tests
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
To: sumitbd@linsyssoft.com
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 15, 2010 at 11:12 PM,  <sumitbd@linsyssoft.com> wrote:
> While running networktest for multicast ; =A0"mc_member" test displays the
> following error message multiple times
> "cat: /opt/ltp/testcases/inetwork/multicast/mc_menmber/ManyGroups: No
> such file or directory".
> This is Because variable "TCsrc" is exported with incorrect path. Looks
> like previously LTP test scripts installed and ran directly from source
> directory . Now it installs mulicast test binary and script files to
> "$LTPROOT/testcases/bin" directory. Hence the variable "TCsrc" needed to
> be exported with above mentioned install path.
>
> Signed-off-by: =A0Sumit Dhoot <sumitbd@linsyssoft.com>
>
> Index: ltp-full-20100630/runtest/multicast
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp-full-20100630.orig/runtest/multicast
> +++ ltp-full-20100630/runtest/multicast
> @@ -3,6 +3,6 @@
> # PLEASE READ THE README FILE IN /multicast BEFORE RUNNING THESE.
> #
> mc_cmds mc_cmds
> -mc_commo export TCsrc=3D$LTPROOT/testcases/network/multicast/mc_commo;
> mc_commo
> -mc_member export TCsrc=3D$LTPROOT/testcases/network/multicast/mc_member;
> mc_member
> -mc_opts export TCsrc=3D$LTPROOT/testcases/network/multicast/mc_opts;
> mc_opts
> +mc_commo export TCsrc=3D$LTPROOT/testcases/bin; mc_commo
> +mc_member export TCsrc=3D$LTPROOT/testcases/bin; mc_member
> +mc_opts export TCsrc=3D$LTPROOT/testcases/bin; mc_opts

ACK

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
