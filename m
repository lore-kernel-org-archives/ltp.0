Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B931EC6FD1F
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:09:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00F013D003D
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:09:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 066E83CD943
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:09:14 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A071220B260
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:09:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA2A85BEFB;
 Wed, 20 Mar 2024 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710950951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tEVEc/vbg7GU49y+9+DmYHNGd0QY5wWHAmP0RNN1D0M=;
 b=LfjQWdRoWV4RzeOpAn/Yy2E1M6UTP9CB/V9piu7nGs7k6OL7cTvd/iqw1qgoLvja7GVaKG
 bvqKf8qhOw4Hbz3E++CTqaDD2A6nIXQT+XRDpIv0zVFvsweeGSlkqY1Y+Jl4KIqNl3llC/
 3v7WKjMb2dS0ObUMaE2XtLurHlJ+UXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710950951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tEVEc/vbg7GU49y+9+DmYHNGd0QY5wWHAmP0RNN1D0M=;
 b=gpbVGfh5lmTn8YC7N/l9Mqi0jCrtRkuoUsoyKi38rygKKM9nAiB47OiNBTWvFlFQe4/FVi
 w30i9fQgZv6I6TBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710950951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tEVEc/vbg7GU49y+9+DmYHNGd0QY5wWHAmP0RNN1D0M=;
 b=LfjQWdRoWV4RzeOpAn/Yy2E1M6UTP9CB/V9piu7nGs7k6OL7cTvd/iqw1qgoLvja7GVaKG
 bvqKf8qhOw4Hbz3E++CTqaDD2A6nIXQT+XRDpIv0zVFvsweeGSlkqY1Y+Jl4KIqNl3llC/
 3v7WKjMb2dS0ObUMaE2XtLurHlJ+UXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710950951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tEVEc/vbg7GU49y+9+DmYHNGd0QY5wWHAmP0RNN1D0M=;
 b=gpbVGfh5lmTn8YC7N/l9Mqi0jCrtRkuoUsoyKi38rygKKM9nAiB47OiNBTWvFlFQe4/FVi
 w30i9fQgZv6I6TBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94E9C136D6;
 Wed, 20 Mar 2024 16:09:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r0rjIScK+2VPYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 16:09:11 +0000
Date: Wed, 20 Mar 2024 17:09:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240320160905.GC489473@pevik>
References: <20240320114247.9518-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240320114247.9518-1-akumar@suse.de>
X-Spamd-Result: default: False [-4.50 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.00)[41.14%];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fpathconf01: Fix SPDX license ID
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

Hi Avinesh,

> Fixes: dbfe867b4dfe ("fpathconf01: Convert to new API")
> Signed-off-by: Avinesh Kumar <akumar@suse.de>

Thanks, merged!

Kind regards,
Petr

> ---
>  testcases/kernel/syscalls/fpathconf/fpathconf01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/fpathconf/fpathconf01.c b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
> index 3c9adb033..a328f972f 100644
> --- a/testcases/kernel/syscalls/fpathconf/fpathconf01.c
> +++ b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>   * Copyright (c) Linux Test Project, 2003-2024

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
