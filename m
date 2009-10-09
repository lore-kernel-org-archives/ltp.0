Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mw9gF-0005wG-GZ
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 07:14:23 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mw9gA-0003Aa-8P
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 07:14:23 +0000
Received: by pzk26 with SMTP id 26so6085396pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 09 Oct 2009 00:14:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4ACEE1D4.5000202@cn.fujitsu.com>
References: <4ACEE1D4.5000202@cn.fujitsu.com>
Date: Fri, 9 Oct 2009 00:14:12 -0700
Message-ID: <364299f40910090014i61a80458u344bbba34d627360@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] : fix memcg_function_test's bug
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
To: liubo <liubo-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Oct 9, 2009 at 12:10 AM, liubo <liubo-fnst@cn.fujitsu.com> wrote:
> testcase_25() uses a wrong "$?" value ,
> Now use "ret" to record the real "$?"
> value for test .
>
>
> Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>
>
> ---
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function=
_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_tes=
t.sh
> index ea4c8a2..0f11835 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> @@ -398,11 +398,12 @@ testcase_24()
> =A0testcase_25()
> =A0{
> =A0 =A0 =A0 =A0echo -1 > memory.limit_in_bytes 2> /dev/null
> + =A0 =A0 =A0 ret=3D$?
> =A0 =A0 =A0 =A0tst_kvercmp 2 6 31
> =A0 =A0 =A0 =A0if [ $? -eq 0 ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 result $(( !($? !=3D 0) )) =A0"return value=
 is $?"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result $(( !($ret !=3D 0) )) =A0"return val=
ue is $ret"
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 result $(( !($? =3D=3D 0) )) =A0"return val=
ue is $?"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result $(( !($ret =3D=3D 0) )) =A0"return v=
alue is $ret"
> =A0 =A0 =A0 =A0fi
> =A0}

Good catch ;)...

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
