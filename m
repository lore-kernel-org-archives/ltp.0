Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114B8ECD994
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 17:48:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16F113CE418
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 18:48:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BC5B3CD504
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 18:48:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 61F7A1A00247
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 18:48:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1B015BDE9;
 Thu,  5 Feb 2026 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770313688;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KuvXTGRKRLed5PKaoTbRrCFxxpYdCaHJd1LOIZsaoM=;
 b=Qp+4pX5j/2A9wBbfO/grBfSFuzPCsxlFVathFTMXPVwAJ4EvHkmGw+eW4LJdpxOSZO1a8A
 +sWVFBTHg0ml41CXwx8P/oJuecTL4eOGSxLM40xP+kk1PxWWvaKZONejqJ7xWLgixDL5wg
 czPTs3fULeeTluCkmU8/h7jTLJU8/Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770313688;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KuvXTGRKRLed5PKaoTbRrCFxxpYdCaHJd1LOIZsaoM=;
 b=3POvDraK25YcxaqjYupo16t7GXnromxkiUGVvTGJxCY0GQLqswo0twHlgFRlt2Zf3LAOBn
 kX21ssy+JNoWn2Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770313686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KuvXTGRKRLed5PKaoTbRrCFxxpYdCaHJd1LOIZsaoM=;
 b=wOS2/Ekj2ey3Hvj4ndDbJ21hb+WTUEJVrOCuyka7VZ/Cf5q1xew0b+Rv/lr1L3ZJ3ojG5p
 vt6GY12Xc8Tc3Qx2Ws/Xm9wkuqKR4NpfuW1J/220zAjoUY1IRfvpQPTKAOa4qK58hN8n9p
 wiTPlFxuT51otIuRta5ufWyPjftF+8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770313686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KuvXTGRKRLed5PKaoTbRrCFxxpYdCaHJd1LOIZsaoM=;
 b=S3TdtQW0e2xMVoddbWxO0u3t9AYANDlSnGnw1BfMoTSCvHJToR6+41UhVTQFYyZEzO8BHS
 ezU40buSNvYWA9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 630613EA63;
 Thu,  5 Feb 2026 17:48:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QNN6FNbXhGlFHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Feb 2026 17:48:06 +0000
Date: Thu, 5 Feb 2026 18:47:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260205174756.GA338897@pevik>
References: <20260205135724.23772-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260205135724.23772-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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

Hi Cyril, Li,

Thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Few notes below.

> So far for CONFIG_*_NS.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  lib/newlib_tests/test_kconfig.c |  1 +
>  lib/tst_kconfig.c               | 35 +++++++++++++++++++++++++++++++++
>  lib/tst_ns_checks.h             | 32 ++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+)
>  create mode 100644 lib/tst_ns_checks.h

> diff --git a/lib/newlib_tests/test_kconfig.c b/lib/newlib_tests/test_kconfig.c
> index cea36b5ee..ed2c4610a 100644
> --- a/lib/newlib_tests/test_kconfig.c
> +++ b/lib/newlib_tests/test_kconfig.c
> @@ -18,6 +18,7 @@ static const char *kconfigs[] = {
>  	"CONFIG_MMU & CONFIG_EXT4_FS=m",
>  	"CONFIG_EXT4_FS=m | CONFIG_MMU",
>  	"CONFIG_DEFAULT_HOSTNAME=\"(none)\"",
> +	"CONFIG_USER_NS",
>  	NULL
>  };

> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index 9bcd57721..8d0f8ae3a 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -16,6 +16,8 @@
>  #include "tst_bool_expr.h"
>  #include "tst_safe_stdio.h"

> +#include "tst_ns_checks.h"
nit: don't we want to have tst_kconfig_checks.h which would have all configs?
Sure it can be this way, but I tend to have less files with more content.
I would be even ok with having everything in tst_kconfig.c, but understand you
don't want it.

