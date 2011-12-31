Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapierfilter@gmail.com>) id 1RgqV3-0006WQ-4n
	for ltp-list@lists.sourceforge.net; Sat, 31 Dec 2011 04:24:53 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RgqV2-0007lw-FH
	for ltp-list@lists.sourceforge.net; Sat, 31 Dec 2011 04:24:53 +0000
Received: by iakh37 with SMTP id h37so27787147iak.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 30 Dec 2011 20:24:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1325226803-29578-1-git-send-email-YanFeng.Shang@windriver.com>
References: <1325226803-29578-1-git-send-email-YanFeng.Shang@windriver.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 30 Dec 2011 23:24:27 -0500
Message-ID: <CAJaTeTr0dDyBmT5docM4bt8zP2qKaepRzUXEpzZk-fMVvKtyNg@mail.gmail.com>
Subject: Re: [LTP] [PATCH] memory in mips with 32bit ELF is lower than
	0x80000000
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
To: Shang Yanfeng <YanFeng.Shang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Haotian.Zhang@windriver.com

On Fri, Dec 30, 2011 at 01:33, Shang Yanfeng wrote:
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
>
> +#if defined(__mips__)
> +#if __WORDSIZE=3D=3D32
> +#define LOW_ADDR =A0 =A0 =A0 (void *)(0x40000000)
> +#define LOW_ADDR2 =A0 =A0 =A0(void *)(0x50000000)
> +#else
> =A0#define LOW_ADDR =A0 =A0 =A0 (void *)(0x80000000)
> =A0#define LOW_ADDR2 =A0 =A0 =A0(void *)(0x90000000)
> +#endif
> +#else
> +#define LOW_ADDR =A0 =A0 =A0 (void *)(0x80000000)
> +#define LOW_ADDR2 =A0 =A0 =A0(void *)(0x90000000)
> +#endif

the last two cases here are the same.  so it should be:
#if defined(__mips__) && __WORDSIZE =3D=3D 32
# define LOW_ADDR =A0 =A0 =A0 (void *)(0x40000000)
# define LOW_ADDR2 =A0 =A0 =A0(void *)(0x50000000)
#else
# define LOW_ADDR =A0 =A0 =A0 (void *)(0x80000000)
# define LOW_ADDR2 =A0 =A0 =A0(void *)(0x90000000)
#endif
-mike

---------------------------------------------------------------------------=
---
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual =

desktops for less than the cost of PCs and save 60% on VDI infrastructure =

costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
