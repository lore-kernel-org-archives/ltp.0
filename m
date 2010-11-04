Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PDr5G-0000lS-Gc
	for ltp-list@lists.sourceforge.net; Thu, 04 Nov 2010 04:05:54 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PDr5F-0004jC-HQ
	for ltp-list@lists.sourceforge.net; Thu, 04 Nov 2010 04:05:54 +0000
Received: by wya21 with SMTP id 21so1455538wya.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Nov 2010 21:05:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=xfASFpmmRWFGMPofEBU+Uzp+TQ4OZ-vw2C_83@mail.gmail.com>
References: <AANLkTi=xfASFpmmRWFGMPofEBU+Uzp+TQ4OZ-vw2C_83@mail.gmail.com>
Date: Wed, 3 Nov 2010 21:05:47 -0700
Message-ID: <AANLkTinkWbgq9A4=qJkqs6xNfxWgPwkRzUm45bdOLWtx@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] keyutils.h not exist when cross compile
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
To: hake huang <hakehuang@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Nov 3, 2010 at 4:31 AM, hake huang <hakehuang@gmail.com> wrote:
> Hi,
>
> when I try to cross compile the ltp
> git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp
> make autotools
> ./configure --host=3Darm-none-linux-gnueabi
> make
>
> the build stops at keyctrl, below is the log, it looks like the ltp
> now depend on the libkeyutils-dev package, should we avoid this
> dependency?
> /usr/local/gcc-4.4.4-glibc-2.11.1-multilib-1.0/arm-fsl-linux-gnueabi/bin/=
arm-none-linux-gnueabi-gcc
> -DFSL_ARM=3D1 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/smb/vte/testcases/kernel/include -I../../../../include
> -I../../../../include =A0 -L../../../../lib =A0keyctl01.c =A0 -lltp -o
> keyctl01
> keyctl01.c:44:22: error: keyutils.h: No such file or directory
> keyctl01.c: In function 'main':
> keyctl01.c:117: error: 'key_serial_t' undeclared (first use in this funct=
ion)
> keyctl01.c:117: error: (Each undeclared identifier is reported only once
> keyctl01.c:117: error: for each function it appears in.)
> keyctl01.c:117: error: expected ';' before 'ne_key'
> keyctl01.c:144: error: 'ne_key' undeclared (first use in this function)
> keyctl01.c:144: error: 'INT32_MAX' undeclared (first use in this function)
> keyctl01.c:144: error: 'INT32_MIN' undeclared (first use in this function)
> make[4]: *** [keyctl01] Error 1
> make[4]: Leaving directory `/home/smb/vte/testcases/kernel/syscalls/keyct=
l'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/home/smb/vte/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/smb/vte/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/smb/vte/testcases'
> make: *** [testcases-all] Error 2

    It's fixed now.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
