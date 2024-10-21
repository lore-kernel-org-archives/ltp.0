Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8182CD1712B
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 19:55:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 737293C6F37
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 21:55:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 374033C6AEB
 for <ltp@lists.linux.it>; Mon, 21 Oct 2024 21:55:35 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 77D0F1017E38
 for <ltp@lists.linux.it>; Mon, 21 Oct 2024 21:55:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 685AA21C9E;
 Mon, 21 Oct 2024 19:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729540533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/Ntv6kzwoZ/fDb4sxMnLUGeMVHcAdto+Ru6+UJE25s=;
 b=af5XinU/yvZxuHnwJZvKm+M4oPdhLXJrq955Sc6EL6/XnOIHyOWzY/m09egr/GizvFv4B5
 RO29GXArWVwWEXEjXYSkYy0bq1YSXP3mPW8e6Omr8eSdEKGBl1/yiNhJ/jj43EAc7es9Cr
 cOrLxQVEKOpGNeCP1guXdLFHr6SjpqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729540533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/Ntv6kzwoZ/fDb4sxMnLUGeMVHcAdto+Ru6+UJE25s=;
 b=NCeLe0WaiaTAo1968fUJPC0UhjGLt31wcwlVALYUS0QFX2ISuzUZctUYgPhuvnZz6quowM
 Mn4MzW77oGePufAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="af5XinU/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NCeLe0Wa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729540533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/Ntv6kzwoZ/fDb4sxMnLUGeMVHcAdto+Ru6+UJE25s=;
 b=af5XinU/yvZxuHnwJZvKm+M4oPdhLXJrq955Sc6EL6/XnOIHyOWzY/m09egr/GizvFv4B5
 RO29GXArWVwWEXEjXYSkYy0bq1YSXP3mPW8e6Omr8eSdEKGBl1/yiNhJ/jj43EAc7es9Cr
 cOrLxQVEKOpGNeCP1guXdLFHr6SjpqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729540533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/Ntv6kzwoZ/fDb4sxMnLUGeMVHcAdto+Ru6+UJE25s=;
 b=NCeLe0WaiaTAo1968fUJPC0UhjGLt31wcwlVALYUS0QFX2ISuzUZctUYgPhuvnZz6quowM
 Mn4MzW77oGePufAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C909F139E0;
 Mon, 21 Oct 2024 19:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EZqiL7SxFmczOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 21 Oct 2024 19:55:32 +0000
Date: Mon, 21 Oct 2024 21:55:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20241021195521.GA493656@pevik>
References: <20240530144406.7626-1-akumar@suse.de>
 <20240530144846.10915-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240530144846.10915-1-akumar@suse.de>
X-Rspamd-Queue-Id: 685AA21C9E
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] flock: Add test for verifying EINTR errno
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

Hi Avinesh, Yang Xu,

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
...
> --- /dev/null
> +++ b/testcases/kernel/syscalls/flock/flock07.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + * Copyright (c) 2024 Linux Test Project
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that flock(2) fails with errno EINTR when waiting to acquire a lock,
> + * and the call is interrupted by a signal.

Avinesh, you mentioned at Yang Xu's v1 [1] that EINTR test is getting timed out
randomly. I also experienced timeouts on aarch64 and ppc64le. v1 had 2 tests
(EINTR and EWOULDBLOCK), you here posted only EINTR. I would expect you would
put here only the other one - EWOULDBLOCK. Or am I missing something?

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/1934768.7Z3S40VBb9@localhost/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
