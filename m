Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C172FC433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 14:11:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DF4A3C93D5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 15:11:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 888D73C793B
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 15:11:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0B3191A00CD8
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 15:11:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC9DE21123;
 Wed, 16 Mar 2022 14:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647439892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DDsNVL2kWEjzg3+C5wJa6vmrOjRGwE8LC6euBjTtBM4=;
 b=l+PVz4vAT5m9l43mlAhkvjMbNjdeoqVs3W8eAwG3AN2aM47Rpd5uXixzVS4Kmr0+Gwaobh
 HODJ7G4MfloU8hRTNKIwi1FxJLgX2fHelaJI1pTxuP2bC6g/0zz6lo8mig80bnmlU2j4eS
 XcPjXncf8530t53bhnrwkuyihKO1Cbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647439892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DDsNVL2kWEjzg3+C5wJa6vmrOjRGwE8LC6euBjTtBM4=;
 b=AKlG9J+PWYO8+W1WBUKgrR81JUIpseGFECfyREDh8dFmJiwDSitRqVeJ4ex6IHcINakUy4
 fOIi2iCNllN2/qAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BB1213322;
 Wed, 16 Mar 2022 14:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I0z5HxTwMWKHAwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 16 Mar 2022 14:11:32 +0000
Date: Wed, 16 Mar 2022 15:11:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YjHwEt+hAVQ7bN/D@pevik>
References: <20220315122516.3864-1-pvorel@suse.cz>
 <20220315122516.3864-2-pvorel@suse.cz>
 <6231852C.5020506@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6231852C.5020506@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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

> Hi Petr
> I don't understand why we must serach foo-x86-64 module, so what problem 
> do you meet?

> I used 5.17-rc8,  it still use foo-x86_64 named rule for 
> kernel/arch/x86/crypto/libblake2s-x86_64.ko.

> If kernel has libblake2s-x86_64 module, then tst_check_driver will use 
> libblake2s_x86_64 to find, it should succeed.

> If kernel doesn't have libblake2s-x86_64 module, then tst_ckeck_driver 
> will search twice ,the first time use libblake2s-x86_64  and the second
> time use libblake2s_x86_64, then search failed.

tst_check_driver.sh is failing on intel based systems. Well, we could make sure
it does not try to test libblake2s-x86-64, IMHO it'd be better to make sure
tst_search_driver() works with it, because modinfo/modprobe works with it:

$ modinfo libblake2s-x86-64
name:           libblake2s_x86_64
filename:       (builtin)
license:        GPL v2
file:           arch/x86/crypto/libblake2s-x86_64

Sure, it's a corner case, but I'd still fix it.
Let's see what other think.

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
