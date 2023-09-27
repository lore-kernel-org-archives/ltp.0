Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2E3E80A8C
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 05:37:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D819F3CBAEF
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 07:37:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E0623C9942
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 07:37:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0280C100187A
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 07:37:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3A0E1F890;
 Wed, 27 Sep 2023 05:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695793054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5oFw1mkeenImIK1veRBlop6+KZFghEh2/xD/wd9H+so=;
 b=2Zc1C38aaWGyvjqWHMayzNV4yCYe0jE2KXvHGENgZ+gfB7D+e1B1l2bz4gVMUyFX4RHeUd
 KmUsW6/yRhAnndz//R34jEJh/H8fqImAASd7cl9tADFThM+RWY/TI4+c/wGAHB9colrChC
 ZqbJez5bCD0ppzN2+6slASpH+1qAdxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695793054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5oFw1mkeenImIK1veRBlop6+KZFghEh2/xD/wd9H+so=;
 b=UbnCvFgyP3es7J+t1dXfGvv7PSOrdfXw38xgosOw/p+nJKbclrXklxJJpa1OgVtULpEknj
 +1HOo6eM+1emBOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1F1D1338F;
 Wed, 27 Sep 2023 05:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wKf0KZ6/E2UcCwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 05:37:34 +0000
Date: Wed, 27 Sep 2023 07:37:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230927053732.GC205174@pevik>
References: <20230926124647.152972-1-pvorel@suse.cz>
 <20230926124647.152972-2-pvorel@suse.cz> <ZRLm0Ybn_gQYJ-4I@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRLm0Ybn_gQYJ-4I@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] vma05.sh: Add workaround for gdb debuginfod
 question
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > A candidate for pre-release fix.

> Looks simple enough for the release.
Thanks, this first patch merged to get Tumbleweed fixed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
