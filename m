Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C80C0219E
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 10:12:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 433CC3C9BEA
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 11:12:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9F323C8FFA
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 11:12:11 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 32AE061829E
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 11:12:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9B191F74D;
 Mon, 17 Feb 2025 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739787130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuwFPUNahC/88mvTyjyp8d3xcINwnbZDD1PwQiRUy+A=;
 b=hiut7F2EPbH+6RbABXexEqv/tr3CxqPql4w3nZ7BHGkGoORNGq9ir1SwQfcdRlavxTTtlV
 3Q1w6Wk8rQWK51qY7jcVLbpDmhBVum1W9jTKWjp0st2C3lyhQWKQePABXKan010AZqQ/o3
 tEPfFeMNqZUo4wv8JcXMjs+Q6hEs+qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739787130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuwFPUNahC/88mvTyjyp8d3xcINwnbZDD1PwQiRUy+A=;
 b=/CEZ1QPunWXhY34J5gSrXQ0ipt7S+2+lWiNW2EQPn1kzUjR3hQNK8pW5PT0j+SuxOHdAq8
 Hzz2LMkEH9oaSkBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PHDlFLaJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BSTDFDSg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739787127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuwFPUNahC/88mvTyjyp8d3xcINwnbZDD1PwQiRUy+A=;
 b=PHDlFLaJgnoXE3vjEMjZbX+EEAf6sP50suM6QOEqJEnVORpPzV4HO1q6guldX+DovOPoYE
 cAT1rALHfLcrLj1W0m+Vba/fWHAnN1xyVir58rvrj9I9C6d3zRgxADrBlqjPyr+IVGYhJh
 hT/++WZpCpHFXUrvftJ8q1sqDg+Apus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739787127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuwFPUNahC/88mvTyjyp8d3xcINwnbZDD1PwQiRUy+A=;
 b=BSTDFDSgL/jFV7MbgeAODX07yJ1rNuUeruLXVn+nnVmt1GmaYtaNqkW6S5KcLqcS9LRCse
 5Jsf8BBYYOymtfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB244133F9;
 Mon, 17 Feb 2025 10:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JZdrM3cLs2dPTAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 17 Feb 2025 10:12:07 +0000
Date: Mon, 17 Feb 2025 11:12:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dorinda Bassey <dbassey@redhat.com>
Message-ID: <Z7MLfpxzQtcdhNzu@yuki.lan>
References: <20250214153158.96460-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250214153158.96460-1-dbassey@redhat.com>
X-Rspamd-Queue-Id: E9B191F74D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email, yuki.lan:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kcmp03: Add check for KCMP_SYSVSEM before running
 test
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
Cc: sbertram@redhat.com, javierm@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This commit introduces a new function
> `is_kcmp_supported()` to check if the kernel supports the
> `KCMP_SYSVSEM` operation. In the `verify_kcmp()` function,
> we add logic to detect when the kernel does not support
> `KCMP_SYSVSEM` and skip the test for that case with a TCONF
> result. This ensures that the test does not fail when the
> Kconfig that supports `KCMP_SYSVSEM` is unavailable.

First of all the coding style is inconsistent, have you run 'make check'
in the test directory and fixed all the problems?

> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
>  testcases/kernel/syscalls/kcmp/kcmp03.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
> index 37d5118d5..255171d98 100644
> --- a/testcases/kernel/syscalls/kcmp/kcmp03.c
> +++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
> @@ -52,6 +52,12 @@ static void cleanup(void)
>  	free(stack);
>  }
>  
> +static int is_kcmp_supported(void)
> +{
> +	int result = syscall(__NR_kcmp, getpid(), getpid(), KCMP_SYSVSEM, 0, 0);

Why syscall() instead of kcmp() that is used in the rest of the test?

> +	return result == 0 || errno != EOPNOTSUPP;
> +}
> +
>  static int do_child(void *arg)
>  {
>  	pid2 = getpid();
> @@ -64,6 +70,13 @@ static void verify_kcmp(unsigned int n)
>  	int res;
>  	struct tcase *tc = &tcases[n];
>  
> +    // Handle the case for KCMP_SYSVSEM specifically
> +    if (tc->kcmp_type == KCMP_SYSVSEM) {
> +        if (!is_kcmp_supported()) {

This function should be called once from the test setup and the results
should be cached.

> +            tst_brk(TCONF, "Kernel does not support KCMP_SYSVSEM, skipping test.");

This should be just tst_res(TCONF, "..."); followed by return 0;

We do not want to abort subseqent test iterations (e.g. -i 2 on command
line) just because one operation is not supported.

> +	    }
> +	}


>  	pid1 = getpid();
>  	tst_res(TINFO, "Testing %s", tc->desc);
>  
> -- 
> 2.48.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
