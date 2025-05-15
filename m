Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9133C2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 13:17:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 627D93CC4C6
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 15:16:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8E1C3C1D15
 for <ltp@lists.linux.it>; Thu, 15 May 2025 15:16:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D706200DA2
 for <ltp@lists.linux.it>; Thu, 15 May 2025 15:16:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D19631F74D;
 Thu, 15 May 2025 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747315000;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ANQ1iyXyZZUqDTYjMOC2Gz9IVrR8s9gNTsYLqQ5k/g=;
 b=UcGZOSV2lgdKwb6LccHa0lpXvXfLHfdjybtlsmuBvVFkU0G1yN/EiYYfZ41U5pGUc5p0jz
 HMsbEsUe1yIUR4hu8cqF8/9e5tw7F1Rjse3Eki1J5wArjayWCQwrfzGA5ZkKzGXuTu0LHZ
 0n/EOzigA/oRgfF8QCV8jijEkGxioRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747315000;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ANQ1iyXyZZUqDTYjMOC2Gz9IVrR8s9gNTsYLqQ5k/g=;
 b=lCCiFINB+XFG/vndYArA15Uzj+4/IQFB6C1XOwcL+18WJ53dXj3V0f566l3VdgphPWakIz
 zMarrwmCGoKgJ2Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747314999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ANQ1iyXyZZUqDTYjMOC2Gz9IVrR8s9gNTsYLqQ5k/g=;
 b=bFL4IxSWGLn+k98iC0Gx/r5YiE4NQ11aM893TVefKvEbxVNI6usmuY6GXPUUVbrEvBbE95
 Lgk1ydD6aGCEGZROErd5KE4DhQFf+oiMbxU96UZgv4EeX3mOkwJNMOWZdvyzwUe7gJx35V
 fOPFmx/GB4UsyixA4hen7Gb5on6HCuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747314999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ANQ1iyXyZZUqDTYjMOC2Gz9IVrR8s9gNTsYLqQ5k/g=;
 b=48wjOj0g0wlIY2aY7QCKXZEprHmFG7RtWxeAkmT55POwnNWpWSCmciJ5LDXyxlqNmA8bc/
 dOqTVm+Cx5jtb3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8049139D0;
 Thu, 15 May 2025 13:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h4m+KzfpJWhWGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 May 2025 13:16:39 +0000
Date: Thu, 15 May 2025 15:16:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250515131634.GA493261@pevik>
References: <20250515015855.68510-1-liwang@redhat.com>
 <20250515015855.68510-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250515015855.68510-3-liwang@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] lib: moves test infrastructure states into
 a shared context structure
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

Hi Li,

> This patch introduces a new struct context to consolidate various
> runtime state variables previously maintained as global variables
> in tst_test.c. The goal is to support better state sharing between
> parent and child processes particularly in scenarios that involve
> checkpointing or fork/exec patterns.

> To achieve this, a new struct ipc_region is defined, which encapsulates
> three components: a magic field for validation, a context structure for
> runtime metadata, and a results structure for test result counters.
> Optionally, a futex array is appended for test checkpoint synchronization.

> Test library IPC region (only one page size):

>         +----------------------+
>         |   Magic Number       |
>         +----------------------+
>         |   struct context     |
>         +----------------------+
>         |   struct results     |
>         +----------------------+
>         |   futexes[], or N/A  |
>         +----------------------+

> The shared memory region is allocated with a single page using mmap()
> and is zero-initialized with memset() to ensure a clean initial state.

> The patch refactors setup_ipc() and tst_reinit() to map this shared
> region and properly initialize internal pointers to the `context`,
> `results`, and `futexes` regions.

> Overall, this refactor reduces global state pollution, centralizes the
> runtime state management, and enables safe and efficient state sharing
> across test lifecycle phases. It also sets the foundation for future
> improvements such as multi-threaded test coordination or enhanced IPC
> mechanisms.

Nice work, hopefully I haven't overlooked anything.
Of course not for the release (merged after).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
