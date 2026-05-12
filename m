Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB19FCD4F24
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 16:45:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5875D3D787F
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 18:45:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 200323D0F2F
 for <ltp@lists.linux.it>; Tue, 12 May 2026 18:45:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AC337600424
 for <ltp@lists.linux.it>; Tue, 12 May 2026 18:45:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24984761DB;
 Tue, 12 May 2026 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778604338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udEaLKU9gX/aXz7R6jFbsKc/O8yVvTYaydO2DKNOOlA=;
 b=ksc7HVZt9UsmKj30VRF5iGu1igdM5il5ltVPbYAITHG2Vu+XRi7IC7FNY50UlwNwXzC+qQ
 wO9ytF3yOmXfhukDag9rRt5nQqoQw5zpScWpREA42l7Wt72Gdi8kAuYPVuBEthxemdwWqv
 +k6TihHPv7FQSYznd2lrtKz0btSpWK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778604338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udEaLKU9gX/aXz7R6jFbsKc/O8yVvTYaydO2DKNOOlA=;
 b=nrLmbVBxVOb322JF+G+5ji9xq1Aae3PgJawGaDeHewD5d9ub1dliBq2i/akDZeXJPcmWc2
 m3AHLlsNsruWG5AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778604338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udEaLKU9gX/aXz7R6jFbsKc/O8yVvTYaydO2DKNOOlA=;
 b=ksc7HVZt9UsmKj30VRF5iGu1igdM5il5ltVPbYAITHG2Vu+XRi7IC7FNY50UlwNwXzC+qQ
 wO9ytF3yOmXfhukDag9rRt5nQqoQw5zpScWpREA42l7Wt72Gdi8kAuYPVuBEthxemdwWqv
 +k6TihHPv7FQSYznd2lrtKz0btSpWK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778604338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udEaLKU9gX/aXz7R6jFbsKc/O8yVvTYaydO2DKNOOlA=;
 b=nrLmbVBxVOb322JF+G+5ji9xq1Aae3PgJawGaDeHewD5d9ub1dliBq2i/akDZeXJPcmWc2
 m3AHLlsNsruWG5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3662593AD;
 Tue, 12 May 2026 16:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xW6uNTFZA2phHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 May 2026 16:45:37 +0000
Date: Tue, 12 May 2026 18:45:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <li.wang@linux.dev>
Message-ID: <20260512164531.GB38597@pevik>
References: <20260507094643.47079-1-li.wang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260507094643.47079-1-li.wang@linux.dev>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima: rewrite ima_mmap auxiliary with
 TST_NO_DEFAULT_MAIN
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

Hi Li, all,

> Commit 7276e7c154 ("ima_violations.sh: ima_mmap.c: Replace sleep with
> checkpoints") called tst_reinit() inside the run() callback of a
> struct tst_test based binary. This is incorrect because the test
> framework has already initialized the IPC during setup, and calling
> tst_reinit() re-maps the shared memory to the parent shell's IPC
> region, corrupting the C binary's own test infrastructure.

> Fix this by converting ima_mmap to a TST_NO_DEFAULT_MAIN helper
> binary. In this mode there is no prior framework initialization, so
> tst_reinit() correctly attaches to the parent shell test's shared
> memory for checkpoint communication, following the same pattern used
> by other LTP helper binaries (e.g. execvp01_child).

> Fixes: 7276e7c154 ("ima_violations.sh: ima_mmap.c: Replace sleep with checkpoints")

Li, thanks for fixing the problem I introduced. It's nice to get from vacation
and see the work has been done :).

And using TST_NO_DEFAULT_MAIN is indeed the best way for these simple helpers.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
