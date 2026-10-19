Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AF3CCF2DB
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12E893EA65E
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 15:13:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C2E83E61E5
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 15:13:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F6931A0071B
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 15:13:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B18D721C3B;
 Mon, 19 Oct 2026 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792415609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wneeka+qCKgG4h7GQjGd6eWsjYciwdK8MVBGAQZXJLs=;
 b=Hcjn5hUZ5HSMkXQugWhIk3mLFaCNz1624yx88WZC0xBEcoGyf5QrOXl3CR6FwsuaQfOAO/
 odDdtvPpk6158LcjxhRR1gzMOhTjeqo6NbNM73nnyyHNiZcXna/i4LabsjQdDhE+Yk5ULN
 Ldq1fbdzUe3jV8sEhKEX9eynX0m1L2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792415609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wneeka+qCKgG4h7GQjGd6eWsjYciwdK8MVBGAQZXJLs=;
 b=t89xYEFy2t9qnnlBDy/8eHANN2KpSQBfnhqNlteRKJCE8tYxNgHqK9NKl/lJPzsH8PZ8sO
 LaYIGHzRvRNsJvBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792415609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wneeka+qCKgG4h7GQjGd6eWsjYciwdK8MVBGAQZXJLs=;
 b=Hcjn5hUZ5HSMkXQugWhIk3mLFaCNz1624yx88WZC0xBEcoGyf5QrOXl3CR6FwsuaQfOAO/
 odDdtvPpk6158LcjxhRR1gzMOhTjeqo6NbNM73nnyyHNiZcXna/i4LabsjQdDhE+Yk5ULN
 Ldq1fbdzUe3jV8sEhKEX9eynX0m1L2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792415609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wneeka+qCKgG4h7GQjGd6eWsjYciwdK8MVBGAQZXJLs=;
 b=t89xYEFy2t9qnnlBDy/8eHANN2KpSQBfnhqNlteRKJCE8tYxNgHqK9NKl/lJPzsH8PZ8sO
 LaYIGHzRvRNsJvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D25C134B3;
 Mon, 19 Oct 2026 13:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ibwCCHkX1mqyGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 19 Oct 2026 13:13:29 +0000
Date: Mon, 19 Oct 2026 15:13:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20261019131327.GA63027@pevik>
References: <89fe77f22e26d912865c8b8266b150ba7459bfae.1792413314.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <89fe77f22e26d912865c8b8266b150ba7459bfae.1792413314.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nextafter01: Check exact results and convert to
 new API
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

Hi Jan,

> The test can hardly fail. Block 1 accepts nextafter(1.0, 1.1) whenever
> (answer + 1.0) / 2 rounds to 1.0 as a float, which is also true when
> nextafter() returns 1.0 unchanged. Block 2 never recomputes 'check'
> and compares the stale value from block 1, which is exactly 1.0, so its
> 'check != 1.0' condition is always false and any return value passes.
> Only the x == y case in block 3 is really verified. The file header also
> names the test "scalb".

> Compare the results with the exact next doubles instead: 1.0 + 2^-52
> above and 1.0 - 2^-53 below. Both are exactly representable, so a plain
> equality test is sufficient. Rewrite the test with the new API while at
> it and fix the description.

Thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> -char *TCID = "nextafter01";
> +static struct tcase {
> +	double x;
> +	double y;
> +	double exp;
> +} tcases[] = {
> +	{1.0, 1.1, 1.0 + EPSILON},
> +	{1.0, 0.9, 1.0 - EPSILON / 2},
> +	{1.0, 1.0, 1.0},
> +};

...
> +	if (ret == tc->exp) {
Hm, we still does not have TST_EXP_EQ_* variant for double.
Likely not worth of having it (not many tests comparing double).

Kind regards,
Petr

> +		tst_res(TPASS, "nextafter(%g, %g) == %.17g", tc->x, tc->y, ret);
> +	} else {
> +		tst_res(TFAIL, "nextafter(%g, %g) == %.17g, expected %.17g",
> +			tc->x, tc->y, ret, tc->exp);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
