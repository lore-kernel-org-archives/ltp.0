Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OZtaE-0005aH-7X
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 22:40:42 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZtaD-0003gQ-Bx
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 22:40:42 +0000
Received: by iwn34 with SMTP id 34so3631038iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Jul 2010 15:40:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1279260728.4313.1.camel@sumit>
References: <1279260728.4313.1.camel@sumit>
Date: Fri, 16 Jul 2010 15:40:35 -0700
Message-ID: <AANLkTimM86iaqeqoKCiu8RWTHy8vq-vFyPnCG3_gj5C5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/2] mc_opts: network/multicast/mc_opts/mc_opts
	script - bug fixing
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
> Test case "mc_opts" fails as it is not able to install "opts" and
> "opts_e" files at desired location. This is because the path of these
> files mentioned in the "mc_opts" script is incorrect. Following patch
> fixes the above problem.
>
> Signed-off-by: =A0Sumit Dhoot <sumitbd@linsyssoft.com>
>
> Index: ltp-full-20100630/testcases/network/multicast/mc_opts/mc_opts
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp-full-20100630.orig/testcases/network/multicast/mc_opts/mc_opts
> +++ ltp-full-20100630/testcases/network/multicast/mc_opts/mc_opts
> @@ -57,7 +57,7 @@ setup()
> =A0 mkdir -p $TCtmp
> =A0 for i in $EXECUTABLES
> =A0 do
> - =A0 =A0install -m 0755 "$LTPROOT/$i" "$TCtmp/."
> + =A0 =A0install -m 0755 "$LTPROOT/testcases/bin/$i" "$TCtmp/."
> =A0 done
> }

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
