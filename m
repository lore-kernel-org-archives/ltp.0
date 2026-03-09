Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A8AF417E3
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 14:43:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89EC63DD944
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 15:43:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 413803C198F
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 15:42:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E9B3600143
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 15:42:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 455E24D230;
 Mon,  9 Mar 2026 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773067364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=58R1vN6LAocKBWEJa6wUCPqAAPOpAjwJEPGpUgu3YXE=;
 b=Biwu9W3nd4qX0/EpyOqakvF8h0RIl+YfpDjnCoHQElkvlLFgKOKjbS2EQ4bMOfO3gX72Gw
 Z8ukP0KK3WS4wTtLrdtYySdThUZCz40mnovJihrnRtCigs2xmR6vS4BIWGMQ78L8QQOKHx
 vkhlBWngzUTN/cJ8gGbgSo6Lk7t5g/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773067364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=58R1vN6LAocKBWEJa6wUCPqAAPOpAjwJEPGpUgu3YXE=;
 b=v7/YN3333Vl/2rYwJQJJJDxVRBv6pZkyqzS4yGnTB925C7aI4HCSutUmpcxuo0z4q6H9Pr
 YiYky6InOYGcbbCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MQxNVNm0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xNH+4i+s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773067363;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=58R1vN6LAocKBWEJa6wUCPqAAPOpAjwJEPGpUgu3YXE=;
 b=MQxNVNm0YsD5vzEQz4KciWGJNBsMsycQvjMqKy6KZCMkCi7VTX199oa6GVCSa4e6Uuh1Sk
 z0MF7kbf7yOophNqnoklMYAnc+u4IAAMsOOeVfVvW0MAWWbHJf8QQ6DHvXG6eiYorjqmtH
 uUilaNlZRkt/tlJ8S31/wrpSucIA05Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773067363;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=58R1vN6LAocKBWEJa6wUCPqAAPOpAjwJEPGpUgu3YXE=;
 b=xNH+4i+sd0PPidQiJyGeLXJmXXfBLYOgNIb+vao1OoLqpQlgXOBV6QsJB+4o9fcycDDT0o
 3+L/xciQvXfixuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2AF23EF54;
 Mon,  9 Mar 2026 14:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iqrlLWLcrmlfVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Mar 2026 14:42:42 +0000
Date: Mon, 9 Mar 2026 15:42:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260309144236.GA28075@pevik>
References: <20260224-agents_file-v6-1-db15c490d048@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260224-agents_file-v6-1-db15c490d048@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 455E24D230
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] agents: Add AI agent configuration for code
 reviews
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

thanks for your work. On a first look LGTM.

Acked-by: Petr Vorel <pvorel@suse.cz>

I wonder if we can somehow avoid duplicity with our Ground Rules
https://linux-test-project.readthedocs.io/en/latest/developers/ground_rules.html
Ideally text would be just in a single document.

...
> +### 6. Safe Macros
> +
> +- MUST use `SAFE_*` macros for system calls that must not fail
> +- Safe macros are defined in `include/` directory
Actually the signatures are defined there, the code mostly not, but that's minor
detail.

> +
> +### 7. Kernel Version Handling
> +
> +- MUST use `.min_kver` for kernel version gating
> +- MUST prefer runtime checks over compile-time checks
...

I guess I should send v2 for my patch and that could be updated here
https://patchwork.ozlabs.org/project/ltp/patch/20260128080121.18878-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20260128080121.18878-1-pvorel@suse.cz/

> +
> +### 13. Deprecated Features
> +
> +- MUST NOT define `[Description]` in the test description section

When we handle details like this, we may want to add rule to avoid unnecessary
tags e.g. .mount_device:

metadata/metaparse.c

static struct implies {
	const char *flag;
	const char **implies;
} implies[] = {
	{"mount_device", (const char *[]) {"format_device", "needs_device",
		"needs_tmpdir", NULL}},
	{"format_device", (const char *[]) {"needs_device", "needs_tmpdir",
		NULL}},
	{"all_filesystems", (const char *[]) {"needs_device", "needs_tmpdir",
		NULL}},
	{"needs_device", (const char *[]) {"needs_tmpdir", NULL}},
	{"needs_checkpoints", (const char *[]) {"needs_tmpdir", NULL}},
	{"resource_files", (const char *[]) {"needs_tmpdir", NULL}},
	{NULL, (const char *[]) {NULL}}
};

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
