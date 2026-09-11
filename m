Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406FAC88E45
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 14:09:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 967D93E921F
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 16:09:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7CA23C66CF
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 16:08:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EE9E21400E12
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 16:08:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D44421BE3;
 Fri, 11 Sep 2026 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789135728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ALpnGBDnaTrdwEmbum4TjCgiKZcUGrph3tQIHn2jyM=;
 b=aeHKblr46xrM/6ZG3a69EGBHSfkf668G2bD9KOjegBJSrirI8yD50sWE4lqY9A5tu66Mer
 82B70kDdP+ewHBuyFz7vMHR3IuZDPGfBoPLQ9Zvj5gUD+lslrxTwwObcPo8KPm+QdrCt+T
 lB8+EBCJOGvhqt338AfH7QSLYY4LRII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789135728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ALpnGBDnaTrdwEmbum4TjCgiKZcUGrph3tQIHn2jyM=;
 b=JpM+8SiAF6GpE6vDcata6JcokpxDZ0TKMlmpwucMW6s//+r6HSDRnHokRqkJrVBwKHYk5O
 tQilhP9ozAKUMECg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789135724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ALpnGBDnaTrdwEmbum4TjCgiKZcUGrph3tQIHn2jyM=;
 b=GoR+87nDYht8kHpt4iR2r5ouWNqujV4HzoyMhtHiUXTnHM51uR5+l/5ZO9Clwi/7P1JmhC
 t16NI9M5pLV3XvcdyOPpNs2hCcGEC+7xRz/Yvdif08BnErYfdy6NryShL7NAT2BetApNtM
 Fbj4KGYkIEa6jAYbmc+D/P8PUjw+BJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789135724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ALpnGBDnaTrdwEmbum4TjCgiKZcUGrph3tQIHn2jyM=;
 b=A59XG7hDvqymW5MuQtqXlm+iGEgCLEp4urM50irG0PjoC2ILUg2AqAaldMNJ/eHoVStMz6
 rm6xXkRXKMGorOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BB8F132D3;
 Fri, 11 Sep 2026 14:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kaQ3BGwLpGrnZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 14:08:44 +0000
Date: Fri, 11 Sep 2026 16:08:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260911140838.GD1488703@pevik>
References: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
 <20260828-mmap_32bit_coverage-v1-2-7f0b8b589773@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260828-mmap_32bit_coverage-v1-2-7f0b8b589773@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] mmap23: add test for MAP_32BIT oversized
 mapping
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Obviously correct.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/testcases/kernel/syscalls/mmap/mmap23.c
...
> +/*\
> + * Verify that :manpage:`mmap(2)` with the MAP_32BIT flag fails with ENOMEM
> + * when requesting a mapping of size >= 2GB, since it cannot fit within the
> + * first 2GB of address space.
> + *
> + * MAP_32BIT is supported only on x86-64 for 64-bit programs.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/mmap.h"
> +
> +#define MAP_SZ (2UL * TST_GB)

Interesting enough, it works on 1GB as well:

#define MAP_SZ (1UL * TST_GB)

Actually the minimum working memory on my system is 1001 MB (1001UL * TST_MB)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
