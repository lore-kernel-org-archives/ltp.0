Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A803BC47DB7
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 19:46:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D5E03CE274
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 20:45:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B1113C81D8
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:45:44 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4770D6008C9
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:45:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A551C1FD40;
 Sun, 21 Jan 2024 19:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705866343;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZpL90aNR5ziGaLwYcNHE6LtNAsGDFmkTz4Xrz6zUx0=;
 b=JzHwIpFxoB0JAQL5rbMcrMAa614tnBhk4QBM5ZsBS3lCdtBwSDbmz8hDiiQdoxzoJ9wh8h
 ST40vnyoIESvuZMHp70DFvKthjs6gPq2UuPTjb+IPW9tuRIbbDDApA/PzEBUmb8n8vivEX
 4hO+GbQ5Y0goRQkr8XpZMH+pbZbFgmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705866343;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZpL90aNR5ziGaLwYcNHE6LtNAsGDFmkTz4Xrz6zUx0=;
 b=Mf2Gv1P2Hr3STObSSaKIMUYYQLDIXPCpo8aEFn6dSAMU4aSrkDtfpSskI0XiJxuD9MhOlo
 b9/+wIyZ3gefIpAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705866343;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZpL90aNR5ziGaLwYcNHE6LtNAsGDFmkTz4Xrz6zUx0=;
 b=JzHwIpFxoB0JAQL5rbMcrMAa614tnBhk4QBM5ZsBS3lCdtBwSDbmz8hDiiQdoxzoJ9wh8h
 ST40vnyoIESvuZMHp70DFvKthjs6gPq2UuPTjb+IPW9tuRIbbDDApA/PzEBUmb8n8vivEX
 4hO+GbQ5Y0goRQkr8XpZMH+pbZbFgmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705866343;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZpL90aNR5ziGaLwYcNHE6LtNAsGDFmkTz4Xrz6zUx0=;
 b=Mf2Gv1P2Hr3STObSSaKIMUYYQLDIXPCpo8aEFn6dSAMU4aSrkDtfpSskI0XiJxuD9MhOlo
 b9/+wIyZ3gefIpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A789136F5;
 Sun, 21 Jan 2024 19:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j5M7Fmd0rWVALAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 21 Jan 2024 19:45:43 +0000
Date: Sun, 21 Jan 2024 20:45:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Xiao Yang <yangx.jy@fujitsu.com>
Message-ID: <20240121194541.GD51882@pevik>
References: <20240121122959.1386-1-yangx.jy@fujitsu.com>
 <20240121122959.1386-2-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240121122959.1386-2-yangx.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] syscalls/preadv: Make make check happy
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

Hi Xiao Yang,

> Also add LTP Copyright.
+1

> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/preadv/preadv.h   | 21 ++++++---------------
>  testcases/kernel/syscalls/preadv/preadv01.c | 13 +++++++------
>  testcases/kernel/syscalls/preadv/preadv02.c |  7 ++++---
>  testcases/kernel/syscalls/preadv/preadv03.c |  1 +
>  4 files changed, 18 insertions(+), 24 deletions(-)

> diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
> index 73466a9aa..bfe7e7223 100644
> --- a/testcases/kernel/syscalls/preadv/preadv.h
> +++ b/testcases/kernel/syscalls/preadv/preadv.h
> @@ -1,18 +1,9 @@
> -/*
> -* Copyright (c) 2015 Fujitsu Ltd.
> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -*
> -* This program is free software; you can redistribute it and/or modify it
> -* under the terms of version 2 of the GNU General Public License as
> -* published by the Free Software Foundation.

Xiao Yang, you are the author of this. Could you please relicense to GPL v2+
(GPL-2.0-or-later) and state that on the commit message?
Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
