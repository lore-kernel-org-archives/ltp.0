Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OgKNF-0002Tt-C4
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 16:29:53 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OgKND-0002IF-70
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 16:29:53 +0000
Received: by iwn34 with SMTP id 34so6678330iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Aug 2010 09:29:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6A4A1EB0E8FDFB46AC5D6C392E82277006AAB64D@me-ex1.ctsl.cubic.cub>
References: <6A4A1EB0E8FDFB46AC5D6C392E82277006AAB64D@me-ex1.ctsl.cubic.cub>
Date: Tue, 3 Aug 2010 09:29:43 -0700
Message-ID: <AANLkTinLtbSnwJiCM0=6cPePYrD29xpzm_JyYX37Egwn@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Install failure when cross compiling for ARM
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
To: "Boari, Doug" <Doug.Boari@cubic.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Aug 3, 2010 at 8:56 AM, Boari, Doug <Doug.Boari@cubic.com> wrote:
> Hi All,
>
>
>
> I=92ve just found LTP and it looks to be exactly what we need to stress t=
est a
> PXA320 board we=92re working on. Great!
>
> I=92m cross-compiling to ARM on Ubuntu 8.04LTS
>
>
>
> I have successfully built the tools using the lines:
>
> ./configure CFLAGS=3D-fno-short-enums --target=3Darm-iwmmxt-linux-gnueabi
> --host=3Darm-iwmmxt-linux-gnueabi
>
> make all
>
>
>
> I then tried to install using:
>
>
>
> make DESTDIR=3D/home/mm6/LTP/arm-install SKIP_IDCHECK=3D1 install
>
>
>
> and it chugs along until finally bombing with:
>
>
>
> make[3]: Entering directory
> `/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4'
>
> make[4]: Entering directory
> `/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4/acl'
>
> ../../../../include/mk/env_post.mk:90: warning: overriding commands for
> target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin'
>
> ../../../../include/mk/env_post.mk:90: warning: ignoring old commands for
> target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin'
>
> ../../../../include/mk/env_post.mk:92: warning: overriding commands for
> target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma'
>
> ../../../../include/mk/env_post.mk:92: warning: ignoring old commands for
> target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma'
>
> install -m 00775 "/testgamma"
> "/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma"
>
> install: cannot stat `/testgamma': No such file or directory
>
> make[4]: *** [/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma]
> Error 1
>
> make[4]: Leaving directory
> `/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4/acl'
>
> make[3]: *** [install] Error 2
>
> make[3]: Leaving directory
> `/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4'
>
> make[2]: *** [install] Error 2
>
> make[2]: Leaving directory
> `/home/mm6/LTP/ltp-full-20100630/testcases/network'
>
> make[1]: *** [install] Error 2
>
> make[1]: Leaving directory `/home/mm6/LTP/ltp-full-20100630/testcases'
>
> make: *** [testcases-install] Error 2
>
>
>
> Now I can see from the error that somewhere something has gotten confused
> and it is looking for /testgamma, but I can=92t find any other reference =
to
> this anywhere in the LTP build tree.
>
> I=92m afraid I don=92t really know where to look to remove this reference=
. If
> anyone has any suggestions I=92d appreciate it as a search of the mail li=
st
> found nothing.
>
> I=92ve include the config.h, config.mk and config.log files as per the IN=
STALL
> file.
>
>
>
> If anyone has experience in building for an ARM board, I=92d appreciate a=
ny
> pointers on what I might be doing wrong, and also what tests might not
> function correctly.

Hi Doug,
    First off, could you please provide the output of `make --version'
and your config.log ?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
