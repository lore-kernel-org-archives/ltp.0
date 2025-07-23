Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB36C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 19:10:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E946F3CCDB3
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 21:10:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E7613CAF64
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 21:09:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BA3CA6009FB
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 21:09:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B949E1F78C;
 Wed, 23 Jul 2025 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753297782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+eLNianCO6qD60yzNI6tevPasBhob0wuU5ljtMPezs=;
 b=V08bhCCcBV3RMvbznz8qQpZjjhYcJuqmwPzBBI9wwqhDc25RlhuJJVkhFllM84vTSZ+RMx
 1mZsxSgjBKsvYDQYCjH+ryMOZrS7YejL2yY4lmgh50n4N4hBJLLkSd+NI3ZoxK0gil1CqN
 DJObNd7JhZsHCFxaZHmQbaVx60P7Umk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753297782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+eLNianCO6qD60yzNI6tevPasBhob0wuU5ljtMPezs=;
 b=r3qqPSOianWqt6XqC5CV3IUn3EigRjRzbfNe44KWCjrimKFQUYdgMjED7PVpe1ABKY7SLk
 NXbmFPeYaMF+3zCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753297782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+eLNianCO6qD60yzNI6tevPasBhob0wuU5ljtMPezs=;
 b=V08bhCCcBV3RMvbznz8qQpZjjhYcJuqmwPzBBI9wwqhDc25RlhuJJVkhFllM84vTSZ+RMx
 1mZsxSgjBKsvYDQYCjH+ryMOZrS7YejL2yY4lmgh50n4N4hBJLLkSd+NI3ZoxK0gil1CqN
 DJObNd7JhZsHCFxaZHmQbaVx60P7Umk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753297782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+eLNianCO6qD60yzNI6tevPasBhob0wuU5ljtMPezs=;
 b=r3qqPSOianWqt6XqC5CV3IUn3EigRjRzbfNe44KWCjrimKFQUYdgMjED7PVpe1ABKY7SLk
 NXbmFPeYaMF+3zCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FAC613302;
 Wed, 23 Jul 2025 19:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id feyLJXYzgWgvfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Jul 2025 19:09:42 +0000
Date: Wed, 23 Jul 2025 21:09:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <20250723190940.GA162896@pevik>
References: <20250723011807.15857-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250723011807.15857-1-yangtiezhu@loongson.cn>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] device-drivers/block/block_dev_kernel: Delete
 test_genhd.c
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

Hi Tiezhu,

> test_genhd.c is not used any more, just delete it. While at it,

Thanks for your work, merged.

> update README to reflect the reality.

See below...

> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  testcases/kernel/device-drivers/block/README  | 17 +-----
>  .../block/block_dev_kernel/test_genhd.c       | 53 -------------------
>  2 files changed, 2 insertions(+), 68 deletions(-)
>  delete mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/test_genhd.c

> diff --git a/testcases/kernel/device-drivers/block/README b/testcases/kernel/device-drivers/block/README
> index 812436bb8..1490fd295 100644
> --- a/testcases/kernel/device-drivers/block/README
> +++ b/testcases/kernel/device-drivers/block/README
> @@ -5,19 +5,6 @@ Module under test: linux/block/genhd.c
>   -----------------------------+---------------+---------------
>    register_blkdev()           | linux/fs.h    | ltp_block_dev.c
>    unregister_blkdev()         | linux/fs.h    | ltp_block_dev.c
> -  blk_register_region()       | linux/genhd.h |
> -  blk_unregister_region()     | linux/genhd.h |
> -  add_disk()                  | linux/genhd.h |

Internal kernel header <linux/genhd.h> was merged into in <linux/blkdev.h> in
v5.18-rc1. That means that functions was moved there. Also, some functions was
renamed, although I did not investigate whether before this change (i.e. renamed
in <linux/genhd.h>) or after in <linux/blkdev.h>. I suppose both.

Also at least add_disk() and del_gendisk() is in <linux/blkdev.h> and it's being
tested in other LTP modules:

$ git grep -l add_disk
testcases/kernel/device-drivers/include/includeTest.c
testcases/kernel/device-drivers/nls/nlsTest.c
testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c

$ git grep -l del_gendisk
testcases/kernel/device-drivers/include/includeTest.c
testcases/kernel/device-drivers/nls/nlsTest.c
testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c

These are outside of testcases/kernel/device-drivers/block/. I wonder if this
README makes sense when there are other kernel modules using block driver
related functions. But anyway, outdated README is just expected in these old
modules with questionable usability (sometimes I think we should just delete
them all and let kernel internals being tested in Kunit).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
