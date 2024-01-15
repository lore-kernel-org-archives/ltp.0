Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8407C4707B
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 14:15:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BA793CCC5B
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 15:15:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D2563CCB38
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 14:41:25 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=openadk.org (client-ip=2a00:1828:2000:679::23;
 helo=helium.openadk.org; envelope-from=wbx@openadk.org;
 receiver=lists.linux.it)
Received: from helium.openadk.org (helium.openadk.org
 [IPv6:2a00:1828:2000:679::23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5F103600B28
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 14:41:23 +0100 (CET)
Received: by helium.openadk.org (Postfix, from userid 1000)
 id 72F6135210AB; Mon, 15 Jan 2024 14:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
 t=1705326082; bh=oxu8ri+2lNAJGmWaelZR/DAbUPHgJwlAGo7y/CzxD4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DX6Ey8NpU5GrlvEu3ZRCkLwI5kBRnUvpr23wJSVaSMxIvKcwenahJ6FnpxnlCpzvT
 q00OflPoW7AF8uLs4+x/C0//3TcLaD7fuJWk3adpvG8BfJL/B5c8yVJ+2pKol1WuZ+
 hXP81V9hyEpCoS7AKFE+l1KA+iCWIjBaPsusSRwfwCsJWzdAVRc7quDLtRl99U+GB5
 vZ8tq3rEaqKwyMKsPNvqa8yhU6Xz2PkbZZsreGoz/vomjnBebeI4AOolJ32GaW/Mmo
 qO7Ah7Eon0nLF4vBUP3bfqcjzzORYmhkrwk+dBf/iwB3cmChCKQvD9qZ3FYOXh0Nn8
 ZD+QMa3ub/EkA==
Date: Mon, 15 Jan 2024 14:41:22 +0100
From: Waldemar Brodkorb <wbx@openadk.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZaU2Ag1wg1Sne9zZ@waldemar-brodkorb.de>
References: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
 <81c07a13-305a-404b-b14c-3aff8fde3f67@linux-m68k.org>
 <d3a26b8e-8823-8f3c-b815-4396cbac1dc3@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d3a26b8e-8823-8f3c-b815-4396cbac1dc3@landley.net>
X-Operating-System: Linux 5.10.0-27-amd64 x86_64
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 15 Jan 2024 15:15:05 +0100
Subject: Re: [LTP] [Buildroot] [Automated-testing] Call for nommu LTP
 maintainer [was: Re: [PATCH 00/36] Remove UCLINUX from LTP]
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Niklas Cassel <niklas.cassel@wdc.com>, Jonathan Corbet <corbet@lwn.net>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Christophe Lyon <christophe.lyon@linaro.org>, Rob Landley <rob@landley.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "buildroot@buildroot.org" <buildroot@buildroot.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I want to clarify some things of the point of view of uClibc-ng
support.

There is support for following configurations for noMMU targets:
ARM:
 - FLAT with Linuxthreads supported (for Qemu you need a Linux patch)
 - FDPIC with NPTL supported (NPTL works only on real hardware not in Qemu)
 - ELF with Thread support not working

M68k:
 - FLAT with Linuxthreads supported
 - ELF with Thread support not working

RISCV64:
 - FLAT without Thread support
 - ELF with Thread support not working

RISCV32:
 - FLAT without Thread support, needs a small Linux Kernel patch

SH2/J2:
 - FLAT with Linuxthreads supported

Xtensa:
 - FLAT with Linuxthreads supported

There are some obsolete architectures supported by uClibc-ng, but
no longer supported by Linux:

Blackfin:
 - FLAT with Linuxthreads supported
 - FDPIC

H8300:
 - FLAT with Linuxthreads supported

C6X:
 - DSBT 

LM32:
 - FLAT

LTP requires NPTL to work, so the only testable platform is ARM with
FDPIC right now.
Unfortunately LTP 20230929 needs fork for some files:

RANLIB libltp.a
/home/wbx/arm/toolchain_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/usr/lib/gcc/arm-openadk-uclinuxfdpiceabi/13.2.0/../../../../arm-openadk-uclinuxfdpiceabi/bin/ld: ../../lib/libltp.a(tst_res.o): in function `tst_fork':
/home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/lib/tst_res.c:430:(.text+0x952): undefined reference to `fork'
/home/wbx/arm/toolchain_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/usr/lib/gcc/arm-openadk-uclinuxfdpiceabi/13.2.0/../../../../arm-openadk-uclinuxfdpiceabi/bin/ld: ../../lib/libltp.a(tst_test.o): in function `fork_testrun':
/home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/lib/tst_test.c:1597:(.text+0xf4e): undefined reference to `fork'
/home/wbx/arm/toolchain_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/usr/lib/gcc/arm-openadk-uclinuxfdpiceabi/13.2.0/../../../../arm-openadk-uclinuxfdpiceabi/bin/ld: ../../lib/libltp.a(tst_test.o): in function `safe_fork':
/home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/lib/tst_test.c:435:(.text+0x345c): undefined reference to `fork'
collect2: error: ld returned 1 exit status
gmake[8]: *** [../../include/mk/rules.mk:45: test01] Error 1
gmake[7]: *** [../include/mk/generic_trunk_target.inc:108: all] Error 2
gmake[6]: *** [Makefile:94: lib-all] Error 2
gmake[5]: *** [/home/wbx/arm/mk/pkg-bottom.mk:141: /home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/.build_done] Error 2
gmake[4]: *** [Makefile:61: ltp-compile] Error 2
gmake[3]: *** [mk/build.mk:221: package/compile] Error 2
gmake[2]: *** [/home/wbx/arm/mk/build.mk:176: world] Error 2

So there is really work to be done to make the existing code work on noMMU.

best regards
 Waldemar

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
