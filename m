Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA048C4707C
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 13:34:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAE043CE4D0
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 14:34:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC5253C4D74
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 14:34:02 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36FB86005FC
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 14:34:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B0A7220B0;
 Wed, 10 Jan 2024 13:34:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4201013786;
 Wed, 10 Jan 2024 13:34:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5hiwDMicnmUSKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 10 Jan 2024 13:34:00 +0000
Date: Wed, 10 Jan 2024 14:33:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Rob Landley <rob@landley.net>
Message-ID: <20240110133358.GB1698252@pevik>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki>
 <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik>
 <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2B0A7220B0
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
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

Hi Rob, all,

> On 1/8/24 03:03, Petr Vorel wrote:
> > Hi Rob, all,

> > [ Added Niklas Cassel, who is maintainer of qemu_riscv64_nommu_virt_defconfig in
> > buildroot ]

> Hi Niklas!

> >> Buildroot also apparently has an LTP package selectable in menuconfig:

> >> https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite

> >> But I haven't tried it...

> > I'm the maintainer of the LTP package in buildroot in my private time.
> > BTW I spent quite a lot of time fixing LTP (and some other system packages,
> > e.g. nfs-utils) compilation on some old legacy architectures reported via
> > http://autobuild.buildroot.net/ I've never used in the reality.
> > But I certainly don't have time to drive nommu support in my private time.
> > I don't even have an interest, I don't use any nommu device.

> I do, but I've never done much with LTP, and I have my hands full with toybox
> and mkroot already.

Understand.

> > Therefore nobody who is not involved in nommu will not find a time to support it
> > in LTP (support does not mean just to add the functionality to the new C API,
> > but run tests on nommu and fix failing bugs). I suppose nobody is paid to work
> > on nommu platforms, it would have to be a hobby project, right?

> A bunch of people are paid to work on nommu platforms, and I've worked with them
> a bunch, but none of them talk to linux-kernel. They find the culture toxic,
> insular, and categorically dismissive of their interests.

> For example, cortex-m is a large nommu platform on which vendors support Linux
> BSPs, but notice how page 8 of
> https://www.microsemi.com/document-portal/doc_view/132181-linux-cortex-m-users-manual
> points at a cross compiler toolchain from _2010_ and page 4 says they're booting
> a 2.6.33 kernel?

> I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
> of people have been happy to consume my work, but getting any of them to post
> directly to linux-kernel is like pulling teeth.

Interesting, thanks for sharing this. BTW I'm not saying anybody is using nommu,
but I wonder if anybody really test it with LTP. And if yes, I wonder why we
don't have reports about tests broken in new API.

> > But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
> > support him in my free time (review patches, give advices). And if nobody
> > stands, this patchset which removes the support in the old API will be merged
> > after next LTP release (in the end of January).

> What does the API migration do? Is there a page on it ala OABI vs EABI in arm or
> something?

New C API is documented at our wiki: the API for using in the tests [1]
and the library itself [2]. (We also have shell API, but we can ignore it for
nommu.)

All files in lib/ directory which include tst_test.h are part of new C API. Main
file is lib/tst_test.c. LTP tests, which has been rewritten to new API include
tst_test.h, they are in testcases/ directory. Library has it's own tests (for
testing regression in in lib/newlib_tests/*.c.

The reason why Cyril wrote in 2016 new C API was that the old API was buggy
(tests randomly fails). Tests which are still using the old API (there is
ongoing rewrite) include test.h. The old API is not much documented.

Feel free to ask any more question.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/C-Test-API
[2] https://github.com/linux-test-project/ltp/tree/master/lib

> Rob

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
