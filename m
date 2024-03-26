Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A23CD11DF
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 10:25:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7CD73CE200
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 11:25:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97BE53CBA62
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 11:25:13 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DB9811402F91
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 11:25:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEFC237A3D;
 Tue, 26 Mar 2024 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711448711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wIn2HGM/vQ7bXG3Zyng0oktP0m4d6LRjLnNP3oRPRHM=;
 b=vyanVVjgBbpJGkHcU+2fItp+ySfKfQEMGaQ+BqkcSwcmHhteGo9SE9kp3HgGVhObarfRcA
 lf40aK7dyUOUxjXDPaLjazV9WJvQzHHw8oOHpitBhVEpfsN6y9mz/s3E3PW0Vm7bLQidAq
 9GCZZa40PTfRiSaLOzFTCiADfy6d8E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711448711;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wIn2HGM/vQ7bXG3Zyng0oktP0m4d6LRjLnNP3oRPRHM=;
 b=19P4wjuoOiIh3Z91om6SKviaT4jnRICc/7xx8gdlLLD4fBYVdg8ISnJhUp9pRHFJPgvtdV
 LQHnEotyUfMahmBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711448711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wIn2HGM/vQ7bXG3Zyng0oktP0m4d6LRjLnNP3oRPRHM=;
 b=vyanVVjgBbpJGkHcU+2fItp+ySfKfQEMGaQ+BqkcSwcmHhteGo9SE9kp3HgGVhObarfRcA
 lf40aK7dyUOUxjXDPaLjazV9WJvQzHHw8oOHpitBhVEpfsN6y9mz/s3E3PW0Vm7bLQidAq
 9GCZZa40PTfRiSaLOzFTCiADfy6d8E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711448711;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wIn2HGM/vQ7bXG3Zyng0oktP0m4d6LRjLnNP3oRPRHM=;
 b=19P4wjuoOiIh3Z91om6SKviaT4jnRICc/7xx8gdlLLD4fBYVdg8ISnJhUp9pRHFJPgvtdV
 LQHnEotyUfMahmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0314138A1;
 Tue, 26 Mar 2024 10:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I+r6KYeiAmZvfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 Mar 2024 10:25:11 +0000
Date: Tue, 26 Mar 2024 11:24:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZgKiUH2_0o0diAH0@yuki>
References: <20240320102204.475230-1-pvorel@suse.cz>
 <20240320102204.475230-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240320102204.475230-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: Merge security related sources
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
Cc: Mete Durlu <meted@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Merge FIPS and lockdown related library sources to new tst_security.[ch]
> file to shorten number of the files in the library. More security
> related code will be added in next commit.

Sound good.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v1->v2:
> * New commit: lib: Merge security related sources
> 
> I'll send more cleanup in a different patchset.
> 
> Kind regards,
> Petr
> 
>  include/tst_fips.h                     | 15 ------
>  include/tst_lockdown.h                 | 11 ----
>  include/tst_security.h                 | 17 ++++++
>  include/tst_test.h                     |  4 +-
>  lib/tst_fips.c                         | 24 ---------
>  lib/{tst_lockdown.c => tst_security.c} | 73 +++++++++++++++-----------
>  6 files changed, 62 insertions(+), 82 deletions(-)
>  delete mode 100644 include/tst_fips.h
>  delete mode 100644 include/tst_lockdown.h
>  create mode 100644 include/tst_security.h
>  delete mode 100644 lib/tst_fips.c
>  rename lib/{tst_lockdown.c => tst_security.c} (86%)
> 
> diff --git a/include/tst_fips.h b/include/tst_fips.h
> deleted file mode 100644
> index 881c32391..000000000
> --- a/include/tst_fips.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
> - */
> -
> -#ifndef TST_FIPS_H__
> -#define TST_FIPS_H__
> -
> -/*
> - * Detect whether FIPS enabled
> - * @return 0: FIPS not enabled, 1: FIPS enabled
> - */
> -int tst_fips_enabled(void);
> -
> -#endif /* TST_FIPS_H__ */
> diff --git a/include/tst_lockdown.h b/include/tst_lockdown.h
> deleted file mode 100644
> index 07e90c1af..000000000
> --- a/include/tst_lockdown.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later
> - * Copyright (c) Linux Test Project, 2020-2021
> - */
> -
> -#ifndef TST_LOCKDOWN_H
> -#define TST_LOCKDOWN_H
> -
> -int tst_secureboot_enabled(void);
> -int tst_lockdown_enabled(void);
> -
> -#endif /* TST_LOCKDOWN_H */
> diff --git a/include/tst_security.h b/include/tst_security.h
> new file mode 100644
> index 000000000..438b16dbb
> --- /dev/null
> +++ b/include/tst_security.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (c) Linux Test Project, 2020-2024
> + */
> +
> +#ifndef TST_SECURITY_H__
> +#define TST_SECURITY_H__
> +
> +/*
> + * Detect whether FIPS enabled
> + * @return 0: FIPS not enabled, 1: FIPS enabled
> + */
> +int tst_fips_enabled(void);
> +
> +int tst_lockdown_enabled(void);
> +int tst_secureboot_enabled(void);
> +
> +#endif /* TST_SECURITY_H__ */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 47b5902f9..98d74d82e 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -40,8 +40,8 @@
>  #include "tst_capability.h"
>  #include "tst_hugepage.h"
>  #include "tst_assert.h"
> -#include "tst_lockdown.h"
> -#include "tst_fips.h"
> +#include "tst_security.h"
> +#include "tst_security.h"

Huh, included twice?


Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
