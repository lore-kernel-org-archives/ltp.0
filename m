Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C839CC00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 06:57:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 828CD3C95DC
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 08:57:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E54E73C1BEA
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 08:57:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C55BA60076A
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 08:57:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A07F737EE3;
 Wed, 10 Aug 2022 06:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660114642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jm04Iw0FliW7FqkEcklQiAHSrAS3zrrfGU5KSJeykAE=;
 b=rBqE0K8LFs1pEal8XSK8GwpjI+kRr/8WzI2l+fj0QKkM/s3gYyGjWg8P81Y+M1/7gLStki
 fgWGpL+EMT43zgmb9I4n5GfFUXcurGSHod2av21H3WiO1+F6FTwM+zp/Ay9oxXAktu9sKM
 bdaQYe2SExvaAwwiMIfTwVJUutAylHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660114642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jm04Iw0FliW7FqkEcklQiAHSrAS3zrrfGU5KSJeykAE=;
 b=M+Qlr/8jL9pLZALFwgmk9i17c1RTT0gIgHjd2XsuHnihvNmnzlT89yK+/TIJT91lL6GpN2
 Wh+N2rU56+bykhDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77A3C13AB3;
 Wed, 10 Aug 2022 06:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gDeaG9JW82LVVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 10 Aug 2022 06:57:22 +0000
Date: Wed, 10 Aug 2022 08:57:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YvNW0OQYwUhDjIOC@pevik>
References: <20220803120905.3107-1-andrea.cervesato@suse.com>
 <Yuz5pIv+98cFmgBg@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yuz5pIv+98cFmgBg@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Refactor aiocp using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Cyril,

> Hi!
> The code looks good now, but still needs a runtime treatement similar to
> the one done in 3ab0b3cb24198a0a833e4450b8bc9cee8b70baf6.

OK, new version is needed. When you're in it, could you please consider things
Cyril asked in v1? [1]

* rename functions
	I guess that it would be cleaner to rename the functions to something as
	put_iocb() and get_iocb() since they do not allcate anything but they
	have to stay.

* I suppose later you implement ioctl() BLKSZGET
	> -static int dev_block_size_by_path(const char *path)

	Just FYI this is actually the only correct way how to get the O_DIRECT
	block size, we have to get the device and then call the BLKSZGET
	ioctl(). This code has to be put into the test library and reused in all
	O_DIRECT tests in a followup patch.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/comment/2917667/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
