Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7734EC369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 11:39:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB2AD3CB7C1
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 13:39:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87F283CB6F0
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 13:39:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 05F1014002C1
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 13:39:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 360DC21162;
 Fri, 25 Apr 2025 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745581179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7tZn1go+sBhVlZOdvGvpuiWd6H+627z5GTp7gyIH5Xs=;
 b=JnaAlkhO4yBjhcuI1fMIJhxnI1fY4PRz+fUCVGAwUmwvRpwAzTMzBWO9NfAczHE2EXdQKd
 jiDQ1XrjwQ74+KwcHvLWLtrEHP9kCAHcxrt9pfEQkhOCK4wrAJ5v6oQMpdt5VrIScwcnGB
 0Tv1/dGcAiQr1HOsBl42Toed0ZcRHAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745581179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7tZn1go+sBhVlZOdvGvpuiWd6H+627z5GTp7gyIH5Xs=;
 b=kiMkuPhT3vZXtlzOCwcHgeoMWOIVx+8ANyHc+YdIgx6h21iAgRkPer/LYuZUqT+QOudGnZ
 gRTEWMwKub2470Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JnaAlkhO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kiMkuPhT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745581179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7tZn1go+sBhVlZOdvGvpuiWd6H+627z5GTp7gyIH5Xs=;
 b=JnaAlkhO4yBjhcuI1fMIJhxnI1fY4PRz+fUCVGAwUmwvRpwAzTMzBWO9NfAczHE2EXdQKd
 jiDQ1XrjwQ74+KwcHvLWLtrEHP9kCAHcxrt9pfEQkhOCK4wrAJ5v6oQMpdt5VrIScwcnGB
 0Tv1/dGcAiQr1HOsBl42Toed0ZcRHAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745581179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7tZn1go+sBhVlZOdvGvpuiWd6H+627z5GTp7gyIH5Xs=;
 b=kiMkuPhT3vZXtlzOCwcHgeoMWOIVx+8ANyHc+YdIgx6h21iAgRkPer/LYuZUqT+QOudGnZ
 gRTEWMwKub2470Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 130081388F;
 Fri, 25 Apr 2025 11:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HpmKA3t0C2glNgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 25 Apr 2025 11:39:39 +0000
Date: Fri, 25 Apr 2025 13:40:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aAt0liEAJpTHbwek@yuki.lan>
References: <20250103135626.28672-1-wegao@suse.com>
 <20250416191645.355088-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250416191645.355088-1-wegao@suse.com>
X-Rspamd-Queue-Id: 360DC21162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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
> +static void test_mmap(void)
> +{
> +	size_t alloc_size = ALLOC_SIZE;
> +	size_t page_size = getpagesize();
> +	void *alloc;
> +	pid_t child;
> +
> +	cg_child = tst_cg_group_mk(tst_cg, "child");
> +	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
> +	SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
> +
> +	alloc = SAFE_MMAP(0, alloc_size, PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
> +
> +	memset(alloc, 'A', alloc_size);
> +	for (size_t i = 0; i < alloc_size; i += page_size) {
> +		if (*(char *)(alloc + i) != 'A')
> +			tst_res(TFAIL, "memset failed");
> +	}
> +
> +	child = SAFE_FORK();
> +	if (!child) {
> +		for (;;)
> +			*(char *)malloc(page_size) = 'B';
> +	}
> +
> +	while (1) {
> +		for (size_t i = 0; i < alloc_size; i += page_size) {
> +			if (!tst_remaining_runtime())
> +				tst_brk(TBROK, "MAP_DROPPABLE did not drop memory within the timeout period.");

This should rather be tst_res(TFAIL, ...) followed by goto kill_child;

> +			if (!*(uint8_t *)(alloc + i)) {

We are casting the alloc pointer on each access, it would probably be
more reasonable to defined it as char * instead of void * and drop the
casts from the code.

> +				tst_res(TPASS, "MAP_DROPPABLE test pass.");
> +				goto kill_child;
> +			}
> +		}
> +	}
> +
> +kill_child:
> +	SAFE_KILL(child, SIGKILL);
> +	SAFE_WAITPID(child, NULL, 0);
> +	SAFE_MUNMAP(alloc, alloc_size);
> +}
> +
> +static void setup(void)
> +{
> +	void *addr = mmap(0, 1, PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
> +	if (addr == MAP_FAILED && errno == EINVAL)
> +		tst_brk(TCONF, "MAP_DROPPABLE not support");

We are missing munmap() here in the case that addr != MAP_FAILED.


Other than these minor points the rest of the code looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
