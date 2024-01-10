Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1F2C47074
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 05:41:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BC873CE49E
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 06:41:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53AAE3CE484
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 06:40:54 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F393D1A027C3
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 06:40:52 +0100 (CET)
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-427a3887483so26987111cf.3
 for <ltp@lists.linux.it>; Tue, 09 Jan 2024 21:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704865251; x=1705470051;
 darn=lists.linux.it; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wl6KplL8vfqqzv9XIvHtOm+qlgn0/YVCH+xMxC333j8=;
 b=FZaiMPoAoULVsnlA967XKJaGSjZuQeb1qM+d27/mYXKcwoLtEnNIDJ2+6dNDjdNGSA
 WPmvOqj6Z/2WlXtc+eNJx3A4xNjAjqJZuol8XPpnqT6Av/gzXwzM5wH80cllykmMbfG1
 ZcX3rmJ5kep8SklXO69txZZQwzQ7hNd5H97XRll0XwN1bRXX4L4tcVFDZuO4RgfxIzgP
 g9Du8hnjFJ6FXCP1W+0bxTfhDkwzKNFazaxAlWc/pDalpr+oTwat2WhQfAPNzVsAoOn4
 WCokWLBuglvdxinip5ebrRH5NfEPogB9qk9ZRP+sIOSIwcKO0dyVwzEpu76cVVZ20hPN
 Ac1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704865251; x=1705470051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wl6KplL8vfqqzv9XIvHtOm+qlgn0/YVCH+xMxC333j8=;
 b=R1wf3vkC9A5hWnkqwPZbniqyubPaBrvHQ3X+gtlusLvu1R2ZvJexX3Kd967faijKQd
 PTcFLX2SkPEbcsNfCUumsuM0LuIu/xEU7tTFZdHXZqNT6KhMG1vsf9ufBtSo54wYrNM1
 wFGNQ0SJMnA43wPp2avbBHYNBsTH5CiQuO8Si9hxFCk0JkilPt9dB64whaJTmZdwzFO8
 N6O4v8CukEQdv59woHYivylQR0vrzhLKgrK1UlittNCM7lWFrJ5fXTiwPdQmY/fTdCbj
 if9Q4NN0/lvTMoxCsNfB7L78HOaINWi22upn0KGdcYeqVCcl2VbKLPuhvY7Rww3+K6pJ
 6sSg==
X-Gm-Message-State: AOJu0YxsLDN6lLuG2bnzmBU8K2CaDiY6ae9QoT7vs7fE6KjW2TrsKRus
 zO4V9KnukjpTD0nD6Id64WUuiQ+x6tddOw==
X-Google-Smtp-Source: AGHT+IE8kWehfow24cvasfCahOteXRnQwmSQ0KUU70I6cj4jEzLcuNUg6AgxZgtVGm7CpYkCj/gbDA==
X-Received: by 2002:a05:622a:588:b0:429:b76a:c3fa with SMTP id
 c8-20020a05622a058800b00429b76ac3famr202269qtb.26.1704865251286; 
 Tue, 09 Jan 2024 21:40:51 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
 by smtp.gmail.com with ESMTPSA id
 cr14-20020a05622a428e00b0042997333149sm1497591qtb.63.2024.01.09.21.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 21:40:51 -0800 (PST)
