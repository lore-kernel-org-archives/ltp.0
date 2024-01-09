Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27874C4707C
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 15:19:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75DA83CE4B6
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 16:19:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69A713C4D6F
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 00:17:59 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=srs0=cgsk=it=linux-m68k.org=gerg@kernel.org;
 receiver=lists.linux.it)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3551A6019A8
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 00:17:57 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id B178BB81B6E;
 Tue,  9 Jan 2024 23:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2313DC433C7;
 Tue,  9 Jan 2024 23:17:51 +0000 (UTC)
Message-ID: <461a6556-8f24-48f5-811a-498cb44f2d64@linux-m68k.org>
Date: Wed, 10 Jan 2024 09:17:48 +1000
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
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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


On 10/1/24 06:24, Rob Landley wrote:
> On 1/8/24 03:03, Petr Vorel wrote:
>> Hi Rob, all,
>>
>> [ Added Niklas Cassel, who is maintainer of qemu_riscv64_nommu_virt_defconfig in
>> buildroot ]
> 
> Hi Niklas!
> 
>>> Buildroot also apparently has an LTP package selectable in menuconfig:
>>
>>> https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite
>>
>>> But I haven't tried it...
>>
>> I'm the maintainer of the LTP package in buildroot in my private time.
>> BTW I spent quite a lot of time fixing LTP (and some other system packages,
>> e.g. nfs-utils) compilation on some old legacy architectures reported via
>> http://autobuild.buildroot.net/ I've never used in the reality.
>> But I certainly don't have time to drive nommu support in my private time.
>> I don't even have an interest, I don't use any nommu device.
> 
> I do, but I've never done much with LTP, and I have my hands full with toybox
> and mkroot already.
> 
>> Therefore nobody who is not involved in nommu will not find a time to support it
>> in LTP (support does not mean just to add the functionality to the new C API,
>> but run tests on nommu and fix failing bugs). I suppose nobody is paid to work
>> on nommu platforms, it would have to be a hobby project, right?
> 
> A bunch of people are paid to work on nommu platforms, and I've worked with them
> a bunch, but none of them talk to linux-kernel. They find the culture toxic,
> insular, and categorically dismissive of their interests.

I have been involved in the kernel nommu space for 20 years, and sure, there is
some of that. But mostly spending some time and effort to get involved pays off.
I have seen potential contributors show up with some arrogant attitudes too,
so it cuts both ways here.

The m68k community I have been part of has been nothing but welcoming. The mm
people have tried hard to keep nommu support up-to-date where almost none of them
actually have a vested interest in doing so.

What I have seen is that many companies working in this space just don't want
to spend the time and effort to go mainline. That is a business decision they
make, and that is fine. Heck my work in actual mainline has never really been
paid for by any company and I have sunk a _lot_ of time into it. (Full disclosure
I did get paid to work on early porting and support - just not geting it into
mainline and maintain it there).


> For example, cortex-m is a large nommu platform on which vendors support Linux
> BSPs, but notice how page 8 of
> https://www.microsemi.com/document-portal/doc_view/132181-linux-cortex-m-users-manual
> points at a cross compiler toolchain from _2010_ and page 4 says they're booting
> a 2.6.33 kernel?

Any company/person who follows the route of not working with the linux kernel
community to get their work included is going to inevitably get stuck on older
versions of everything.


> I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
> of people have been happy to consume my work, but getting any of them to post
> directly to linux-kernel is like pulling teeth.

I regularly test nommu configurations (as in every kernel rc and release) on m68k
and at least every release on other architectures like arm(*) and recently on
riscv as well.

(*) somewhat annoyingly needing a minor patch to run the versatile qemu platform
     I like to test with. But hey, that is on me :-)

Regards
Greg



>> But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
>> support him in my free time (review patches, give advices). And if nobody
>> stands, this patchset which removes the support in the old API will be merged
>> after next LTP release (in the end of January).
> 
> What does the API migration do? Is there a page on it ala OABI vs EABI in arm or
> something?
> 
> Rob

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
