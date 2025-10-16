Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE76CCD195
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 13:32:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F21573CEE02
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 15:32:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BF343C7B08
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 15:32:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8DBBA200B32
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 15:32:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49DFB21D35;
 Thu, 16 Oct 2025 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760621525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NtqVzdcV+/Lmy7QVycLwmaLgGnKD0K4HnK4HVRM/t0=;
 b=Wf7vdimZOLY/GQbUA2rvkcuwVCIdeC6MWqa8oypKFYTMCxdFD3czj08YFECOfgOzk3Uzjs
 UuBLMPDGpKLrHbEKi1numQ9+nqSLseVBDxsCCSl+1v/OKqoE/Yyn/nEVf8yOR3oIZRl9Sj
 69sF1h7tVllqOnlQ2abjNuwWMXsdM/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760621525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NtqVzdcV+/Lmy7QVycLwmaLgGnKD0K4HnK4HVRM/t0=;
 b=e30FPGdkOqqedL5woWyo2VxkRjOiJjjiL0TWsAvVYnII/8jsZ+8DJp48cvbBPrS8vC69r0
 FCljnAJQvtvi9JAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Wf7vdimZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e30FPGdk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760621525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NtqVzdcV+/Lmy7QVycLwmaLgGnKD0K4HnK4HVRM/t0=;
 b=Wf7vdimZOLY/GQbUA2rvkcuwVCIdeC6MWqa8oypKFYTMCxdFD3czj08YFECOfgOzk3Uzjs
 UuBLMPDGpKLrHbEKi1numQ9+nqSLseVBDxsCCSl+1v/OKqoE/Yyn/nEVf8yOR3oIZRl9Sj
 69sF1h7tVllqOnlQ2abjNuwWMXsdM/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760621525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NtqVzdcV+/Lmy7QVycLwmaLgGnKD0K4HnK4HVRM/t0=;
 b=e30FPGdkOqqedL5woWyo2VxkRjOiJjjiL0TWsAvVYnII/8jsZ+8DJp48cvbBPrS8vC69r0
 FCljnAJQvtvi9JAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EA301340C;
 Thu, 16 Oct 2025 13:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EBKDCdXz8GhFSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Oct 2025 13:32:05 +0000
Date: Thu, 16 Oct 2025 15:32:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251016133203.GA284465@pevik>
References: <20250827230301.32614-1-wegao@suse.com>
 <20251015031540.2120-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251015031540.2120-1-wegao@suse.com>
X-Rspamd-Queue-Id: 49DFB21D35
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mremap07.c: New case check mremap with
 MREMAP_DONTUNMAP
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

Hi Wei,

...
> +static void run(void)
> +{
> +	pthread_t handler_thread;
> +
> +	SAFE_PTHREAD_CREATE(&handler_thread, NULL,
> +		(void * (*)(void *))fault_handler_thread, NULL);
> +
> +#if HAVE_DECL_MREMAP_DONTUNMAP
This is a compile check, whole test should be wrapped with #ifdef and fallback
using TST_TEST_TCONF() macro.

#include "config.h"
#include "tst_test.h"
...
#ifdef HAVE_DECL_MREMAP_DONTUNMAP
// other includes

#else
TST_TEST_TCONF("Missing MREMAP_DONTUNMAP in <linux/mman.h>");
#endif

This quits tests early.
And please use #ifdef.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
