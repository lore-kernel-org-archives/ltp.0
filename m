Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OjnTB-0002OZ-EX
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:10:21 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OjnTA-0002Cn-HH
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:10:21 +0000
Received: by fxm6 with SMTP id 6so1725054fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Aug 2010 23:10:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52CF90264091A14888078A031D780F4306444AA6@ism-mail03.corp.ad.wrs.com>
References: <52CF90264091A14888078A031D780F4306444AA6@ism-mail03.corp.ad.wrs.com>
Date: Thu, 12 Aug 2010 23:10:14 -0700
Message-ID: <AANLkTintD8gsCzNEA-7VDa_0YKh+21D__kw6m9ABTvsJ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] rt_sigsuspend01 caused segment fault on x86
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
To: "Fu, Yingang" <Yingang.Fu@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Aug 12, 2010 at 11:02 PM, Fu, Yingang <Yingang.Fu@windriver.com> wr=
ote:
> hi, Garrett
>
> Following are test log on x86:
> ----------------------------------------------------------
>
> root@d610-2:/opt/ltp-full/testcases/bin> ./rt_sigsuspend01 Segmentation
> fault
>
> and messages of rt_sigsuspend01 when dmesg:
>
> root@d610-2:/opt/ltp-full/testcases/bin> dmesg | tail
>
> VFS: Mounted root (nfs filesystem) on device 0:13.
> Freeing unused kernel memory: 344k freed
> intel_rng: FWH not detected
> ip_tables: (C) 2000-2006 Netfilter Core Team
> NET: Registered protocol family 10
> SCTP: Hash tables configured (established 16384 bind 32768)
> eth0: no IPv6 routers present
>
> ***rt_sigsuspend01[865] general protection ip:bfa8b780 sp:bfa8b120 error:0
>
>
> After apply the patch:
>
> root@d610-2:/opt/ltp-full/testcases/bin> ./rt_sigsuspend01
> rt_sigsuspend01=A0=A0=A0 1=A0 TPASS=A0 :=A0 rt_sigsuspend PASSED

Committed; please provide a signed-off-by line next time.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
