Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAEFC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 09:50:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B28FB3C94FD
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 10:50:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A535F3C9338
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 10:50:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E26106018B8
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 10:50:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26ABA1F37F;
 Fri, 18 Mar 2022 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647597005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2i1JyJQsOxqjwNvOhbx7HqWs/5SjpxP1FVs4H/ZiZw=;
 b=cQM6zg9Zo1C5cni7+LCwaF2NtW2c7ucfQbtHsEEMAU6mHbLr47DNc1J236+m6rOtyEbsIY
 svlW0/w9tt972268GdKhqe/L0UAVjbjB6hch5alEIEXNdqlULTBzYjOVZc2FlFIcTEE9jQ
 9hE1qgQW+rx2UfFEIYsMFPYCUuwDldU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647597005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2i1JyJQsOxqjwNvOhbx7HqWs/5SjpxP1FVs4H/ZiZw=;
 b=z6nJC3lGrgGZC9wtmJC0Mqcd0LI9fSOKcsK9QreBW++uJHyGv46+VwDghx26DT2nhg/Z+K
 /OjIlkuIWQn1UIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9DD813B67;
 Fri, 18 Mar 2022 09:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D+eQMsxVNGIMSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Mar 2022 09:50:04 +0000
Date: Fri, 18 Mar 2022 10:50:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YjRVyiJry8kErKTs@pevik>
References: <20220315122516.3864-1-pvorel@suse.cz>
 <20220315122516.3864-2-pvorel@suse.cz>
 <6231852C.5020506@fujitsu.com> <YjHwEt+hAVQ7bN/D@pevik>
 <CAEemH2fGoTamaY14KSt6s+SvajQVEFp1kshCWCdDd74p9goH6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fGoTamaY14KSt6s+SvajQVEFp1kshCWCdDd74p9goH6Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_kernel: Fix search for foo-x86-64 module
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> On Wed, Mar 16, 2022 at 10:11 PM Petr Vorel <pvorel@suse.cz> wrote:

> > > Hi Petr
> > > I don't understand why we must serach foo-x86-64 module, so what problem
> > > do you meet?

> > > I used 5.17-rc8,  it still use foo-x86_64 named rule for
> > > kernel/arch/x86/crypto/libblake2s-x86_64.ko.

> > > If kernel has libblake2s-x86_64 module, then tst_check_driver will use
> > > libblake2s_x86_64 to find, it should succeed.

> > > If kernel doesn't have libblake2s-x86_64 module, then tst_ckeck_driver
> > > will search twice ,the first time use libblake2s-x86_64  and the second
> > > time use libblake2s_x86_64, then search failed.

> > tst_check_driver.sh is failing on intel based systems. Well, we could make
> > sure
> > it does not try to test libblake2s-x86-64, IMHO it'd be better to make sure
> > tst_search_driver() works with it, because modinfo/modprobe works with it:

> > $ modinfo libblake2s-x86-64
> > name:           libblake2s_x86_64
> > filename:       (builtin)
> > license:        GPL v2
> > file:           arch/x86/crypto/libblake2s-x86_64

> > Sure, it's a corner case, but I'd still fix it.
> > Let's see what other think.


> Which kernel (and kmod) version did you use?

> I tried locally on my rhel8 and fedora 34 but that doesn't work for me.

> $ rpm -q kmod
> kmod-28-2.fc34.x86_64

> $ lsmod  |grep  libblake2s
> libblake2s             16384  0
> blake2s_x86_64         20480  1 libblake2s
> libblake2s_generic     20480  1 blake2s_x86_64

> $ modinfo libblake2s-x86-64
> modinfo: ERROR: Module libblake2s-x86-64 not found.
=> 5.16 had blake2s_x86_64, not libblake2s_x86_64

openSUSE
* 5.17.0-rc7-26.g04b7727-default, kmod-29-8.4.x86_64
works (testing libblake2s-x86-64)
* 5.16, kmod-29-7.1.x86_64
works (testing blake2s_x86-64)

Fedora 34
* 5.13.16, kmod-29-2.fc34.x86_64
works (testing blake2s_x86-64)


> Then I checked the Linux source code and get:
> ------------------

> $ cat linux/arch/x86/crypto/Makefile |grep libblake2s
> obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) += libblake2s-x86_64.o
> libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
6048fdcc5f26 ("lib/crypto: blake2s: include as built-in")
Follows: v5.16-rc8
Precedes: v5.17-rc1
...
+++ b/arch/x86/crypto/Makefile
...
-blake2s-x86_64-y := blake2s-core.o blake2s-glue.o
+blake2s-x86_64-y := blake2s-shash.o
+obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) += libblake2s-x86_64.o
+libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
