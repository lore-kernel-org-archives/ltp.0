Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMZWo-0004ms-Ho
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:33:34 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMZWi-0000o1-FV
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:33:34 +0000
Received: by yxe33 with SMTP id 33so1986567yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 20:33:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090702090228.GE19135@count0.beaverton.ibm.com>
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
	<20090702090228.GE19135@count0.beaverton.ibm.com>
Date: Thu, 2 Jul 2009 20:33:27 -0700
Message-ID: <364299f40907022033n5334ed2bv41dad2628603d8f2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/4] netns: Fixup non-sh syntax
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, LTP <ltp-list@lists.sourceforge.net>, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

On Thu, Jul 2, 2009 at 2:02 AM, Matt Helsley<matthltc@us.ibm.com> wrote:
> Fixup some non-sh syntax which seems to trigger problems on my fedora 10
> KVM image.
>
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> Cc: Daniel Lezcano <daniel.lezcano@free.fr>
> Cc: Poornima Nayak <poornima.nayak@in.ibm.com>
> Cc: Sudhir Kumar <skumar@linux.vnet.ibm.com>
> Cc: Veerendra C <vechandr@in.ibm.com>
> Cc: Munipradeep <mbeeraka@in.ibm.com>
> Cc: ltp@list.sourceforge.net
> ---
> =A0testcases/kernel/containers/netns/parentns.sh | =A0 =A02 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: ltp/testcases/kernel/containers/netns/parentns.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp.orig/testcases/kernel/containers/netns/parentns.sh
> +++ ltp/testcases/kernel/containers/netns/parentns.sh
> @@ -56,7 +56,7 @@ status=3D0
> =A0 =A0 create_veth
> =A0 =A0 vnet0=3D$dev0
> =A0 =A0 vnet1=3D$dev1
> - =A0 =A0if [[ -z $vnet0 || -z $vnet1 ]] ; then
> + =A0 =A0if [ -z $vnet0 -o -z $vnet1 ] ; then
> =A0 =A0 =A0 =A0 tst_resm TFAIL =A0"Error: unable to create veth pair"
> =A0 =A0 =A0 =A0 exit -1
> =A0 =A0 else

While you're there, could you please quote "$vnet0"?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
