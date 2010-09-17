Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OwRUO-0005Le-Bu
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 03:19:52 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OwRUN-0007LR-7M
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 03:19:52 +0000
Received: by iwn2 with SMTP id 2so2097410iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Sep 2010 20:19:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52CF90264091A14888078A031D780F4306901E9A@ism-mail03.corp.ad.wrs.com>
References: <52CF90264091A14888078A031D780F4306901E9A@ism-mail03.corp.ad.wrs.com>
Date: Thu, 16 Sep 2010 20:19:45 -0700
Message-ID: <AANLkTikCq3QM3eGRfkikJPgAuLzYKkstsLt2cWaCCa1O@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH]Mdify the __NR_cacheflush value in the
	cacheflush01 case
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Gao, Feng" <Feng.Gao@windriver.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

2010/9/16 Gao, Feng <Feng.Gao@windriver.com>:
> Hi,
>
> In the cacheflush01.c, it re-defines the __NR_cacheflush to __NR_Linux +
> 197. But the operation is not alway correct.
> If _MIPS_SIM is _MIPS_SIM_ABI32, Linux will use o32 style syscalls are in
> the range from 4000 to 4999.
> The __NR_cacheflush is __NR_Linux + 147.

    Wouldn't it just be a wiser idea to say that the outcome is indeterminate?
Thanks,
-Garrett

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
