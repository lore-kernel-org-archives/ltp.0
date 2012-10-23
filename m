Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TQbHc-00056P-FM
	for ltp-list@lists.sourceforge.net; Tue, 23 Oct 2012 10:00:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TQbHa-0004Uw-SL
	for ltp-list@lists.sourceforge.net; Tue, 23 Oct 2012 10:00:24 +0000
Message-ID: <5086654E.1010303@cn.fujitsu.com>
Date: Tue, 23 Oct 2012 17:37:18 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <3ED83A9DB3B6D94CA68BF7C03F2981D35D01C266B4@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <3ED83A9DB3B6D94CA68BF7C03F2981D35D01C266B4@EXDCVYMBSTM006.EQ1STM.local>
Subject: Re: [LTP] Regarding shmat01 syscall test
Reply-To: gaowanlong@cn.fujitsu.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Om Prakash PAL <omprakash.pal@stericsson.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 10/23/2012 05:24 PM, Om Prakash PAL wrote:
> Hi,
> =

> I am working on syscall test:  shmat01.c
> =

> I have some confusion:
> =

>  =

> =

> In setup() : it is  allocating shared memory by shmget() and then attachi=
ng by shmat() and after  that detaching the attached address (i.e. shmdt())=
   =

> =

>  =

> =

>         if (shmdt((const void *)base_addr) =3D=3D -1) {
> =

>                 tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
> =

>         }
> =

>  =

> =

> And again in main function it is using same =93base_addr=94 as attaching =
address,
> =

>  =

> =

> addr =3D shmat(*(TC[i].shmid), base_addr+TC[i].offset,
> =

>                                      TC[i].flags);
> =

> how can we ensure(100%) that base_addr (virtual) will be free till this p=
oint for attaching?.

Maybe we can't, but I didn't see any fail on this. Did you see any testing =
failure here?

Thanks,
Wanlong Gao

> =

> there is possibility that this address(base_addr) will be used, so in tha=
t case this shmat() will fail.
> =

> Please correct me if I am wrong.
> =

> Thanks in advance.
> =

>  =

> =

> Best Regards,
> =

> Om Prakash Pal   =

> =

> =

> =

> -------------------------------------------------------------------------=
-----
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_sfd2d_oct
> =

> =

> =

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> =



---------------------------------------------------------------------------=
---
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
