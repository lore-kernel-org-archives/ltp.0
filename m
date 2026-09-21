Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60E0C982DE
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 08:54:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6AD23E6E6A
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 10:54:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C1D43CD5EF
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 10:54:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 661621A004D3
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 10:54:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 884B91F811;
 Mon, 21 Sep 2026 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789980853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i2CAG0ghjn28xY/jW6XZVM+YHA0SwmplqiX9GmMGVAc=;
 b=PGME9xurn+bxGEFwr4MkrmqESlPrBDXjIfEBvtmbW7LwyJQuZ3rbDrFXtV4koIoonbj30q
 W4QxPy1KeFq3Zsns/GJkxaYZZOIx7hSTWMKZ0CNxQK1s1esWaAQVlRWQG+DypqLNtE1yfy
 figczcra2/9wDsZqMMYihJauU65P/Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789980853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i2CAG0ghjn28xY/jW6XZVM+YHA0SwmplqiX9GmMGVAc=;
 b=Fn/FIh/Hxc4rAZZsSlAIn7HoZ6k+uoVaMi7Ignalx1W3rcS+q7x/IRfYpP3ZQD/Zkruvo7
 h/z4JmTF5rsz54DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789980849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i2CAG0ghjn28xY/jW6XZVM+YHA0SwmplqiX9GmMGVAc=;
 b=Yx/tHN5MsY3I4iHJ0HAWsV1O89x3xkZeQsDX5KXlNZiw8cHCtjEYIVaiyBlQJmKjAi9qjr
 NgNLOB9NtXuHGbuSTfGBMtrdXRH4E1ELmUZd87GztltVKobdPgvw+lZ6VCZ7WWZ0OXasE3
 ZLQd9jlkbiXc51g4cR3JwgSeDlpX6cE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789980849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i2CAG0ghjn28xY/jW6XZVM+YHA0SwmplqiX9GmMGVAc=;
 b=Ikkcf3ucMvy2z9iFsIVxlSvEe2NxO/SDcmtngBhnGjVhd2Njm/nLrOeRRIDYE8E4gSWcuS
 x1TNtFxPR5RZZcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4358B1368D;
 Mon, 21 Sep 2026 08:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nY1EOLDwsGo1UwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 21 Sep 2026 08:54:09 +0000
Date: Mon, 21 Sep 2026 10:54:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260921085403.GA2052539@pevik>
References: <20260918194316.109853-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918194316.109853-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] coredump01: Skip pipe core_pattern under SELinux
 enforcing
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

thanks for the fix, merged.

@Jan @Li @Michael FYI

Kind regards,
Petr

> SELinux in enforcing mode silently blocks the kernel's usermode-helper
> spawn for the piped core_pattern, so the helper never runs and the
> test reports FAIL.

> coredump01.c:126: TINFO: Testing pipe core_pattern
> coredump01.c:100: TFAIL: coredump01_helper did not report any core dump

> Skip with TCONF instead of failing.

> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  testcases/kernel/coredump/coredump01.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

> diff --git a/testcases/kernel/coredump/coredump01.c b/testcases/kernel/coredump/coredump01.c
> index c4fb92e4dcb0..15aaf8c56143 100644
> --- a/testcases/kernel/coredump/coredump01.c
> +++ b/testcases/kernel/coredump/coredump01.c
> @@ -31,12 +31,14 @@

>  #include "coredump_common.h"
>  #include "tst_kconfig.h"
> +#include "tst_security.h"

>  #define HELPER "coredump01_helper"
>  #define HELPER_TIMEOUT 10

>  static char helper_path[PATH_MAX];
>  static int static_usermodehelper;
> +static int selinux_enforcing;

>  /*
>   * e_ident[] and e_type live at the same file offset in ELF32 and ELF64,
> @@ -89,6 +91,11 @@ static void verify_pipe_pattern(void)
>  		return;
>  	}

> +	if (selinux_enforcing) {
> +		tst_res(TCONF, "SELinux is enforcing, skipping pipe core_pattern");
> +		return;
> +	}
> +
>  	set_pattern("|%s %%e %%p %%s %s/res.%%p", helper_path, cwd);

>  	pid = crash_child();
> @@ -137,6 +144,8 @@ static void setup(void)
>  	tst_kconfig_read(&kconfig, 1);
>  	static_usermodehelper = (kconfig.choice == 'y');

> +	selinux_enforcing = tst_selinux_enforcing();
> +
>  	if (tst_get_path(HELPER, path, sizeof(path)))
>  		tst_brk(TCONF, "'%s' not found in $PATH", HELPER);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
