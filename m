Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OpH9p-00077P-RQ
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 08:53:01 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OpH9n-00083w-D3
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 08:53:01 +0000
Received: by bwz12 with SMTP id 12so3188699bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 28 Aug 2010 01:52:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52CF90264091A14888078A031D780F430111B8DB@ism-mail03.corp.ad.wrs.com>
References: <52CF90264091A14888078A031D780F430111B8DA@ism-mail03.corp.ad.wrs.com>
	<52CF90264091A14888078A031D780F430111B8DB@ism-mail03.corp.ad.wrs.com>
Date: Sat, 28 Aug 2010 01:52:53 -0700
Message-ID: <AANLkTi=VwKN988eNQN=XkL2UHfzs2+GwEheOaOCZO5e6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About the cacheflush01 testcase
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
To: "Gao, Feng" <Feng.Gao@windriver.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

2010/8/27 Gao, Feng <Feng.Gao@windriver.com>:
> Attach the patch.
>
> BR,
> Feng Gao
>
>
> -----Original Message-----
> From: Gao, Feng
> Sent: 2010-8-27 16:32
> To: ltp-list
> Cc: fgao0@windriver.com
> Subject: [LTP]About the cacheflush01 testcase
>
> Hi,
>
> In the cacheflush01 testcase, it will check if the return value is EINVAL
> when the argument cache is not one of ICACHE, BCACHE or DCACHE.
>
> But in the latest kernel, the return values of function cacheflush do NOT
> have EINVAL,=A0 it is no consistent with the linux manual.
> A related patch about the cacheflush function:
> http://lkml.org/lkml/2009/4/9/203
> But Ralf had refused this patch:
> http://www.spinics.net/lists/linux-man/msg00906.html
>
> When run the ltp, cacheflush01 will fail at MIPS boards. So advice to del=
ete
> the cacheflush01 case.

    Silent failures are really stupid, but oh well... there's probably
some value in checking for the EFAULT error code, so I don't think it
should be removed quite yet.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users =

worldwide. Take advantage of special opportunities to increase revenue and =

speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
