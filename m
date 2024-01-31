Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13421C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 17:22:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 686403CF91A
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 18:22:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D842C3C81D8
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 18:21:56 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A574D60B2E5
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 18:21:55 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8072622004;
 Wed, 31 Jan 2024 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706721714;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOgpCCJFfhMjKTjfDLclO6dS1xPDJk/6sn2QQxdMH74=;
 b=ICAKu7HxrsWNbUlgr2RBqubFCbbl5P0SFe/9kThzkwEUuIF0DoZrR0sH/p4mTu/jwyWpJC
 HN4SMdZv71Xfy07BkaBYgOhttpvNXwclFQdxDdx30LHj1dfxC0Hi4RS8kH2hW5NLuPWxnJ
 3MW3XlJrr0YNmyUImAehvZG2LOSZung=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706721714;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOgpCCJFfhMjKTjfDLclO6dS1xPDJk/6sn2QQxdMH74=;
 b=3Y4HQ1sEEwtQRwzNqZ4aHKxzHSMw/BfR3IeoRqMatNVqQoJTLizjSlOPeP1yq68PlN2E89
 aAY3DByKhFMg9iDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706721714;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOgpCCJFfhMjKTjfDLclO6dS1xPDJk/6sn2QQxdMH74=;
 b=ICAKu7HxrsWNbUlgr2RBqubFCbbl5P0SFe/9kThzkwEUuIF0DoZrR0sH/p4mTu/jwyWpJC
 HN4SMdZv71Xfy07BkaBYgOhttpvNXwclFQdxDdx30LHj1dfxC0Hi4RS8kH2hW5NLuPWxnJ
 3MW3XlJrr0YNmyUImAehvZG2LOSZung=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706721714;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOgpCCJFfhMjKTjfDLclO6dS1xPDJk/6sn2QQxdMH74=;
 b=3Y4HQ1sEEwtQRwzNqZ4aHKxzHSMw/BfR3IeoRqMatNVqQoJTLizjSlOPeP1yq68PlN2E89
 aAY3DByKhFMg9iDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B510132FA;
 Wed, 31 Jan 2024 17:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id KuYwFLKBumV9GAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 17:21:54 +0000
Date: Wed, 31 Jan 2024 18:21:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240131172148.GA5570@pevik>
References: <20240131135026.1562-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240131135026.1562-1-mdoucha@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.50 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[19.80%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitpid04: Convert to new API
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

> Convert waitpid() error state checks to new API, fix bugs in the original
> test and add ESRCH subtest.

Very nice cleanup.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW what were these bugs? It looks like old test uses pid O for the first ECHILD
test (not sure how it got defined to 0).

>  #include <sys/signal.h>
nit: this should be <signal.h>
warning: #warning redirecting incorrect #include <sys/signal.h> to <signal.h> [-Wcpp]

Can be fixed before merge.

>  #include <sys/types.h>
>  #include <sys/wait.h>
...
> +#include "tst_test.h"
> +
> +#define TCFMT "waipid(%d, NULL, 0x%x)"
> +#define TCFMTARGS(tc) (tc)->pid, (tc)->flags

checkpatch.pl complains:
waitpid04.c:19: ERROR: Macros with complex values should be enclosed in parentheses

I guess we can ignore this unless you see a quick fix (I guess macro which runs
tst_res() inside would be needed.

> +static struct testcase {
> +	pid_t pid;
> +	int flags;
> +	int err;
> +} testcase_list[] = {
> +	{-1, 0, ECHILD},	/* Wait for any child when none exist */
> +	{1, 0, ECHILD},		/* Wait for non-child process */
> +	{-1, -1, EINVAL},	/* Invalid flags */
> +	{INT_MIN, 0, ESRCH},	/* Wait for invalid process group */
> +};
> +
> +void run(unsigned int n)
>  {
...
> +	const struct testcase *tc = testcase_list + n;

> -		if (FORK_OR_VFORK() == 0)
> -			exit(0);
> +	TEST(waitpid(tc->pid, NULL, tc->flags));
How about using TST_EXP_FAIL2() to avoid code below? It would also help to avoid
macros, right?  Or you want to explicitly state what failed?

Kind regards,
Petr

> +	if (TST_RET == -1 && TST_ERR == tc->err) {
> +		tst_res(TPASS | TTERRNO, TCFMT " failed as expected",
> +			TCFMTARGS(tc));
> +		return;
> +	}

> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, TCFMT ": expected error %s, got",
> +			TCFMTARGS(tc), tst_strerrno(tc->err));
> +		return;
>  	}

> +	if (TST_RET < 0) {
> +		tst_res(TFAIL | TTERRNO, TCFMT ": invalid return value %ld",
> +			TCFMTARGS(tc), TST_RET);
> +		return;
> +	}

> +	tst_res(TFAIL, TCFMT " returned unexpected PID %ld", TCFMTARGS(tc),
> +		TST_RET);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
