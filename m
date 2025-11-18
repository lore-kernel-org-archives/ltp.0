Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10101CEDDA1
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 15:04:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8073E3CF527
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 16:04:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAA033CE4EA
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 16:04:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2A2C7600701
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 16:04:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DB521FF35;
 Tue, 18 Nov 2025 15:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763478254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEkZ0fLDLeDMJNZidoKfnUXlRoYpOyvyIs4VleNfYnA=;
 b=H0ZlNzqcjqtuJ95NOYfiCzMbKrjUlDjpd/fnuy59Q0e3LlXDDs8VbxGq7dTndsg2pIO98D
 UqCaoetpW6hBlN65L+Jo/XGxTP+e0j64jk2VgZsfReN7T/cfkQ3RqlMyM6zNffLha647Eq
 bUL0Wn9ywOyVjU3Y5HTwwnlypqaWuLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763478254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEkZ0fLDLeDMJNZidoKfnUXlRoYpOyvyIs4VleNfYnA=;
 b=UutjbWG0J1qnoqamc17kHtHKEPMHq73w6u6S0hNfErfa72OC6X1t/i38SeB9/QeAjcLXpr
 UDLtlCT+EEnYvlBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H0ZlNzqc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UutjbWG0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763478254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEkZ0fLDLeDMJNZidoKfnUXlRoYpOyvyIs4VleNfYnA=;
 b=H0ZlNzqcjqtuJ95NOYfiCzMbKrjUlDjpd/fnuy59Q0e3LlXDDs8VbxGq7dTndsg2pIO98D
 UqCaoetpW6hBlN65L+Jo/XGxTP+e0j64jk2VgZsfReN7T/cfkQ3RqlMyM6zNffLha647Eq
 bUL0Wn9ywOyVjU3Y5HTwwnlypqaWuLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763478254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEkZ0fLDLeDMJNZidoKfnUXlRoYpOyvyIs4VleNfYnA=;
 b=UutjbWG0J1qnoqamc17kHtHKEPMHq73w6u6S0hNfErfa72OC6X1t/i38SeB9/QeAjcLXpr
 UDLtlCT+EEnYvlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF1B73EA61;
 Tue, 18 Nov 2025 15:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9DnoJu2KHGmBIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Nov 2025 15:04:13 +0000
Date: Tue, 18 Nov 2025 16:04:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20251118150410.GA49200@pevik>
References: <20251118143607.45308-1-pvorel@suse.cz>
 <20251118143607.45308-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251118143607.45308-3-pvorel@suse.cz>
X-Rspamd-Queue-Id: 4DB521FF35
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] swapon03: Try to swapon() as many files
 until it fails
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Previously tst_max_swapfiles() had fine tuning for a specific kernel
> version which was fragile due various backports in enterprise kernels.

> Let's try to create and use as many swap files until swapon() fails.
> Then check for expected EPERM.

> Also test swapon() 2x, first in the setup() when first failure happen,
> then in the test function (easier than propagate errno from fork to the
> main function). Therefore add -i2 into runtest/syscalls.

> It was required to increase cmd_buffer size to avoid directive output
> may be truncated warning.

...
> -	/* Determine how many more files are to be created */
> -	max_swapfiles = tst_max_swapfiles();
>  	used_swapfiles = tst_count_swaps();
> -	swapfiles = max_swapfiles - used_swapfiles;
> -	if (swapfiles > max_swapfiles)
> -		swapfiles = max_swapfiles;
> +	expected_swapfiles = NUM_SWAP_FILES - used_swapfiles;

And merging this should be followed with removing tst_max_swapfiles()

https://lore.kernel.org/ltp/20251106163500.1063704-5-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20251106163500.1063704-5-pvorel@suse.cz/

I forget to add it to v3, therefore I keep this patch opened in patchwork.
I'm sorry for the noise.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
