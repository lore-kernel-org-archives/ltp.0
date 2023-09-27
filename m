Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76613E80A8E
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 05:52:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C783C3CBAE3
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 07:52:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 137B13C0B8E
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 07:52:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2E78B600ECF
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 07:52:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C93EE215E6;
 Wed, 27 Sep 2023 05:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695793942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jM1fWYxzFsIX4eLAO6hFl8nAqkjBTjfDGE+bfeL3ddk=;
 b=VcrO4IZLWHUMWrMCygoxIUQ0kBxeAqvRApo/q37/xh4RMkGCXm8+lTVwZcUVvbaMLGpF3C
 u8acNyUkgminrgP57B94pHKFPTcHLAFW55XFrL+SS+oxxD9JPr0vkCIJQYDP/hDHBSK0mp
 cjeRwk3U6U7cguEk2iRMTBlq/rp9KH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695793942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jM1fWYxzFsIX4eLAO6hFl8nAqkjBTjfDGE+bfeL3ddk=;
 b=cEodWe2E90KlL0No2xB24xQQ1NcbL0EkIV3pfXqS8QdBmwkOM42XWLJmwjdoyZEaOGoOC4
 jAYfdi35baZB58BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A78951390B;
 Wed, 27 Sep 2023 05:52:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8uI2JxbDE2VvEgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 05:52:22 +0000
Date: Wed, 27 Sep 2023 07:52:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230927055221.GE205174@pevik>
References: <20230925144206.16895-1-mkittler@suse.de>
 <20230925151728.GE60471@pevik> <ZRKEQKHgkpVURMFs@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRKEQKHgkpVURMFs@wegao>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Skip cgroup-related tests if `/sys/fs/cgroup`
 readonly
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

Hi,

...
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
>   Tested-by: Wei Gao <wegao@suse.com>
    ^
	Unwanted whitespace before the tag.

Wei, please don't put this whitespace space next time.

Not only this is wrong, but it breaks automatic adding of your tag.
Patchwork (https://patchwork.ozlabs.org/project/ltp/list/) which we use for
downloading patches automatically adds all tags associated with the patch,
unless there is whitespace before the tag.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
