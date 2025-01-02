Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2E0E77188
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 14:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 008B13E4C0A
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 15:59:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CBB73E4C0A
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 15:59:06 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 67B071A010ED
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 15:59:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E72C71F38F;
 Thu,  2 Jan 2025 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735829945;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqH/yQH3PFATARzAu3WfRgVHNuXTV+vBfuOXQlRKoyk=;
 b=oMOU7fL3zu1YlVrFa1feKWWUnchZ5s4vACLFMx8UzfB6NCkuiKZQNitrE2EgcOu1TiFMnH
 8YsfOpp+fxdicCYZJx+qBNSTmvPrVW0mdzMuUhPl7ms0hOw5gxjYnE1PMnokVidSHJsitn
 7dkEJr24eklhc9tkW8M84TYd+QenxqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735829945;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqH/yQH3PFATARzAu3WfRgVHNuXTV+vBfuOXQlRKoyk=;
 b=NiiQZ6UaHtEG0rVxLS6TYnVPvdX92XwKZb3nnyhhwVZgoTtRNbBr3D2OX7XCZQ+i74iwcv
 XTZu+I3da7m9gnAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735829944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqH/yQH3PFATARzAu3WfRgVHNuXTV+vBfuOXQlRKoyk=;
 b=qRI+PT7AvsXOhdhlaETkha76WqpPQmwxBCzq05BXTzu6cOB0/sz07L5HwemS3u2wS+6x3C
 H3VWA2A0PDTdGZKABpGTcimixoUbSEghOkibnL0LmLh9R1KDw4xRoWHtLIZmM4xK5hOLy0
 SEAfgNIHa8GbySAHTeybSpERuUQPzvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735829944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqH/yQH3PFATARzAu3WfRgVHNuXTV+vBfuOXQlRKoyk=;
 b=g3DJJogAcqCF8HDZ/+IYqw2sd1oEMH4Z1unCjD1hop63PSJTN0uPrE1pw07T+NoKsWAcUs
 2F2ZNDikCSfeBoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C148313418;
 Thu,  2 Jan 2025 14:59:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ElSmLLipdmd+HAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Jan 2025 14:59:04 +0000
Date: Thu, 2 Jan 2025 15:59:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250102145903.GE94207@pevik>
References: <20241126085808.14616-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241126085808.14616-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] process_madvise01: running the test in mem_cg
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

Hi Li,

> The MADV_PAGEOUT behavior in the kernel is advisory and may skip
> swapping if the system has sufficient free RAM, even when the
> advice is explicitly requested. This causes sporadic false positives
> in our CI, particularly on systems with large amounts of RAM:

>   process_madvise01.c:38: TINFO: Allocate memory: 1048576 bytes
>   process_madvise01.c:99: TINFO: Reclaim memory using MADV_PAGEOUT
>   process_madvise01.c:62: TFAIL: Expect: Most of the memory has been swapped out: 0kB out of 1024kB

> To address this, the patch confines the test to a memory cgroup
> with configured limits for memory.max and memory.swap.max, improving
> control over memory and swap usage. This reduces the likelihood of
> false positives caused by system-wide memory conditions.

Out of curiosity, on how many RAM does it fail? And is it arch specific?

...
> +++ b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
> @@ -23,7 +23,9 @@
>  #include "lapi/syscalls.h"
>  #include "process_madvise.h"

> -#define MEM_CHILD	(1 * TST_MB)
> +#define MEM_LIMIT   (100 * TST_MB)
> +#define MEMSW_LIMIT (200 * TST_MB)
> +#define MEM_CHILD   (1   * TST_MB)
...
> @@ -123,7 +131,9 @@ static struct tst_test test = {
>  	.min_kver = "5.10",
>  	.needs_checkpoints = 1,
>  	.needs_root = 1,
> -	.min_swap_avail = MEM_CHILD / TST_MB,
> +	.min_mem_avail = 2 * MEM_LIMIT / TST_MB,
Requiring 200 MB for test looks LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	.min_swap_avail = 2 * MEM_CHILD / TST_MB,
> +	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
