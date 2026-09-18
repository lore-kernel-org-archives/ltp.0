Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC90C982DA
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 15:31:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C7AA3EABB6
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 17:31:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7F3C3E759B
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:31:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 319A3600BD2
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:31:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73DD921E2D;
 Fri, 18 Sep 2026 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789745487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ggm9YDkMUgeV+0Cw7A44Tq8i0FljQzJG1HuFl6iacuQ=;
 b=yWHCG13bqhLy5naqPTE9CtP5UzgwCVeiGzketA5icd11LO9aQlkw976CKphWLOcuKfJL/E
 WmCohKyt1+OEZl52xS/CVctSo5sdashRRdBtQ5EP1cNBsV5vQs1vEdq47desJgFiwxSk2K
 Bbn5GF74khvpVWgiKrmXSu9bq6LpIZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789745487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ggm9YDkMUgeV+0Cw7A44Tq8i0FljQzJG1HuFl6iacuQ=;
 b=Clrby+nn3kZbEaSO6XAKlvTzMHDJEqZscxSnT0UL0I4ud+O1fVmtV4TWTE0J0AbmLsCIhg
 qzP9wMEY9mnV8RAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789745483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ggm9YDkMUgeV+0Cw7A44Tq8i0FljQzJG1HuFl6iacuQ=;
 b=XRV7JWrAgVxvdo46Jd4UN1nQshIjG2zEXWOV2II7X6Q27KvdOtc/pzmjm7+JmGBfI5z51r
 es73gSCS3WeII8UFwhjits0+kNMctXk4BTYxiWC1u9wzXhaO/GgcMsrP00PITUusRhJnvP
 FNG3jiu5G7ibeacK/YXsUAbagZGBbgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789745483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ggm9YDkMUgeV+0Cw7A44Tq8i0FljQzJG1HuFl6iacuQ=;
 b=JVSMYkU7C/sZmUCrgOQ9VQ92UfJMVDKp9Ci1RUpDbAh/wz+GPDndtaif+ceS1lyGMoMpjF
 A018dXyz6hL5vxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C781133CF;
 Fri, 18 Sep 2026 15:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T/uGAEtZrWqmQAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 18 Sep 2026 15:31:23 +0000
Date: Fri, 18 Sep 2026 17:31:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aq1ZVsrGqKRi9xXA@yuki.lan>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-30-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-30-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 29/36] keyctl33: Negative tests for
 KEYCTL_PKEY_*
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	if (tc->op == KEYCTL_PKEY_QUERY) {
> +		TST_EXP_FAIL(keyctl(KEYCTL_PKEY_QUERY, (unsigned long)*tc->key,
> +				    tc->arg3, (unsigned long)tc->info,
> +				    (unsigned long)query_buf),
> +			     tc->exp_errno,
> +			     "%s", tc->desc);
> +		return;
> +	}
> +
> +	memset(params, 0, sizeof(*params));
> +	params->key_id = *tc->key;
> +	params->in_len = tc->in_len;
> +	params->out_len = tc->out_in2_len;
> +
> +	if (tc->op == KEYCTL_PKEY_VERIFY) {
> +		TST_EXP_FAIL(keyctl(tc->op, (unsigned long)params,
> +				    (unsigned long)tc->info,
> +				    (unsigned long)in_buf,
> +				    (unsigned long)out_buf),
> +			     tc->exp_errno,
> +			     "%s", tc->desc);
> +	} else {
> +		TST_EXP_FAIL2(keyctl(tc->op, (unsigned long)params,
> +				     (unsigned long)tc->info,
> +				     (unsigned long)in_buf,
> +				     (unsigned long)out_buf),
> +			      tc->exp_errno,
> +			      "%s", tc->desc);
> +	}

Well I would have coded this part a bit more tidily:

	switch (tc->op) {
	case KEYCTL_PKEY_QUERY:
		verify_pkey_query(tc);
	break;
	case KEYCTL_PKEY_VERIFY:
		verify_pkey_verify(tc);
	break;
	default:
		verify_pkey(tc);
	break;
	}

And moved the code into separate functions, no functional changes, just
a bit nicer flow.


Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
