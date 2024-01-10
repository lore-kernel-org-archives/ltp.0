Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15B2C4725D
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 15:19:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26E253CE4DB
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 16:19:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D9EE3C4C18
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 15:47:07 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org;
 envelope-from=srs0=/pmw=iu=linux-m68k.org=gerg@kernel.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 29F7B14098AB
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 15:47:05 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7BA53CE1B5F;
 Wed, 10 Jan 2024 14:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0237C433F1;
 Wed, 10 Jan 2024 14:46:37 +0000 (UTC)
Message-ID: <aef3568c-7894-49c9-a7aa-b3c58b822b91@linux-m68k.org>
Date: Thu, 11 Jan 2024 00:46:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Rob Landley <rob@landley.net>, Petr Vorel <pvorel@suse.cz>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik>
 <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
 <461a6556-8f24-48f5-811a-498cb44f2d64@linux-m68k.org>
 <b3a8b9db-86ee-47c6-96e2-baa2cba61404@landley.net>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <b3a8b9db-86ee-47c6-96e2-baa2cba61404@landley.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 10 Jan 2024 16:18:54 +0100
Subject: Re: [LTP] Call for nommu LTP maintainer [was: Re: [PATCH 00/36]
 Remove UCLINUX from LTP]
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
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>, buildroot@buildroot.org,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 10/1/24 15:47, Rob Landley wrote:
> On 1/9/24 17:17, Greg Ungerer wrote:
>> On 10/1/24 06:24, Rob Landley wrote:
>>> I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
>>> of people have been happy to consume my work, but getting any of them to post
>>> directly to linux-kernel is like pulling teeth.
>>
>> I regularly test nommu configurations (as in every kernel rc and release) on m68k
>> and at least every release on other architectures like arm(*) and recently on
>> riscv as well.
> 
> Sigh, I should start caring about riscv. I added or1k support, I should do
> riscv. (Except I did or1k because I found it in actual hardware, the Orange Pi
> 3b's power controller is an or1k asic so I needed an or1k toolchain to build
> some of u-boot's firmware or else the board couldn't reboot, and there was a
> qemu-system-or1k already, which turned into adding it to mkroot via a long
> https://lore.kernel.org/openrisc/ZX1xbs_AGdgLgcx7@antec/ thread with its
> developers. Alas I still can't get qemu to exit (I.E. virtually reboot or power
> off), apparently I need to reinstall my laptop to have a new enough version of
> python 3 to build a newer qemu with. It's on the todo list...)
> 
> I still have a hard time considering riscv anything other than open source's
> version of Itanium. Promises of ubiquity, but even a 28 nanometer mask is still
> 6 figures before you run any wafers and your mask build process is sucking in
> all the black box libraries the fab can sell you, so what does "open" really get
> you here? Cortex-m got cheap when the superh patents expired so Arm didn't have
> to pay royalties to hitachi (renesas?) for the thumb instruction set anymore,
> and they belt those suckers en masse amortizing the up-front costs over ENORMOUS
> volume.
> 
> And yes, j-core was trying to fix the closed source library and toolchain issues
> back when I was still working with them. Among other things fishing
> Google/skywater's openlane toolchain build out of their magic docker and
> reproducing it under a vanilla debootstrap, ala
> https://github.com/j-core/openlane-vhdl-build (As with most corporate
> clusterfscks, once you dig far enough it turns out you can throw over 90% of it
> out...)
> 
> But these days I'm trying to get toybox to 1.0...
> 
>> (*) somewhat annoyingly needing a minor patch to run the versatile qemu platform
>>       I like to test with. But hey, that is on me :-)
> 
> I would very much like to add more nommu targets to mkroot, can I get your
> build/config info offline? (I tried fishing configs out of buildroot a couple
> years ago, but after the THIRD one where the secret was "use very old versions
> of packages, the current stuff is broken"... And the problems were things like
> "the conversion to device tree deleted a huge chunk of this infrastructure", not
> simple fixes.)

Maybe getting a little off-topic here, but I'll just send links here.
Who knows it might be useful to others.

Recently I have been experimenting with minimal builds, this is a bunch of
scripts, configs and a couple of patches I currently have:

     https://github.com/gregungerer/simple-linux

Mostly the kernel builds use the architecture defconfigs, but for armnommu
versatile it was easier to use a dedicated config and patch:

     https://github.com/gregungerer/simple-linux/blob/master/configs/linux-6.6-armnommu-versatile.config
     https://github.com/gregungerer/simple-linux/blob/master/patches/linux-6.6-armnommu-versatile.patch

Anyway the scripting uses the newest package versions of everything
(binutils, gcc, linux, uClibc, busybox).

Regards
Greg



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
