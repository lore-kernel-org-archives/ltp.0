Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B3FC83F17
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 13:28:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F9BF3C89C3
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 15:28:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40AF63C0980
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 15:28:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AFFE910008E2
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 15:28:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 811E21F789;
 Mon, 28 Jul 2025 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753709317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5exJBMqqpPULoZOGy/3yBKHKkp0oV/c7QlBVNcZrzw=;
 b=YOCRfQa20UgtKbtr/muVIFooXBr1nmybIFS3Go1MRe8/cIiQ9KeHSL8JzOvgJ1MwBrEPkq
 7OgZ3HhG+brOHLX3hYV7x81Ua7/P48kJOtlhkls9ywJhaSwdv0CLRJXjxH7W/bpmLHNDCE
 MKzqJiajHfyUoNUkccrVsHjYnaqEfic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753709317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5exJBMqqpPULoZOGy/3yBKHKkp0oV/c7QlBVNcZrzw=;
 b=srgIZpQfdoHAYCIOOC1tisKYeFufseyKDdoWCbv+wfRpuCaI9fi7c264mePzQRHB879+O1
 tJbm4aE41Zbw9QAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YOCRfQa2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=srgIZpQf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753709317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5exJBMqqpPULoZOGy/3yBKHKkp0oV/c7QlBVNcZrzw=;
 b=YOCRfQa20UgtKbtr/muVIFooXBr1nmybIFS3Go1MRe8/cIiQ9KeHSL8JzOvgJ1MwBrEPkq
 7OgZ3HhG+brOHLX3hYV7x81Ua7/P48kJOtlhkls9ywJhaSwdv0CLRJXjxH7W/bpmLHNDCE
 MKzqJiajHfyUoNUkccrVsHjYnaqEfic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753709317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5exJBMqqpPULoZOGy/3yBKHKkp0oV/c7QlBVNcZrzw=;
 b=srgIZpQfdoHAYCIOOC1tisKYeFufseyKDdoWCbv+wfRpuCaI9fi7c264mePzQRHB879+O1
 tJbm4aE41Zbw9QAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6639C1368A;
 Mon, 28 Jul 2025 13:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rg3wFwV7h2ivfgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 28 Jul 2025 13:28:37 +0000
Date: Mon, 28 Jul 2025 15:29:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aId7M6soHD3246n0@yuki.lan>
References: <20250724170003.479248-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250724170003.479248-1-pvorel@suse.cz>
X-Rspamd-Queue-Id: 811E21F789
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fsconfig03: Quit on first error
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
> Test runs in loop 5000x, if it fails, it pollutes output a lot.
> 
> Currently bcachefs fails 4883x:
> fsconfig03.c:53: TFAIL: fsconfig() passed unexpectedly
> 
> Skip with goto to keep check for a taint flags.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
> 
> or do we want to quit after more errors, e.g. 10x?
> 
> Kind regards,
> Petr
> 
>  testcases/kernel/syscalls/fsconfig/fsconfig03.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> index add54769e0..985278986a 100644
> --- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> @@ -51,15 +51,18 @@ static void run(void)
>  
>  		if (!TST_RET) {
>  			tst_res(TFAIL, "fsconfig() passed unexpectedly");
> +			goto cleanup;

Shouldn't break; be better in this case?

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