> +
>  static int kconfig_skip_check(void)
>  {
>  	char *skipped = getenv("KCONFIG_SKIP_CHECK");
> @@ -110,6 +112,37 @@ static void close_kconfig(FILE *fp)
>  		fclose(fp);
>  }

> +static struct runtime_check {
> +	const char *config;
> +	bool (*runtime_check)(void);
> +} runtime_checks[] = {
> +	{"CONFIG_USER_NS", tst_user_ns_enabled},
> +	{"CONFIG_NET_NS", tst_net_ns_enabled},
> +	{"CONFIG_PID_NS", tst_pid_ns_enabled},
> +	{"CONFIG_MNT_NS", tst_mnt_ns_enabled},
> +	{"CONFIG_IPC_NS", tst_ipc_ns_enabled},
> +	{}
> +};
> +
> +static void runtime_check(struct tst_kconfig_var *var)
> +{
> +	size_t i;
> +
> +	for (i = 0; runtime_checks[i].config; i++) {
> +		if (strcmp(runtime_checks[i].config, var->id))
> +			continue;
> +
> +		tst_res(TDEBUG, "Running runtime check for '%s'", var->id);
This will not work since Li's change:
aa5a6fcdcd ("lib: suppress early TDEBUG output before context initialization")

@Li I'm not sure what "unless explicitly enabled" means, but I guess we cannot
simple enable it for the test library (following patch). I vote to either revert
aa5a6fcdcd or change it (effectively revert it, but keep doc and the rest of the
code).

I understand having the output in each test is not ideal:

utsname01.c:39: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)
utsname01.c:40: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)

but better more output code than no code.

+++ lib/tst_test.c
@@ -492,16 +492,12 @@ void tst_res_(const char *file, const int lineno, int ttype,
 	/*
 	 * Suppress TDEBUG output in these cases:
 	 * 1. No context available (e.g., called before IPC initialization)
-	 * 2. Called from the library process, unless explicitly enabled
-	 * 3. Debug output is not enabled (context->tdebug == 0)
+	 * 2. Debug output is not enabled (context->tdebug == 0)
 	 */
 	if (ttype == TDEBUG) {
 		if (!context)
 			return;
 
-		if (context->lib_pid == getpid())
-			return;
-
 		if (!context->tdebug)
 			return;
 	}

> +
> +		if (!runtime_checks[i].runtime_check()) {
> +			tst_res(TINFO,
> +				"%s=%c present but disabled at runtime",
> +				var->id, var->choice);
> +			var->choice = 'n';
> +		}
> +	}
> +}
> +
>  static inline int kconfig_parse_line(const char *line,
>                                       struct tst_kconfig_var *vars,
>                                       unsigned int vars_len)
> @@ -183,9 +216,11 @@ out:
>  			switch (val[0]) {
>  			case 'y':
>  				vars[i].choice = 'y';
> +				runtime_check(&vars[i]);
>  				return 1;
>  			case 'm':
>  				vars[i].choice = 'm';
> +				runtime_check(&vars[i]);
>  				return 1;
>  			}
>  		}
> diff --git a/lib/tst_ns_checks.h b/lib/tst_ns_checks.h
> new file mode 100644
> index 000000000..743d3d09d
> --- /dev/null
> +++ b/lib/tst_ns_checks.h
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
nit: please use /* */ otherwise checkpatch complains.
/* SPDX-License-Identifier: GPL-2.0-or-later */

Kind regards,
Petr

> +/*
> + * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#include <unistd.h>
> +#include <stdbool.h>
> +
> +static inline bool tst_user_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/user", F_OK) == 0;
> +}
> +
> +static inline bool tst_net_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/net", F_OK) == 0;
> +}
> +
> +static inline bool tst_pid_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/pid", F_OK) == 0;
> +}
> +
> +static inline bool tst_mnt_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/mnt", F_OK) == 0;
> +}
> +
> +static inline bool tst_ipc_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/ipc", F_OK) == 0;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
