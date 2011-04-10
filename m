Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q8qo9-0007TV-7Y
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 09:19:49 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.74) id 1Q8qo8-0002Qt-DX
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 09:19:49 +0000
Received: by pvc30 with SMTP id 30so2517452pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 10 Apr 2011 02:19:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DA13284.3090007@redhat.com>
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
	<BANLkTi=b=n56Ef8HGDF4drXLWm9RXvOH1g@mail.gmail.com>
	<4DA13284.3090007@redhat.com>
Date: Sun, 10 Apr 2011 02:19:42 -0700
Message-ID: <BANLkTim_9bJi==MyPHoeQtjo+wLL-XJ=8A@mail.gmail.com>
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

On Sat, Apr 9, 2011 at 9:31 PM, Caspar Zhang <czhang@redhat.com> wrote:
> On 04/09/2011 01:38 PM, Garrett Cooper wrote:
>>> > when executing mem/mbind01 testcase under 32bit systems, it returns
>>> > ENOSYS error, indicating that the test is not suitable for running on
>>> > 32bit systems. This patch checks wordsize before executing the actual
>>> > case.
>> =A0 =A0 This error doesn't make sense; it's not documented in the manpag=
e [1].
>> =A0 =A0 Are you sure your system actually supports mbind(2)?
>
> Hmmm... Seems CONFIG_NUMA is not set in RHEL6 on x86 systems, so that
> all mempolicy related syscalls not work on this platform. I shouldn't
> simply check the WORDSIZE but need to check the kernel configuration
> option, yet it's kind of difficult from previous discussion[1]...

    I wouldn't worry too much about it. If it fails with ENOSYS, I
would just fail with tst_brkm(TCONF, ...).
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
