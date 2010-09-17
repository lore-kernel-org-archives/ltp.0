Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OwiOO-0000v1-DY
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 21:22:48 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OwiON-0007uv-HT
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 21:22:48 +0000
MIME-Version: 1.0
In-Reply-To: <4C936C31020000E800068DF2@sinclair.provo.novell.com>
References: <4C936C31020000E800068DF2@sinclair.provo.novell.com>
Date: Fri, 17 Sep 2010 14:22:42 -0700
Message-ID: <AANLkTimUonwvA6PRiTzM01aC6EUf3SMp+ACfG0TJci2S@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Patch] enable hyperthreading tests
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
To: Murlin Wenzel <mwenzel@novell.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Fri, Sep 17, 2010 at 12:25 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
> Currently the hyperthreading tests will only run on 32bit (i386) os versi=
ons. =A0HT is also supported on x86_64, so I changed defines to allow eithe=
r os version.
>
> Signed-off-by: Murlin Ray Wenzel <mwenzel@novell.com>

Seems sane. Could you change `i386 architecture' to `x86 architecture' plea=
se?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
