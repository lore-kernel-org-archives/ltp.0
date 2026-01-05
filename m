Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B83C79F9D
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 14:21:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E92AB3C2985
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 15:21:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E91BE3C262F
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:20:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7DB7C1A003D4
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:20:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A41E3374B;
 Mon,  5 Jan 2026 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767622854;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeQLR82kg36DWlmTJJF4CKOBpO6FMU3TczAmPB/JIqg=;
 b=WoZ90pS9X8j7RTNO8PeVMSv4cIerBF1CNvGZu4Hx8NLTtRqK5xMtO6yHYcyK09HzfStMex
 OjrMFJa20RysvT03eB7JsacgYP1SU6aAtBGIrQxqy5+HKIYGjNq+OuSU5ePHF5ZzplUGXM
 h0SZ0Z4TpmCWtTB9ykMBT+x1hjivMBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767622854;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeQLR82kg36DWlmTJJF4CKOBpO6FMU3TczAmPB/JIqg=;
 b=6Xo64zJvJZF26tRIkmInkZL9AZes7MRQYbUKJ8lfV9TFxFJEb4jBRd+ZwXsm2Q3rYchS7x
 tiow+P0KKT8as1Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WoZ90pS9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6Xo64zJv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767622854;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeQLR82kg36DWlmTJJF4CKOBpO6FMU3TczAmPB/JIqg=;
 b=WoZ90pS9X8j7RTNO8PeVMSv4cIerBF1CNvGZu4Hx8NLTtRqK5xMtO6yHYcyK09HzfStMex
 OjrMFJa20RysvT03eB7JsacgYP1SU6aAtBGIrQxqy5+HKIYGjNq+OuSU5ePHF5ZzplUGXM
 h0SZ0Z4TpmCWtTB9ykMBT+x1hjivMBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767622854;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeQLR82kg36DWlmTJJF4CKOBpO6FMU3TczAmPB/JIqg=;
 b=6Xo64zJvJZF26tRIkmInkZL9AZes7MRQYbUKJ8lfV9TFxFJEb4jBRd+ZwXsm2Q3rYchS7x
 tiow+P0KKT8as1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 191713EA63;
 Mon,  5 Jan 2026 14:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S5AtBcbIW2llBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Jan 2026 14:20:54 +0000
Date: Mon, 5 Jan 2026 15:20:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260105142048.GF654507@pevik>
References: <20251014145020.178840-1-pvorel@suse.cz>
 <20251014145020.178840-2-pvorel@suse.cz>
 <DF1BR8ITX6TZ.1MY7W2QUT0WH5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DF1BR8ITX6TZ.1MY7W2QUT0WH5@suse.com>
X-Rspamd-Queue-Id: 3A41E3374B
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Convert Shell API doc to RST
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

Hi Andrea,

> Hi!

> In general ok, but we need to keep 80 chars width of the lines.

Also literalinclude:: should be used.

But I vote to drop my patch. I'm sorry for wasting your time.

I guess as now shell loader is the newest API [1] we deprecate tst_test.sh now.
Therefore it's probably not worth to have it in new docs (if yes, we would have
to put it into a different filename).

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/developers/api_shell_tests.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
