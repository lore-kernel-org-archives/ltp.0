Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D06F8FA80
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 14:27:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 656273E53CD
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 16:27:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BD183E2D90
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 16:26:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C53AA1400C7E
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 16:26:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D5C96A8EF;
 Tue, 21 Apr 2026 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776781611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=76GuZhm4wrkNnr2HFJQe4tzT9zsHzxApG0mirLpWVfs=;
 b=OrAhVq/dt7RKGVhBIrlaO5Q//CSU2nzmsmzWuoPj3Oj/+j/efz7O5oGxOCy6sf67g8xkma
 X2iIn/9YSabbR93TNNMwIR9aeVYrDCLdM7ixs6Vt8MUgFBPsQG2F82pbHm5lFjfz/6ri+/
 V3JUtxwo85dXkMxVye9u9f7PtLp/td0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776781611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=76GuZhm4wrkNnr2HFJQe4tzT9zsHzxApG0mirLpWVfs=;
 b=RIZnCy3zKjJEc2GyO3POJEr04rv54u7zpoPw+hELbBcisk7V4jsBecX9zQ8AM52dleh3Zc
 nkMEkcuuCj4Ew7AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776781610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=76GuZhm4wrkNnr2HFJQe4tzT9zsHzxApG0mirLpWVfs=;
 b=dbX+v0CVo6VphQySBLwxKoH9oZYqXg7XVqGgFUDvZMraFW//AKJMAijNZnfIs84GQcieCR
 t6EN7wswsyCemLXm2LEatffRjuiWs2gAGpxOVBd/Y6QFGM4reg/z2b3Sn8Xcc0QR3y+o9/
 EhOigIqBHyQNTCN1Rl8bClZzx+ChKzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776781610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=76GuZhm4wrkNnr2HFJQe4tzT9zsHzxApG0mirLpWVfs=;
 b=C3q1UMLUaWQZ9mC0KOh9JMWIuzIZR99UftyoIeCh/6BRpmxZP7EVAGl/poQ6utLmo9gg9W
 GM5c5r2JVV8xA7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DEBA593AF;
 Tue, 21 Apr 2026 14:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vIn4CSqJ52luSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 21 Apr 2026 14:26:50 +0000
Date: Tue, 21 Apr 2026 16:27:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <wangli.ahau@gmail.com>
Message-ID: <aeeJOUaVAXqkqRfI@yuki.lan>
References: <20260421130706.14254-1-wangli.ahau@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260421130706.14254-1-wangli.ahau@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; TAGGED_RCPT(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_kconfig: rename runtime_check to
 config_runtime_map
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
> Rename struct 'runtime_check' to 'config_runtime_map' and
> array 'runtime_checks' to 'config_runtime_maps' to better
> reflect their purpose of mapping kconfig options to runtime
> checks.
> 
> Rename function runtime_check to kconfig_runtime_check for
> consistency with kconfig_module_check().
> 
> Follow-up: d7d6512e89 ("lib: tst_kconfig: Add module presence checks")
> Signed-off-by: Li Wang <wangli.ahau@gmail.com>
> ---
> 
> Notes:
>     Hi Cyril,
>     
>         It seems you forgot to add this modification at the top of
>         the patchset. So I made it for the name consistency.

I was going to send the patch to the ML but you were faster...

Anyways:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
