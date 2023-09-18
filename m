Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FC6CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:33:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 079243CE502
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 15:33:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE9963C0B8E
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 15:33:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C530B140043D
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 15:33:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AD4D21AAC;
 Mon, 18 Sep 2023 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695043999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FjhwxZqiGkToQV/VjpcW+JsvClTeB9o0IsyagkEWGw=;
 b=3LJBEZVcbydrq5ZH7eXWVCgWf9FyHFo6TrQyz7wj/x1UtoVHnyZwFufT+DP15iEX3S0GYh
 9lS/dU2GD+toZNXxln7tj3XKdDeLU+WGdqbdmMmcmX5SFvDvtLhbTk+q69VCQsIxYz1uoh
 rzPfOHy4UaRqLAOx59mGwZXXXgKbDpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695043999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FjhwxZqiGkToQV/VjpcW+JsvClTeB9o0IsyagkEWGw=;
 b=SrOU/2fwPo9X2zOAmhNgQIvVUx3lmk4w2EXSX2+wJROMYiUoOJhKKrQjGy2cCYK1iZ+1Vi
 j1qHYT+854p4lXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31DC313480;
 Mon, 18 Sep 2023 13:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Xm/fCp9RCGWfGgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 18 Sep 2023 13:33:19 +0000
Date: Mon, 18 Sep 2023 15:33:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230918133317.GA31981@pevik>
References: <20230918115608.5630-1-andrea.cervesato@suse.de>
 <20230918115608.5630-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918115608.5630-3-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] Add Linux Test eXecutor inside tools
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .gitmodules        |  3 +++
>  tools/ltx/Makefile | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 tools/ltx/Makefile

You omitted tools/ltx/ltx-src, which pointed to
d6d1509479537f4fdfa9b5adcb67eb6312714999, which you correctly had in v5.

To avoid v7 I added it and merged it with Richie's ABT and Cyrils RBT.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
