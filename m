Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2990FC6FA82
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 20:38:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D8D73CAADD
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 22:38:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 977C03CAA99
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:38:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 61F7E1A005E8
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:38:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 117FC33EDE;
 Mon, 12 Sep 2022 20:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663015095;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zf85nF+raYyfagV6W+jEP2JMCH5IzrhHQv1KaVYGyN8=;
 b=EBVFafM6MI/rGsVs9HjTFS0vQMu5hrz9XvpW5g1PgOP75BH+bD86dCTmektqRGALY0qCg9
 D4IRytinIhOLv5/Ld1RlzG53ByV1xS9ESy9OSN8rE4DkaV4CgbBBFL3HMkJ9geHNO4iZeM
 Wn9sb/o4GlSk7wLBTDYrNbVLE//aZyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663015095;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zf85nF+raYyfagV6W+jEP2JMCH5IzrhHQv1KaVYGyN8=;
 b=27MhcbvALoNrLHuRZSnDnhnvqg3asD+nRJqby3p9DbTzwDZodksNluA8Oi8l/k0gMubsfU
 g4EGpYHxHW7g47CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4BB9139E0;
 Mon, 12 Sep 2022 20:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kNtoLraYH2NkRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Sep 2022 20:38:14 +0000
Date: Mon, 12 Sep 2022 22:38:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yx+YtBZOKje6FbWS@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-6-pvorel@suse.cz> <Yx9JPQimBEpXFa4+@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yx9JPQimBEpXFa4+@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 05/10] tst_supported_fs: Support skip list when
 query single fs
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

> Hi!
> Shouldn't this one go before the addition of the functionality to the wrapper used by shell?
Do you mean to put this ("tst_supported_fs: Support skip list when query single
fs") before the previous ("tst_supported_fs: Implement skip list")?

Originally I had these 2 commits in squashed in single commit. But it was quite
big, thus I implemented skip list just for all filesystems and then for
particular filesystem.

Maybe "tst_supported_fs: Implement skip list" should be "tst_supported_fs:
Implement skip list for all fs".

Or did you mean something else?

Kind regards,
Petr

> Other than that:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
