Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C21CCFA18
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 13:04:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 635893CF685
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 14:04:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B62393CF633
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 14:03:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0857B60095B
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 14:03:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B6601F78B;
 Tue, 11 Nov 2025 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762866230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzsT9L5i9U8u+kW61kV8M9xvAxVejTq9JTdneznTbzo=;
 b=nWJsgFNSkvTV7ugim6xPSyoOP97ZnFkESD8n1Ef5KR+p4+DMTnhC0Nu4V1oBMBdje0vgOZ
 DGinlkJ1HMsACfKnAEBJQMLsWaB9LSrM7o9RgnHvipRkPtDvaLa5oKBVaWZaS0BkCiMZyw
 j6vP9dsR+1ksP/b4STdEDQw4zWAwXo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762866230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzsT9L5i9U8u+kW61kV8M9xvAxVejTq9JTdneznTbzo=;
 b=HG29Fnqiken3PG1fLd8tIAIx/yMjy+P2x3e+pRGopApGmJTUnnzZGUDH8I7FBwrJ5lCriM
 /4QwQlp7rXvQvKBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nWJsgFNS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HG29Fnqi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762866230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzsT9L5i9U8u+kW61kV8M9xvAxVejTq9JTdneznTbzo=;
 b=nWJsgFNSkvTV7ugim6xPSyoOP97ZnFkESD8n1Ef5KR+p4+DMTnhC0Nu4V1oBMBdje0vgOZ
 DGinlkJ1HMsACfKnAEBJQMLsWaB9LSrM7o9RgnHvipRkPtDvaLa5oKBVaWZaS0BkCiMZyw
 j6vP9dsR+1ksP/b4STdEDQw4zWAwXo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762866230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzsT9L5i9U8u+kW61kV8M9xvAxVejTq9JTdneznTbzo=;
 b=HG29Fnqiken3PG1fLd8tIAIx/yMjy+P2x3e+pRGopApGmJTUnnzZGUDH8I7FBwrJ5lCriM
 /4QwQlp7rXvQvKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7984714982;
 Tue, 11 Nov 2025 13:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ywqhHDY0E2mnSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 11 Nov 2025 13:03:50 +0000
Date: Tue, 11 Nov 2025 14:04:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRM0Z-IlZSLdB5ho@yuki.lan>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251106163500.1063704-3-pvorel@suse.cz>
X-Rspamd-Queue-Id: 8B6601F78B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] swapon03: Cleanup
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
> - Remove unused return code in check_and_swapoff() and setup_swap(). The
>   purpose was to run cleanup() in the end of the setup() if creating
>   swap fails, but return code is always 0. Also cleanup() should be run
>   when test exits with tst_brk() anyway.
> - Change return code from TFAIL to TBROK.
> - Add missing brackets.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> The same as in v1.
> I can split this if you like.
> 
>  testcases/kernel/syscalls/swapon/swapon03.c | 23 +++++++--------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
> index 01a3b6d8ac..d9822c01ef 100644
> --- a/testcases/kernel/syscalls/swapon/swapon03.c
> +++ b/testcases/kernel/syscalls/swapon/swapon03.c
> @@ -25,7 +25,7 @@
>  
>  static int swapfiles;
>  
> -static int setup_swap(void)
> +static void setup_swap(void)
>  {
>  	pid_t pid;
>  	int status;
> @@ -54,33 +54,27 @@ static int setup_swap(void)
>  			TST_EXP_PASS_SILENT(swapon(filename, 0));
>  		}
>  		exit(0);
> -	} else
> +	} else {
>  		waitpid(pid, &status, 0);
> +	}
>  
>  	if (WEXITSTATUS(status))
> -		tst_brk(TFAIL, "Failed to setup swap files");
> +		tst_brk(TBROK, "Failed to setup swap files");

I wonder why do we run this code in a child process to begin with? This
is probably some leftover from the conversion to the new library. Among
other things this masks proper results propagation from the
MAKE_SMALL_SWAPFILE() because there is at least one tst_brk(TCONF, "")
in there that will be converted to TBROK here.

I guess that we want to remove the fork() here and we want SAFE_SWAPON()
instead of the TST_EXP_PASS_SILENT() so that we do tst_brk() if we fail
to setup the swapfile too. The TST_EXP_PASS_SILENT() does not end the
test on a failure, which is what we want here instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
