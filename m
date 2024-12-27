Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A37E7718F
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 10:26:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCA793EC076
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 11:26:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B37E3E6E82
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 11:25:51 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 69ACF1A0107D
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 11:25:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0088336A6;
 Fri, 27 Dec 2024 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735295150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SET0yv8F2g8ju+Jh9RGCN2oKB0CipE9yHSh1Xfrbt5E=;
 b=wDzxbXaxuxGBapgQSGik0t8GpB59oIYTvmKmYaafXPq1Te/kP3nTb64rwSJqsJudQW5yq7
 ZIoGK+mwVKI+FE6AgfJcTvFQkk3Jet/Ak1WRYaRHQzyWZA+vnbNRZ2BqQQlk/Z09r0FwE0
 H6AO/DRCWRfOrw0+loC1QZOjtOkhXM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735295150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SET0yv8F2g8ju+Jh9RGCN2oKB0CipE9yHSh1Xfrbt5E=;
 b=TDx5KhcjVVXO/Ib7JSQPHeB1G5XpdRCu50VFywTkmmwynDBbGMFP/J5WgT1Pnv2fAhyjNi
 c70nrpsmaAtq+OAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CogYajrY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NBZ7P616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735295149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SET0yv8F2g8ju+Jh9RGCN2oKB0CipE9yHSh1Xfrbt5E=;
 b=CogYajrY4JVEjktzdUogxkCROefM9X6YJXvCOSm5a7oyS8n3EA6O6QZeztryZjhJB5kdw6
 faGrxxg4x1qxcmOvCO2qLaXWsDKcS0C1sMsAd43Y4cTtJWa4IU2sQ1SdcVU4hW2DjoxSJh
 tJFxXGX5b1rloFXIXsouPck5FgA4NuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735295149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SET0yv8F2g8ju+Jh9RGCN2oKB0CipE9yHSh1Xfrbt5E=;
 b=NBZ7P6163AQM/ZluXRLEL1Q62hJoNCXqMIlpwcQnPCEla6L3R9wGYHOeciB4u4/YAUPMMF
 wZ/g1fXDJZc7c0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A55EE13A30;
 Fri, 27 Dec 2024 10:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tdG5Ja2AbmeVUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 10:25:49 +0000
Date: Fri, 27 Dec 2024 11:25:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241227102540.GA317565@pevik>
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-4-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241218184518.16190-4-chrubis@suse.cz>
X-Rspamd-Queue-Id: D0088336A6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/13] lib: Add tst_mapping_in_range()
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

> This moves the range_is_mapped() function from
> testcases/kernel/mem/lib/mem.c to a top level library and renames the
> function to a better fitting name.

+1

> +/**
> + * tst_mapping_in_range()
> + *
> + * @low A lower address inside of the processe address space.
> + * @high A higher address inside of the processe address space.
nit: missing ':' causes "undefined" instead of the documentation.
Please fix that before merge.

> + *
> + * @return Returns true if there is a mapping between low and high addresses in
> + *         the process address space.
> + */
> +int tst_mapping_in_range(unsigned long low, unsigned long high);
> +
>  #endif /* TST_MEMUTILS_H__ */
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index e33f19d29..e49684ba1 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -14,6 +14,7 @@
>  #include "tst_test.h"
>  #include "tst_memutils.h"
>  #include "tst_capability.h"
> +#include "tst_safe_stdio.h"
>  #include "lapi/syscalls.h"

>  #define BLOCKSIZE (16 * 1024 * 1024)
> @@ -184,3 +185,33 @@ void tst_disable_oom_protection(pid_t pid)
>  {
>  	set_oom_score_adj(pid, 0);
>  }
> +
> +int tst_mapping_in_range(unsigned long low, unsigned long high)
> +{
> +	FILE *fp;
> +
> +	fp = SAFE_FOPEN("/proc/self/maps", "r");

nit: it might be better to have const char *file, const int lineno params
and have TST_MAPPING_IN_RANGE(). But I'm OK to keep it this way.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
