Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Yingang.Fu@windriver.com>) id 1Ojnj1-0007El-Dm
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:26:43 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ojniy-0007ZI-7r
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:26:43 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 13 Aug 2010 08:26:25 +0200
Message-ID: <52CF90264091A14888078A031D780F4306444AC6@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <AANLkTintD8gsCzNEA-7VDa_0YKh+21D__kw6m9ABTvsJ@mail.gmail.com>
References: <52CF90264091A14888078A031D780F4306444AA6@ism-mail03.corp.ad.wrs.com>
	<AANLkTintD8gsCzNEA-7VDa_0YKh+21D__kw6m9ABTvsJ@mail.gmail.com>
From: "Fu, Yingang" <Yingang.Fu@windriver.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

 =


> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com] =

> Sent: Friday, August 13, 2010 2:10 PM
> To: Fu, Yingang
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] rt_sigsuspend01 caused segment fault on x86
> =

> On Thu, Aug 12, 2010 at 11:02 PM, Fu, Yingang =

> <Yingang.Fu@windriver.com> wrote:
> > hi, Garrett
> >
> > Following are test log on x86:
> > ----------------------------------------------------------
> >
> > root@d610-2:/opt/ltp-full/testcases/bin> ./rt_sigsuspend01 =

> > Segmentation fault
> >
> > and messages of rt_sigsuspend01 when dmesg:
> >
> > root@d610-2:/opt/ltp-full/testcases/bin> dmesg | tail
> >
> > VFS: Mounted root (nfs filesystem) on device 0:13.
> > Freeing unused kernel memory: 344k freed
> > intel_rng: FWH not detected
> > ip_tables: (C) 2000-2006 Netfilter Core Team
> > NET: Registered protocol family 10
> > SCTP: Hash tables configured (established 16384 bind 32768)
> > eth0: no IPv6 routers present
> >
> > ***rt_sigsuspend01[865] general protection ip:bfa8b780 sp:bfa8b120 =

> > error:0
> >
> >
> > After apply the patch:
> >
> > root@d610-2:/opt/ltp-full/testcases/bin> ./rt_sigsuspend01
> > rt_sigsuspend01=A0=A0=A0 1=A0 TPASS=A0 :=A0 rt_sigsuspend PASSED
> =

> Committed; please provide a signed-off-by line next time.

Ok.

Thanks
Yingang

> Thanks,
> -Garrett
> =


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
