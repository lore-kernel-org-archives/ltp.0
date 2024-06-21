Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BD5C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 13:39:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42D973D0EB6
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 15:39:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 666633D0EA4
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 15:39:17 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A06AC600C45
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 15:39:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A07281FB7C;
 Fri, 21 Jun 2024 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718977154;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gD44wGBr/dvx88THWZ7adfuC5d5YTnE+ygwzNDIdIjM=;
 b=cNeghQD8Cs0Ss7UXsbrW54BFrRLB67UYxuO0MaGDSOiAfCDShKw/OzaKi0ppzNxlDphep2
 beOCeh3XvvJULx/AQZ199fm9evBBbmXhHe/ocI0myCSp/PHVqPR8wv68aj9BKsABxjo7M4
 oBJ/RrYFFi/1Ut/osmpfrmgWwb1REfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718977154;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gD44wGBr/dvx88THWZ7adfuC5d5YTnE+ygwzNDIdIjM=;
 b=JzdTVFJLPZSJE3UYjBjZQBuNtuxsxalrKOXwJk9F38CsszAK5QJnNTr9vaXJKku/2HHYyV
 jRZv8EOtySrdZzDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718977153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gD44wGBr/dvx88THWZ7adfuC5d5YTnE+ygwzNDIdIjM=;
 b=TcN3dtWHbyr8W7hyN03RcY50APuXqv+8515eVQowaLHP3Z9c4YAVL+AjuTIS35e5oN2O/z
 5gXXiidMcNvWvqr/CemV6eeEPM15LIfOW19NIc/shN9GQxal21cISL3+g23H+++SQT67L+
 N3xFXLJ9fa61vaJtJj9ovL58MtlbqWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718977153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gD44wGBr/dvx88THWZ7adfuC5d5YTnE+ygwzNDIdIjM=;
 b=T1PhsXRKaWrqiVf2ziNK/X0KGgDi4LxeIfiB+pWTevAmaQ6VgB53WmqDiaG0SCqYGUDx/O
 uvIPF7WxVI3D/rCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CB6213AAA;
 Fri, 21 Jun 2024 13:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TSFrC4GCdWZqGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jun 2024 13:39:13 +0000
Date: Fri, 21 Jun 2024 15:39:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240621133911.GA694629@pevik>
References: <20240527222947.374475-1-pvorel@suse.cz>
 <37603272-8ea2-4828-96df-4b6381cc26ad@suse.com>
 <ZldFa-3CXXbVKmVW@yuki> <20240620053618.GD537887@pevik>
 <CAEemH2cnB0QAAz1CqZPdRWm5R8GP4sqqA9mw-owHkL1ASXTkMQ@mail.gmail.com>
 <CAEemH2dVaMfNPP2m8_nEb235=9Q5bo4H1WtQbpFgrcmyyVESfw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dVaMfNPP2m8_nEb235=9Q5bo4H1WtQbpFgrcmyyVESfw@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] lib: Add TINFO_WARN
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

> Hi All,

> I come up with a way to define simple macros for all LTP print, especially
> for TFAIL
> we could make use of the GET_MACRO to select a specific macro implementation
> based on the number of arguments provided to a variadic macro.

> Something partly like:

> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -368,4 +368,28 @@ const char *tst_errno_names(char *buf, const int
> *exp_errs, int exp_errs_cnt);
>  #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
>                 TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")

> +/*TST_RES*/
> +#define TST_RES_TINFO(MESSAGE) \
> +       tst_res(TINFO, MESSAGE);
> +
> +#define TST_RES_TWARN(MESSAGE) \
> +       tst_res(TINFO, "WARNING "MESSAGE);
> +
> +#define TST_RES_TCONF(MESSAGE) \
> +       tst_res(TCONF, MESSAGE);
> +
> +#define TST_RES_TPASS(MESSAGE) \
> +       tst_res(TPASS, MESSAGE);
> +
> +#define TST_RES_TFAIL(...) \
> +           GET_MACRO(__VA_ARGS__, TST_RES_FAIL2,
> TST_RES_FAIL1)(__VA_ARGS__)
> +
> +#define GET_MACRO(_1, _2, NAME, ...) NAME
> +
> +#define TST_RES_FAIL1(MESSAGE) \
> +           tst_res(TFAIL, MESSAGE)
> +
> +#define TST_RES_FAIL2(flag, MESSAGE) \
> +           tst_res(TFAIL | flag, MESSAGE)
> +
>  #endif /* TST_TEST_MACROS_H__ */
> diff --git a/lib/newlib_tests/tst_res_macros.c
> b/lib/newlib_tests/tst_res_macros.c
> new file mode 100644
> index 000000000..e16f3cbba
> --- /dev/null
> +++ b/lib/newlib_tests/tst_res_macros.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Li Wang <liwang@redhat.com>
> + */
> +
> +#include "tst_test.h"
> +#include "tst_res_flags.h"
> +#include "tst_test_macros.h"
> +
> +static void do_test(unsigned int i)
> +{
> +       TST_RES_TINFO("message");
> +       TST_RES_TPASS("message");
> +       TST_RES_TWARN("message");
> +       TST_RES_TFAIL("message");
> +       TST_RES_TFAIL(TERRNO, "message");
> +       TST_RES_TFAIL(TTERRNO, "message");
> +}
> +
> +static struct tst_test test = {
> +       .test_all = do_test,
> +};

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