Message-ID: <b3a8b9db-86ee-47c6-96e2-baa2cba61404@landley.net>
Date: Tue, 9 Jan 2024 23:47:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Greg Ungerer <gerg@linux-m68k.org>, Petr Vorel <pvorel@suse.cz>
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
From: Rob Landley <rob@landley.net>
In-Reply-To: <461a6556-8f24-48f5-811a-498cb44f2d64@linux-m68k.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 1/9/24 17:17, Greg Ungerer wrote:
> 
> On 10/1/24 06:24, Rob Landley wrote:
>> On 1/8/24 03:03, Petr Vorel wrote:
>>> Hi Rob, all,
>>>
>>> [ Added Niklas Cassel, who is maintainer of qemu_riscv64_nommu_virt_defconfig in
>>> buildroot ]
>> 
>> Hi Niklas!
>> 
>>>> Buildroot also apparently has an LTP package selectable in menuconfig:
>>>
>>>> https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite
>>>
>>>> But I haven't tried it...
>>>
>>> I'm the maintainer of the LTP package in buildroot in my private time.
>>> BTW I spent quite a lot of time fixing LTP (and some other system packages,
>>> e.g. nfs-utils) compilation on some old legacy architectures reported via
>>> http://autobuild.buildroot.net/ I've never used in the reality.
>>> But I certainly don't have time to drive nommu support in my private time.
>>> I don't even have an interest, I don't use any nommu device.
>> 
>> I do, but I've never done much with LTP, and I have my hands full with toybox
>> and mkroot already.
>> 
>>> Therefore nobody who is not involved in nommu will not find a time to support it
>>> in LTP (support does not mean just to add the functionality to the new C API,
>>> but run tests on nommu and fix failing bugs). I suppose nobody is paid to work
>>> on nommu platforms, it would have to be a hobby project, right?
>> 
>> A bunch of people are paid to work on nommu platforms, and I've worked with them
>> a bunch, but none of them talk to linux-kernel. They find the culture toxic,
>> insular, and categorically dismissive of their interests.
> 
> I have been involved in the kernel nommu space for 20 years, and sure, there is
> some of that. But mostly spending some time and effort to get involved pays off.
> I have seen potential contributors show up with some arrogant attitudes too,
> so it cuts both ways here.
> 
> The m68k community I have been part of has been nothing but welcoming. The mm
> people have tried hard to keep nommu support up-to-date where almost none of them
> actually have a vested interest in doing so.
> 
> What I have seen is that many companies working in this space just don't want
> to spend the time and effort to go mainline.

Sometimes they don't bother. Sometimes there's a language barrier. Sometimes
they can't get anything newer than 2.6 working because that's the BSP they were
given so what's the point of trying to engage upstream? Sometimes they think
it's their upstream vendor's responsibility. Sometimes they poke their head up
and get it bit off ala http://landley.net/notes-2008.html#11-12-2008 and then
that serves as a warning to others for generations. Sometimes the company's
legal department thinks it's a terrible idea to attract attention from people
like the SFLC. And sometimes...


The SmartFusion 2 project I was doing on cortex-m was for a project that was to
be launched into space on a NASA rocket, and thus fell under ITAR export
regulations (as the entire US space program has since 1996 due to
https://en.wikipedia.org/wiki/International_Traffic_in_Arms_Regulations#:~:text=Intelsat
) and my manager explained it to me as:

"If I buy a screwdriver from Home Depot, it's just a screwdriver. If I use it to
turn a screw on a spacecraft it is now a munition and cannot be discussed with
non-US persons".

The stupid linked above was:

1) cryptography was categorized as a munition until Bill Clinton relaxed it via
executive order, because 56 bit https was preventing anybody from trusting the
web with their credit card data.

2) Before that, in 1996, china wanted to launch a satellite into space with
crypto stuff so they negotiated with the USA to get some cryptographic hardware
which was delivered/installed under armed guard and escorted to the launch pad.

3) The rocket blew up on launch, scattering debris over a chinese city (becuase
of COURSE china's rocket launches go over large population centers). The crypto
hardware was never recovered.

4) It became a scandal. Congress freaked. And somehow in the scuffle ITAR export
regulations were extended from cryptography to the entire US space program.

5) The US space program dried up and blew away, as engineers had to choose
between "I can work on space stuff" and "I can have any sort of professional
network online". (Because who online is a "non-US person"? That includes canada.
You can't discuss ITAR subjects with canadians. Or foreign nationals living in
the USA. You couldn't ask Alan Cox a question about an ITAR project.)

So that's a whole category that stays very quiet about what they do, and whose
legal analysis of the GPL is "we're making 3 of these and shooting them into
space, if you retrieve one from space and demand source code from us we will
forward you to the relevant federal agencies, and there's a nonzero chance
you'll be on a black site in Diego Garcia within 24 hours where they will figure
out how you did that. Or maybe you'll get the code. Who knows?"

Me, I try to avoid that kind of contract...

