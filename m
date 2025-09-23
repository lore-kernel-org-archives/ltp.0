Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC075CAC5B0
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 11:08:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1094A3CDEA2
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 13:07:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E7983CDD33
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:07:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 01BF510008F8
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:07:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C76521FA6;
 Tue, 23 Sep 2025 11:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758625662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ugd8T/HUP9+O29ivHS1us861w5SHAtLuLeWEiqbEiY=;
 b=XcEjNDEJXlyoz+b8JXOjdUIcl3tpvUL9KLFRG3yLbPIxI6f2Th78sdqo11ObArPsr2Sh4B
 fanUO4Iix71Kj2PsC0GCFiIW4C8C6bzWpPqdtArNNBI85taMheybpmjx509Om7fYlwwTbi
 Bx3GHNxbRkFiPenI4s1U4Vk0EkWCDyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758625662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ugd8T/HUP9+O29ivHS1us861w5SHAtLuLeWEiqbEiY=;
 b=SjNxKVGJEMamNKq10I8u5k0yYoRNzpfSMG9A0rE05FaF/y0J6pDTEpzSY3s5QokERaCBzb
 Wb3CWvyMSRc2+KAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758625662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ugd8T/HUP9+O29ivHS1us861w5SHAtLuLeWEiqbEiY=;
 b=XcEjNDEJXlyoz+b8JXOjdUIcl3tpvUL9KLFRG3yLbPIxI6f2Th78sdqo11ObArPsr2Sh4B
 fanUO4Iix71Kj2PsC0GCFiIW4C8C6bzWpPqdtArNNBI85taMheybpmjx509Om7fYlwwTbi
 Bx3GHNxbRkFiPenI4s1U4Vk0EkWCDyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758625662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ugd8T/HUP9+O29ivHS1us861w5SHAtLuLeWEiqbEiY=;
 b=SjNxKVGJEMamNKq10I8u5k0yYoRNzpfSMG9A0rE05FaF/y0J6pDTEpzSY3s5QokERaCBzb
 Wb3CWvyMSRc2+KAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D801388C;
 Tue, 23 Sep 2025 11:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t6LaGn1/0mhRegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Sep 2025 11:07:41 +0000
Date: Tue, 23 Sep 2025 13:07:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250923110732.GA9158@pevik>
References: <20250917075729.30093-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250917075729.30093-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap22: Improve MAP_DROPPABLE test stability
 using mincore()
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

> The current mmap22 test validates MAP_DROPPABLE by writing to the
> allocated memory and checking for zero-filled pages under memory
> pressure. However, this approach is unreliable because:

>   - Child process memory pressure (malloc + single writes) may not
>     reliably trigger cgroup memory reclaim.
>   - Checking memory content (alloc[i] == 0) is insufficient to
>     confirm kernel reclamation, as pages may remain resident but not
>     overwritten.
>   - Race conditions during child cleanup could leave residual cgroup
>     processes.

Thanks for the investigation.

> Error logs:

>    command: mmap22
>    tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmaxrtyKb as tmpdir (xfs filesystem)
>    tst_test.c:1953: TINFO: LTP version: 20250530
>    tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.0-130.1445_2041086229.el10.x86_64+rt/build/.config'
>    tst_test.c:1774: TINFO: Overall timeout per run is 0h 05m 54s
>    tst_test.c:1837: TINFO: Killed the leftover descendant processes
>    tst_test.c:1846: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
>    tst_test.c:1848: TBROK: Test killed! (timeout?)
>    tst_cgroup.c:1043: TBROK: unlinkat(5</sys/fs/cgroup/ltp>, 'test-92902', AT_REMOVEDIR): EBUSY (16)
>    ...

> This patch improves the test in the following ways:

>   * Use mincore() to precisely detect if MAP_DROPPABLE pages have
>     been reclaimed by the kernel.
>   * Replace the old child loop with a stronger memory pressure loop
>     (malloc + memset), ensuring cgroup limits are hit quickly.
>   * Use SAFE_KILL + SAFE_WAITPID for robust child cleanup.
nit: SAFE_KILL + SAFE_WAITPID were used before, the change you did is to check
with 'if (child > 0)' if it's meaningful to attempt to kill child.

>   * Extend runtime and add short sleeps to reduce busy looping and
>     stabilize test results.
>   * Record page size during setup for consistent use across functions.

> As a result, the test becomes more stable, deterministic, and easier
> to reproduce under different kernels and configurations.

+1

...
> +static void stress_child(void)
> +{
> +	for (;;) {
> +		char *buf = malloc(page_size);
nit: Please insert a blank line here to keep checkpatch.pl quiet.
mmap22.c:39: WARNING: Missing a blank line after declarations

> +		if (!buf)
> +			exit(1);
> +		memset(buf, 'B', page_size);
> +	}
> +}

...
> +	for (;;) {
> +		if (!tst_remaining_runtime()) {
> +			tst_res(TFAIL, "MAP_DROPPABLE did not drop pages within timeout");
> +			goto cleanup;
> +		}
> +
> +		if (mincore(alloc, ALLOC_SIZE, vec) == -1)
> +			tst_brk(TBROK | TERRNO, "mincore failed");
NOTE: we have SAFE_MINCORE() (can be fixed during merge).

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
