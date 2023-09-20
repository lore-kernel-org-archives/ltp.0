Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71D4C04FCD
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 18:16:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0D4D3CE426
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 20:16:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D6363C62B7
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 20:16:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DCFD81000B44
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 20:16:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8957421F82;
 Wed, 20 Sep 2023 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695233785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=alsENHXg4AeAyI/loQZmuUzTEVG2ZArTbR1ShAqXEqI=;
 b=WqQMz61CCxT9p9VcZQ6aBO8rGQ/RLjasyAmuYmEIuvBLJqRip96lVJZqZ5CZGZUGQLSmym
 VzSj4rqLWcYJYQ4l1YdRWXFMiCWZ9HdJGPetVfbjdpJYKbMOwABLLq8rhiTc4leMhqjk5y
 VjBiuwg9+Jd5cP7RsNZt8o3TAJNIOUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695233785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=alsENHXg4AeAyI/loQZmuUzTEVG2ZArTbR1ShAqXEqI=;
 b=2Dgt6x+EfQtmr9NnYi+7C9Huba0UM5x9BAxIVTNfGC2g4NFFbco88AS4flL9HqCIzTrTPS
 RkjqAXAEdz0enpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71AD21333E;
 Wed, 20 Sep 2023 18:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 96SzGvk2C2XTHQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 20 Sep 2023 18:16:25 +0000
Date: Wed, 20 Sep 2023 20:17:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZQs3J6AUPWcRQZxJ@yuki>
References: <20230920154447.3165-1-chrubis@suse.cz>
 <783bad35-1735-f5df-c50b-22d5949def37@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <783bad35-1735-f5df-c50b-22d5949def37@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: lockdown: Report lockdown as disabled on
 missing sysfs
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > We currently report -1 when secure boot sysfs file is not present which
> > is later interpreted as secure boot enabled. This causes regression in
> > *_module sycall tests executed on systems when secureboot is not
> > compiled-in or supported at all.
> 
> That's incorrect usage then. The tests should check 
> tst_secureboot_enabled() > 0 instead. I think it will be useful to know 
> whether the function found that secureboot is disabled, or could not 
> check at all. We should just document it better.

Yes, the functions do not seem to have any documentation.

So I guess that we need:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2e58cad33..e2c195645 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1163,10 +1163,10 @@ static void do_setup(int argc, char *argv[])
        if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
                tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);

-       if (tst_test->skip_in_lockdown && tst_lockdown_enabled())
+       if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
                tst_brk(TCONF, "Kernel is locked down, skipping test");

-       if (tst_test->skip_in_secureboot && tst_secureboot_enabled())
+       if (tst_test->skip_in_secureboot && tst_secureboot_enabled() > 0)
                tst_brk(TCONF, "SecureBoot enabled, skipping test");

        if (tst_test->skip_in_compat && TST_ABI != tst_kernel_bits())

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