> That is a business decision they
> make, and that is fine. Heck my work in actual mainline has never really been
> paid for by any company and I have sunk a _lot_ of time into it. (Full disclosure
> I did get paid to work on early porting and support - just not geting it into
> mainline and maintain it there).

The thing is if you post something _once_ it gets ignored, and if you follow-up
long enough for it to go in (which often takes years), it will then get ripped
out again a few years later because "we never hear from anybody who uses this".

Engaging with the community is signing up for an ongoing commitment.

>> For example, cortex-m is a large nommu platform on which vendors support Linux
>> BSPs, but notice how page 8 of
>> https://www.microsemi.com/document-portal/doc_view/132181-linux-cortex-m-users-manual
>> points at a cross compiler toolchain from _2010_ and page 4 says they're booting
>> a 2.6.33 kernel?
> 
> Any company/person who follows the route of not working with the linux kernel
> community to get their work included is going to inevitably get stuck on older
> versions of everything.

I fight hard to get current versions of everything to work on all my supported
targets. This requires regular regression testing, and I maintain a pile of
patches that I post here periodically but I fully admit will probably never go in:

  https://lkml.iu.edu/hypermail/linux/kernel/2302.2/05594.html

(Sigh, now that 6.7 is out I should post the new round...)

People who want to use my kernels as a source are welcome to do so (and I've
seen my patches quietly show up in other projects), but getting upstream to
actually _fix_ anything? Every one of those patches had a link to the previous
time it was posted to the list and ignored.

I mean literally, the first of those patches teaches the makefile to autodetect
whether $PREFIX-cc is gcc or llvm and just do the right thing, and I was told
that they actively didn't want it to:

https://lkml.iu.edu/hypermail/linux/kernel/2302.2/07184.html

That is modern linux-kernel development.

>> I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
>> of people have been happy to consume my work, but getting any of them to post
>> directly to linux-kernel is like pulling teeth.
> 
> I regularly test nommu configurations (as in every kernel rc and release) on m68k
> and at least every release on other architectures like arm(*) and recently on
> riscv as well.

Sigh, I should start caring about riscv. I added or1k support, I should do
riscv. (Except I did or1k because I found it in actual hardware, the Orange Pi
3b's power controller is an or1k asic so I needed an or1k toolchain to build
some of u-boot's firmware or else the board couldn't reboot, and there was a
qemu-system-or1k already, which turned into adding it to mkroot via a long
https://lore.kernel.org/openrisc/ZX1xbs_AGdgLgcx7@antec/ thread with its
developers. Alas I still can't get qemu to exit (I.E. virtually reboot or power
off), apparently I need to reinstall my laptop to have a new enough version of
python 3 to build a newer qemu with. It's on the todo list...)

I still have a hard time considering riscv anything other than open source's
version of Itanium. Promises of ubiquity, but even a 28 nanometer mask is still
6 figures before you run any wafers and your mask build process is sucking in
all the black box libraries the fab can sell you, so what does "open" really get
you here? Cortex-m got cheap when the superh patents expired so Arm didn't have
to pay royalties to hitachi (renesas?) for the thumb instruction set anymore,
and they belt those suckers en masse amortizing the up-front costs over ENORMOUS
volume.

And yes, j-core was trying to fix the closed source library and toolchain issues
back when I was still working with them. Among other things fishing
Google/skywater's openlane toolchain build out of their magic docker and
reproducing it under a vanilla debootstrap, ala
https://github.com/j-core/openlane-vhdl-build (As with most corporate
clusterfscks, once you dig far enough it turns out you can throw over 90% of it
out...)

But these days I'm trying to get toybox to 1.0...

> (*) somewhat annoyingly needing a minor patch to run the versatile qemu platform
>      I like to test with. But hey, that is on me :-)

I would very much like to add more nommu targets to mkroot, can I get your
build/config info offline? (I tried fishing configs out of buildroot a couple
years ago, but after the THIRD one where the secret was "use very old versions
of packages, the current stuff is broken"... And the problems were things like
"the conversion to device tree deleted a huge chunk of this infrastructure", not
simple fixes.)

> Regards
> Greg

Rob

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
