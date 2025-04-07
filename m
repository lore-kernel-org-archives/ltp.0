Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6D0C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:24:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7A903CAE6D
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:24:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A01EF3CA0EF
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:24:03 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E47C61A00997
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:24:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0967B1F388;
 Mon,  7 Apr 2025 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744028642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ssr2SIP10z1sGs+O0QU4UFucnbUeSBSx20x5nFeBanA=;
 b=buEa2w0akhN8VEqPd0PjAeXc2/L+DRccldsK6zWXhV1wNTABM57kRTCBAId9qmk5T7/9CR
 lLdE+PXlUgau0wGWM7Lym4mBHTbv154fksZ8zgD+2v70QKkM3PpxnzLKd6mIQKj1WX2OUX
 elFzcEb64VMOXblM1oEkUh3DeItEtdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744028642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ssr2SIP10z1sGs+O0QU4UFucnbUeSBSx20x5nFeBanA=;
 b=VFfNJbgsoHOKzI5iCxTKhgB3BNwsjxeUqfC0M+qXXA+6ybkWhybBzkz6ee7Bq2/pXxG2Jt
 K3cNmuzFfPHnSGAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744028642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ssr2SIP10z1sGs+O0QU4UFucnbUeSBSx20x5nFeBanA=;
 b=buEa2w0akhN8VEqPd0PjAeXc2/L+DRccldsK6zWXhV1wNTABM57kRTCBAId9qmk5T7/9CR
 lLdE+PXlUgau0wGWM7Lym4mBHTbv154fksZ8zgD+2v70QKkM3PpxnzLKd6mIQKj1WX2OUX
 elFzcEb64VMOXblM1oEkUh3DeItEtdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744028642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ssr2SIP10z1sGs+O0QU4UFucnbUeSBSx20x5nFeBanA=;
 b=VFfNJbgsoHOKzI5iCxTKhgB3BNwsjxeUqfC0M+qXXA+6ybkWhybBzkz6ee7Bq2/pXxG2Jt
 K3cNmuzFfPHnSGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAEB713691;
 Mon,  7 Apr 2025 12:24:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nRn7OOHD82dHfgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Apr 2025 12:24:01 +0000
Date: Mon, 7 Apr 2025 14:24:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <Z_PD_RUdYQAlewP6@yuki.lan>
References: <20250402-conversions-modify_ldt-v6-0-2e4b0e27870e@suse.com>
 <20250402-conversions-modify_ldt-v6-2-2e4b0e27870e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250402-conversions-modify_ldt-v6-2-2e4b0e27870e@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/3] syscalls/modify_ldt02: Refactor into new
 API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/modify_ldt/common.h
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines  Corp., 2001
> + *	07/2001 Ported by Wayne Boyer
> + * Copyright (c) 2025 SUSE LLC Ricardo B. Marli=E8re <rbm@suse.com>
> + */
> +
> +#ifndef COMMON_H
> +#define COMMON_H
> +
> +#include "tst_test.h"
> +#include "lapi/ldt.h"
> +
> +int create_segment(void *seg, size_t size)

This should be void now, since we are not checking the return value
anyways.

> +{
> +	struct user_desc entry =3D {
> +		.entry_number =3D 0,
> +		.base_addr =3D (unsigned long)seg,
> +		.limit =3D size,
> +		.seg_32bit =3D 1,
> +		.contents =3D 0,
> +		.read_exec_only =3D 0,
> +		.limit_in_pages =3D 0,
> +		.seg_not_present =3D 0,
> +	};
> +
> +	return SAFE_MODIFY_LDT(1, &entry, sizeof(entry));
> +}

...

> +	if (!pid) {
> +		signal(SIGSEGV, SIG_DFL);

We do not mess with signal handlers in the new test library, so this
shouldn't be needed.

> +		read_segment(0);
> +		exit(1);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +	if (WEXITSTATUS(status) !=3D 0) {
> +		tst_res(TFAIL, "Did not generate SEGV, child returned "
> +			       "unexpected status");
> +	} else {
> +		if (WIFSIGNALED(status) && (WTERMSIG(status) =3D=3D SIGSEGV))
> +			tst_res(TPASS, "generate SEGV as expected");
> +		else
> +			tst_res(TFAIL, "Did not generate SEGV");
> +	}

This should be just:

	if (WIFSIGNALED(status) && (WTERMSIG(status) =3D=3D SIGSEGV))
		tst_res(TPASS, "generate SEGV as expected");
	else
		tst_res(TFAIL, "child %s", tst_strstatus(status));

>  }
>  =

> -#endif /* if defined(__i386__) */
> +static struct tst_test test =3D {
> +	.test_all =3D run,
> +	.forks_child =3D 1,
> +};
> +
> +#else
> +TST_TEST_TCONF("Test supported only on i386");
> +#endif /* __i386__ */
> =

> -- =

> 2.49.0
> =

> =

> -- =

> Mailing list info: https://lists.linux.it/listinfo/ltp

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
