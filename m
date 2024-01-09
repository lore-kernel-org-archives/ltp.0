Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4428C4707B
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 20:18:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 013793CE514
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 21:18:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3DE43CE501
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 21:17:48 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B82821400C74
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 21:17:46 +0100 (CET)
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7bee874fcc2so30294139f.1
 for <ltp@lists.linux.it>; Tue, 09 Jan 2024 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704831465; x=1705436265;
 darn=lists.linux.it; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zvygCsnAZQSUX1OyBrWi0tyZLEH0CAk1fXUh+ZaJ3Lo=;
 b=pfiC9P7YXCBaYHSRzjNeZ3YGh+dlteonVTkKixpbHjbeoXtRwS7yf9zQHG3vX68eS8
 7xb+OiWqn64XKBwuZdr9OFts7Zik890kLiZ69RT04WLRX6ygOktn3UltmDhwmj8ZWlSe
 +1Qx4RgTktK0z5w8rZV8B3OqA+8tLmWl2NjzdPA/UXnDsR42qt3kPhDThS75oJoMXb88
 gnvpbp3KWueKy7PDipg8fM29eWPPooAB6mPDuXHm1Zw5Zx1KHMGJJQ5ySHtiC+NHZwht
 +yKSF0alSIrbniWn7dkehXPylssQ5MoaIwl20MSdFUiVM1QiS5vXcXk+Ra+/12mG5Vub
 5+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704831465; x=1705436265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvygCsnAZQSUX1OyBrWi0tyZLEH0CAk1fXUh+ZaJ3Lo=;
 b=rE/6JfGfYZ8uVsdLEru6XsIQm7v00KO1wbArtNcOrm+db/Xq7IeJHzJqGOQ7PpcT2s
 oP2BmsqIjvLuK1A/7oMyh44Qfzke5WzeKrXK/FxVejWIhhgueNfgnOfVgjb3WEc6HPYb
 vmIDTtMlLxQZ2Q7ltU79FypNA0PY+4YMnNmkWK4sLbYXhp0bW43Te/iNAfM9gjpCVyCj
 +nbSOYThiw5pRk133LKs43WlPD2MlXFjH67oQOm1KKoTYJKcq86Tfae/noLzKXTD0o7y
 4gKNX7KFjaE/roMSjnfhQOZIRXoG2TxRWNr+32ZwMQ84YmzZzf3KW62eAWA7VIs6k7Zw
 8L+A==
X-Gm-Message-State: AOJu0YzIKKiOLpXbkgdNEUOKMjgIw+vb0pB+jz6bPzCih9K5hld+GQXQ
 Zzv/H2C629m3zqzIYk/t7EabTI/l//utLA==
X-Google-Smtp-Source: AGHT+IHJDeszorYY5GFrmlMsgPhnGqSSgFTpBWcziFxtkUG5t0gPVrqEY0fdimh0r8UPafEYZce6pw==
X-Received: by 2002:a6b:7e08:0:b0:7bc:4215:da28 with SMTP id
 i8-20020a6b7e08000000b007bc4215da28mr5504732iom.42.1704831465186; 
 Tue, 09 Jan 2024 12:17:45 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a02a305000000b0046e4506fa75sm13527jai.26.2024.01.09.12.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 12:17:44 -0800 (PST)
Message-ID: <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
Date: Tue, 9 Jan 2024 14:24:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik>
From: Rob Landley <rob@landley.net>
In-Reply-To: <20240108090338.GA1552643@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 1/8/24 03:03, Petr Vorel wrote:
> Hi Rob, all,
> 
> [ Added Niklas Cassel, who is maintainer of qemu_riscv64_nommu_virt_defconfig in
> buildroot ]

Hi Niklas!

>> Buildroot also apparently has an LTP package selectable in menuconfig:
> 
>> https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite
> 
>> But I haven't tried it...
> 
> I'm the maintainer of the LTP package in buildroot in my private time.
> BTW I spent quite a lot of time fixing LTP (and some other system packages,
> e.g. nfs-utils) compilation on some old legacy architectures reported via
> http://autobuild.buildroot.net/ I've never used in the reality.
> But I certainly don't have time to drive nommu support in my private time.
> I don't even have an interest, I don't use any nommu device.

I do, but I've never done much with LTP, and I have my hands full with toybox
and mkroot already.

> Therefore nobody who is not involved in nommu will not find a time to support it
> in LTP (support does not mean just to add the functionality to the new C API,
> but run tests on nommu and fix failing bugs). I suppose nobody is paid to work
> on nommu platforms, it would have to be a hobby project, right?

A bunch of people are paid to work on nommu platforms, and I've worked with them
a bunch, but none of them talk to linux-kernel. They find the culture toxic,
insular, and categorically dismissive of their interests.

For example, cortex-m is a large nommu platform on which vendors support Linux
BSPs, but notice how page 8 of
https://www.microsemi.com/document-portal/doc_view/132181-linux-cortex-m-users-manual
points at a cross compiler toolchain from _2010_ and page 4 says they're booting
a 2.6.33 kernel?

I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
of people have been happy to consume my work, but getting any of them to post
directly to linux-kernel is like pulling teeth.

> But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
> support him in my free time (review patches, give advices). And if nobody
> stands, this patchset which removes the support in the old API will be merged
> after next LTP release (in the end of January).

What does the API migration do? Is there a page on it ala OABI vs EABI in arm or
something?

Rob

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
