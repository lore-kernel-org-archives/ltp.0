Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q8rBa-00081T-Ud
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 09:44:02 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8rBa-0001Hd-7z
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 09:44:02 +0000
Received: by pwj9 with SMTP id 9so2552419pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 10 Apr 2011 02:43:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DA177FE.1000304@redhat.com>
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
	<BANLkTi=b=n56Ef8HGDF4drXLWm9RXvOH1g@mail.gmail.com>
	<4DA13284.3090007@redhat.com>
	<BANLkTim_9bJi==MyPHoeQtjo+wLL-XJ=8A@mail.gmail.com>
	<4DA177FE.1000304@redhat.com>
Date: Sun, 10 Apr 2011 02:43:55 -0700
Message-ID: <BANLkTinTx==qkz5J6+JZNAfrntST-Un_yw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2 1/2] [mm] mbind01: not working on 32bit systems
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Sun, Apr 10, 2011 at 2:27 AM, Caspar Zhang <czhang@redhat.com> wrote:
> On 04/10/2011 05:19 PM, Garrett Cooper wrote:
>> =A0 =A0 I wouldn't worry too much about it. If it fails with ENOSYS, I
>> would just fail with tst_brkm(TCONF, ...).
>
> Would something like this be good:
>
> err =3D mbind(addr+pagesize, pagesize, MPOL_BIND, nmask->maskp,
> nmask->size, MPOL_MF_MOVE_ALL);
> if (err !=3D 0)
> =A0if (errno =3D=3D ENOSYS)
> =A0 =A0tst_brkm(TCONF,...)
> =A0else
> =A0 =A0tst_brkm(TBROK|TERRNO, NULL, "mbind1");
>
> If yes, I'll work out an updated patch soon.

Yes, that's fine. Ideally it should follow what's being done in
testcases/kernel/includes/linux_syscall_numbers.h to achieve feature
parity.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
