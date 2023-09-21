Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732ADCD4958
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 06:08:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 472833CDE8F
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 08:08:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B847E3CA393
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 08:08:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB2E1601BA6
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 08:08:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C3E620792;
 Thu, 21 Sep 2023 06:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695276512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gh9Hf6R2IykLssyFWaEq8O97tTP/Awots+VB1p7TliM=;
 b=dQA8BzBX/JQNsF6tvZcTb1NoDfij6JiwhKajiGEmkQLBDDGH0EBPd7fIQJl4rQ8exZ4/4g
 qnG4jH6utkBkg1I9GZpfxB/HmqAiD79ZBZ9RcSN2RJoaqQWKEvYS8xcfxuRCOf5Xqfd6WR
 XctCknmR2ari88SOoDC4uVdJKvaVk5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695276512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gh9Hf6R2IykLssyFWaEq8O97tTP/Awots+VB1p7TliM=;
 b=fhNaLurZxEblFtUsDwR8fB4YMw/nRbaleUiQFUtHowknvBK9iRZqvOFRUHHuJSLfUvf5s0
 Xi3bE1iMQ0/FmnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75FD1134B0;
 Thu, 21 Sep 2023 06:08:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vxp0G+DdC2WsUQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 21 Sep 2023 06:08:32 +0000
Date: Thu, 21 Sep 2023 08:08:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230921060831.GA393601@pevik>
References: <1694770587-9502-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1694770587-9502-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/renameat: Remove renameat fallback
 definition
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

Hi all,

> Looking at man renameat, it was added into kernel 2.6.16 and since the
> oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
> .txt) we can as well completely drop this fallback definition.

Yang asked [1] also for removing entry in include/lapi/syscalls/aarch64.in and
others, but I think we should keep it there.

I'd definitely keep this till the release, but then it should be safe to remove
this old fallback.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/040088ba-20f1-711f-3fe5-6d1d4782a015@fujitsu.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
