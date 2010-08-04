Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1Ogl10-0005Y9-Aj
	for ltp-list@lists.sourceforge.net; Wed, 04 Aug 2010 20:56:42 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ogl0w-0005GA-4p
	for ltp-list@lists.sourceforge.net; Wed, 04 Aug 2010 20:56:42 +0000
Received: by qwg8 with SMTP id 8so4469012qwg.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Aug 2010 13:56:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6A4A1EB0E8FDFB46AC5D6C392E82277006AAB652@me-ex1.ctsl.cubic.cub>
References: <6A4A1EB0E8FDFB46AC5D6C392E82277006AAB652@me-ex1.ctsl.cubic.cub>
From: Henry Yei <hyei@mvista.com>
Date: Wed, 4 Aug 2010 13:26:01 -0700
Message-ID: <AANLkTikn1tx4Lz7SWAzyp0diKTiPyztgxSoMgvyj2Hq7@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Boari, Doug" <Doug.Boari@cubic.com>
Cc: ltp-list@lists.sourceforge.net

Doug,

I was just able to cross compile ltp-20100630 the other day on our arm
toolchain and did not see that error. This was using a MontaVista
toolchain on Red Hat 5.5 (64).

Our steps to cross compile are:

./configure --oldincludedir=3D${IncludePath} --host=3Darm-montavista-linux-=
gnueabi

# where ${IncludePath} points to the headers installed on the target
root filesystem.

export SKIP_IDCHECK=3D1
make -k
make install



Henry Yei <hyei@mvista.com>





On Wed, Aug 4, 2010 at 3:04 AM, Boari, Doug <Doug.Boari@cubic.com> wrote:
> Hi Garrett,
>
> Sorry I forgot to attach the zip (now enclosed)
>
> Here is the make --version:
>
> GNU Make 3.81
> Copyright (C) 2006 =A0Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.
> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
> PARTICULAR PURPOSE.
> This program built for i486-pc-linux-gnu
>
> Hmmmmm After poking around a bit, I'm thinking that maybe LTP may not be
> suitable for our board after all...
> I was reading through some of the test_realtime scripts and it looks
> like the tests need to build libs before running. Unfortunately we have
> no on-board compiler, everything is cross compiled on a separate PC. Is
> there anyway round this? I'm especially interested in the scheduling
> sub-set of tests.
>
> Thanks a lot for any advice.
>
> Kind regards
> Doug
>
>
> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: 03 August 2010 17:30
> To: Boari, Doug
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Install failure when cross compiling for ARM
>
> On Tue, Aug 3, 2010 at 8:56 AM, Boari, Doug <Doug.Boari@cubic.com>
> wrote:
>> Hi All,
>>
>>
>>
>> I've just found LTP and it looks to be exactly what we need to stress
>> test a PXA320 board we're working on. Great!
>>
>> I'm cross-compiling to ARM on Ubuntu 8.04LTS
>>
>>
>>
>> I have successfully built the tools using the lines:
>>
>> ./configure CFLAGS=3D-fno-short-enums --target=3Darm-iwmmxt-linux-gnueabi
>> --host=3Darm-iwmmxt-linux-gnueabi
>>
>> make all
>>
>>
>>
>> I then tried to install using:
>>
>>
>>
>> make DESTDIR=3D/home/mm6/LTP/arm-install SKIP_IDCHECK=3D1 install
>>
>>
>>
>> and it chugs along until finally bombing with:
>>
>>
>>
>> make[3]: Entering directory
>> `/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4'
>>
>> make[4]: Entering directory
>> `/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4/acl'
>>
>> ../../../../include/mk/env_post.mk:90: warning: overriding commands
>> for target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin'
>>
>> ../../../../include/mk/env_post.mk:90: warning: ignoring old commands
>> for target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin'
>>
>> ../../../../include/mk/env_post.mk:92: warning: overriding commands
>> for target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma'
>>
>> ../../../../include/mk/env_post.mk:92: warning: ignoring old commands
>> for target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma'
>>
>> install -m 00775 "/testgamma"
>> "/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma"
>>
>> install: cannot stat `/testgamma': No such file or directory
>>
>> make[4]: ***
>> [/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma]
>> Error 1
>>
>> make[4]: Leaving directory
>> `/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4/acl'
>>
>> make[3]: *** [install] Error 2
>>
>> make[3]: Leaving directory
>> `/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4'
>>
>> make[2]: *** [install] Error 2
>>
>> make[2]: Leaving directory
>> `/home/mm6/LTP/ltp-full-20100630/testcases/network'
>>
>> make[1]: *** [install] Error 2
>>
>> make[1]: Leaving directory `/home/mm6/LTP/ltp-full-20100630/testcases'
>>
>> make: *** [testcases-install] Error 2
>>
>>
>>
>> Now I can see from the error that somewhere something has gotten
>> confused and it is looking for /testgamma, but I can't find any other
>> reference to this anywhere in the LTP build tree.
>>
>> I'm afraid I don't really know where to look to remove this reference.
>
>> If anyone has any suggestions I'd appreciate it as a search of the
>> mail list found nothing.
>>
>> I've include the config.h, config.mk and config.log files as per the
>> INSTALL file.
>>
>>
>>
>> If anyone has experience in building for an ARM board, I'd appreciate
>> any pointers on what I might be doing wrong, and also what tests might
>
>> not function correctly.
>
> Hi Doug,
> =A0 =A0First off, could you please provide the output of `make --version'
> and your config.log ?
> Thanks,
> -Garrett
> **********************************************************************
>
> This document is intended for, and should only be read by,
> those persons to whom it is addressed. Its contents are
> confidential and if you have received this message in error,
> please delete it. Any form of reproduction, dissemination,
> copying, disclosure, modification, distribution and / or
> publication of this message without our prior written
> consent is strictly prohibited.
>
> Any views expressed in this message are those of the
> individual sender, and do not necessarily represent the
> position of CTSL. Furthermore CTSL does not authorise
> or use e-mail for official contractual correspondence.
> Nothing received in e-mail has any contractual validity.
>
> CTSL and each legal entity in Cubic Corporation reserve
> the right to monitor all e-mail communications through
> its networks.
>
> Registered Office:
> Cubic Transportation Systems Ltd
> AFC House
> Honeycrock Lane
> Salfords
> Surrey
> RH1 5LA
> United Kingdom
>
> Registered in England under number 01381707
> **********************************************************************
>
>
> -------------------------------------------------------------------------=
-----
> The Palm PDK Hot Apps Program offers developers who use the
> Plug-In Development Kit to bring their C/C++ apps to Palm for a share
> of $1 Million in cash or HP Products. Visit us here for more details:
> http://p.sf.net/sfu/dev2dev-palm
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

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
