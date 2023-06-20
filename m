Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7C2EB64D8
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:39:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 657193CACBD
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:39:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4A923C9C7B
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 12:39:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9ED1260004C
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 12:38:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79D18218A2;
 Tue, 20 Jun 2023 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687257538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0ygOsPPGoWXR1bXotcvTDtCCW7lxdvaUXargFxx1Co=;
 b=oFmbD9xH8He3TYd8Nx0WKwtREru8lmLXNNkpEzQyAI54cep2kbbr2E8BQqbyzbZ0Fmambh
 edb1H87ZfqGLriwVEItKUtkXUYLU1hQ5geQl9eUkCBdyWVmLF+DjAXnNme8gsrjm7BJbE6
 JRBBqfn1dLe9GBO3Lgs5tCKk+MvIQnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687257538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0ygOsPPGoWXR1bXotcvTDtCCW7lxdvaUXargFxx1Co=;
 b=7mKlm05sgg/7d5NXe8DZVaQr3JS1LERJQYRblWILwsMrtjOtcJQK+SDvfLcsevtJU0jrkE
 x/t+0xCl9cFY9JCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A9991346D;
 Tue, 20 Jun 2023 10:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /yC1DMKBkWT8XwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 10:38:58 +0000
Date: Tue, 20 Jun 2023 12:38:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Message-ID: <20230620103848.GA281987@pevik>
References: <20230605044131.798383-1-dlemoal@kernel.org>
 <20230620091316.GB275381@pevik> <ZJFugRCzFlZYL934@x1-carbon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZJFugRCzFlZYL934@x1-carbon>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Improve ioprio tests
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Tue, Jun 20, 2023 at 11:13:16AM +0200, Petr Vorel wrote:
> > Hi Damien,

> > > The ioprio syscall tests rely on ltp internal definitions of the
> > > IOPRIO_XXX() macro defining priority classes and levels. With changes
> > > to the ioprio API to support command duration limits, these internal
> > > definitions are incomplete, causing test case ioprio_set03 to fail.

> > > Avoid this issue by having the iprio tests use the kernel header file
> > > definitions if that header exists. This enables additional checks in
> > > the header file [1] which restores the expected results with test
> > > ioprio_set03.

> > > [1] https://lore.kernel.org/linux-block/20230530061307.525644-1-dlemoal@kernel.org/

> > > Note: a review of this patch on the kernel block mailing list would be
> > > very appreciated.

I'm sorry, I overlooked Linus' review [2], because it's not visible in
patchwork [3].

@Damien, @Linus, @Niklas FYI you need to be subscribed to post to LTP ML (unlike
vger), otherwise the message is held (and we don't check for held messages very often).
@Niklas I had to push your message due this.

> > I haven't found this patchset on https://lore.kernel.org/linux-block/,
> > did you send it there?

> Hello Petr,

> The patch series for LTP can be found here:
> https://lore.kernel.org/ltp/20230608005315.3703446-1-dlemoal@kernel.org/T/#t

Yes, it's in our LTP mailing list, thus on LTP on lore. But I expected that
linux-block ML would be in Cc (that's why Linus Walleij didn't get it in his
mailbox [4] => @Damien, do not hesitate to Cc relevant kernel (or other mailing
lists), if you expect kernel maintainers to do the review.

> I just checked LTP master, and it hasn't been applied by the
> LTP maintainers yet.

Yes, but do not worry, I'll merge it soon (likely today).

Thank to all for your time.

Kind regards,
Petr

[2] https://lore.kernel.org/ltp/CACRpkdaBinsAofvQgLZ5u8ScR0+yWPnQCf6E7CPtn598PN0eoQ@mail.gmail.com/
[3] https://patchwork.ozlabs.org/project/ltp/patch/20230605044131.798383-2-dlemoal@kernel.org/
[4] https://lore.kernel.org/ltp/CACRpkdaD3xM=Z0xTzHa+yH-wZ+LyhrSb3ZzGzkGdnboCaHw_+A@mail.gmail.com/

> Kind regards,
> Niklas

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
