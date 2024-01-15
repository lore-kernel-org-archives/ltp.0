Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AA8C3DA79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 14:23:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B0BE3CE363
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 15:23:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D4093CCB0F
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 15:23:28 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD55C60072A
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 15:23:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C848D1FD35;
 Mon, 15 Jan 2024 14:23:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAD36132FA;
 Mon, 15 Jan 2024 14:23:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aTZ6J94/pWUYcgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 14:23:26 +0000
Date: Mon, 15 Jan 2024 15:22:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Waldemar Brodkorb <wbx@openadk.org>
Message-ID: <ZaU_oMTrmXxy0Dub@rei>
References: <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
 <81c07a13-305a-404b-b14c-3aff8fde3f67@linux-m68k.org>
 <d3a26b8e-8823-8f3c-b815-4396cbac1dc3@landley.net>
 <ZaU2Ag1wg1Sne9zZ@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZaU2Ag1wg1Sne9zZ@waldemar-brodkorb.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: C848D1FD35
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
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

Hi!
> RANLIB libltp.a
> /home/wbx/arm/toolchain_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/usr/lib/gcc/arm-openadk-uclinuxfdpiceabi/13.2.0/../../../../arm-openadk-uclinuxfdpiceabi/bin/ld: ../../lib/libltp.a(tst_res.o): in function `tst_fork':
> /home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/lib/tst_res.c:430:(.text+0x952): undefined reference to `fork'
> /home/wbx/arm/toolchain_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/usr/lib/gcc/arm-openadk-uclinuxfdpiceabi/13.2.0/../../../../arm-openadk-uclinuxfdpiceabi/bin/ld: ../../lib/libltp.a(tst_test.o): in function `fork_testrun':
> /home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/lib/tst_test.c:1597:(.text+0xf4e): undefined reference to `fork'
> /home/wbx/arm/toolchain_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/usr/lib/gcc/arm-openadk-uclinuxfdpiceabi/13.2.0/../../../../arm-openadk-uclinuxfdpiceabi/bin/ld: ../../lib/libltp.a(tst_test.o): in function `safe_fork':
> /home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/lib/tst_test.c:435:(.text+0x345c): undefined reference to `fork'
> collect2: error: ld returned 1 exit status
> gmake[8]: *** [../../include/mk/rules.mk:45: test01] Error 1
> gmake[7]: *** [../include/mk/generic_trunk_target.inc:108: all] Error 2
> gmake[6]: *** [Makefile:94: lib-all] Error 2
> gmake[5]: *** [/home/wbx/arm/mk/pkg-bottom.mk:141: /home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/.build_done] Error 2
> gmake[4]: *** [Makefile:61: ltp-compile] Error 2
> gmake[3]: *** [mk/build.mk:221: package/compile] Error 2
> gmake[2]: *** [/home/wbx/arm/mk/build.mk:176: world] Error 2
> 
> So there is really work to be done to make the existing code work on noMMU.

The new test library in LTP runs the actuall test in a child process,
which provides all kinds of benefits, most notably isolation of the
setup/cleanup/result reporting from actuall test code that may crash.
This is of course useless on nommu targets, so I suppose that we would
need a test library tailored for nommu first. However the testcases
themselve fork quite often too. Which means that some kind of parameter
marshaling into a string needs to be done for such tests as well each
test needs to be adjusted to use that in a case of nommu. All in all
getting into a state where majority of tests runs on nommu would be a
major effort.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
