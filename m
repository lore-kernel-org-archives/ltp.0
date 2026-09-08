Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD91C79F99
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 15:59:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C7583E94B0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 17:59:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 807F03C7449
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 17:59:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 160331A00A27
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 17:59:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7261B1F833;
 Tue,  8 Sep 2026 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788883146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ye97qGZpydKNqLtm/hxQF24WIwOXDUbun6on9QYMasM=;
 b=ZnxfiTyAvSGyfxXDwaVNzuM9zEP+ZwhjilLym5p8UK022dWSpxJf1XaRTqwxEvMQXzG8bI
 TsqV9GDlRh2AYMdjNeyIiUQV77eDSK6uZcvKn5V2LlKQipz9QKUoAgXW16rVk7rlZfeWaG
 2rSf/v+J1wO0pjzFos1tQTN8uHADdAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788883146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ye97qGZpydKNqLtm/hxQF24WIwOXDUbun6on9QYMasM=;
 b=eZOD8IRDvJANXz1m6V5BgEvvPUGWiSWTZls1AOgJnvSqzJy54AO02VQ9PyMCzO8o9qMtWp
 f8aN7lnQxj8KxYCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788883142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ye97qGZpydKNqLtm/hxQF24WIwOXDUbun6on9QYMasM=;
 b=dil4DI3oKo6f1GHod0D+QnszwFZUAgVq5MHf4qwQXGJIOwCL1fg8AmaFrM/KaRp0XU01qB
 EtN5KmyG+Ipr4g34O0LjjmnhUk2Qp4gLPTPD9D3mGI+CR08Fbl3nG6tAGaJDV8r46pcwMJ
 c0zSTNFSnah9uGqOezkZg+sp5aAOta4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788883142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ye97qGZpydKNqLtm/hxQF24WIwOXDUbun6on9QYMasM=;
 b=fZD7h19Bax/QyUh9I6Z4OzcHmaaExrJHJsBSOHdgvK515LvXqi9DywTw3zLOriz3XUkrAA
 uTpPsJs600pZVUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A15F13332;
 Tue,  8 Sep 2026 15:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dgkVEsYwoGodZAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 08 Sep 2026 15:59:02 +0000
Date: Tue, 8 Sep 2026 17:59:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqAwyxICYrC487_p@yuki.lan>
References: <20260908-coredump-v8-0-591f96004543@suse.com>
 <20260908-coredump-v8-2-591f96004543@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260908-coredump-v8-2-591f96004543@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/2] coredump02: Verify ELF structure and notes
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static const void *core_at(size_t off, size_t need)
> +{
> +	if (off > core_len || need > core_len - off)
> +		tst_brk(TFAIL, "core file truncated at %zu (need %zu, have %zu)",
> +			off, need, core_len);
> +
> +	return core_buf + off;
> +}
> +
> +static void handle_note(uint32_t type, const void *desc, size_t descsz, pid_t pid)
> +{
> +	if (type == NT_PRPSINFO && descsz >= sizeof(struct elf_prpsinfo)) {
> +		struct elf_prpsinfo info;
> +		char name[sizeof(info.pr_fname) + 1] = {0};
> +
> +		memcpy(&info, desc, sizeof(info));
> +		memcpy(name, info.pr_fname, sizeof(info.pr_fname));
> +
> +		TST_EXP_EQ_STR(name, "coredump02");

We do have TST_EXP_EQ_STRN() there is no need for the memcpy.

Also as long as the alignment is proper there is no need for the first
memcpy() either.

I would have expected that the elf headers are aligned properly and
since we loaded the whole file into aligned buffer (malloc() aligns
properly), it should be safe to just cast the desc pointer into the
strcut elf_prpsinfo *info = desc;  and acces info.pr_name directly from
the buffer.

> +		prpsinfo_seen = 1;
> +	} else if (type == NT_PRSTATUS && descsz >= sizeof(struct elf_prstatus)) {
> +		struct elf_prstatus st;
> +
> +		memcpy(&st, desc, sizeof(st));

Here as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
