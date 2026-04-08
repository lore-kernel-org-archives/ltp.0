Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF6D1073C85
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 10:11:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D67A63E26AA
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 12:11:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B375D3C1BE3
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 12:10:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4DA361000975
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 12:10:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B00134E945;
 Wed,  8 Apr 2026 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775643050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hf7QL1sMGdfqTMOqt+4QxiCcjlwfU1Q0KS3TJHkH0+E=;
 b=rACq0Bw4s3oKdNN5JlX4E/stMMANS0TfxbfV16uIEWXi2yGrVD9xMC/kGimEVfrnA0uFp7
 A8WV4tQhCjsONPhOD8S4NKx1EGr0KYEKWFIFk4qC8eNYLrJtqEk/2XCuT/WN5cP8+/faNi
 RiNP5Y2H1sxqgq2x2tFHz02KlnUoazU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775643050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hf7QL1sMGdfqTMOqt+4QxiCcjlwfU1Q0KS3TJHkH0+E=;
 b=9/l4cis72qQqvCkzHrve+vuthNT2hf3/7pUzfG4W1B6yR8wL9r/K0DdULr39e0fyeOWpUG
 RF2KO2getxoRJODQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rACq0Bw4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9/l4cis7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775643050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hf7QL1sMGdfqTMOqt+4QxiCcjlwfU1Q0KS3TJHkH0+E=;
 b=rACq0Bw4s3oKdNN5JlX4E/stMMANS0TfxbfV16uIEWXi2yGrVD9xMC/kGimEVfrnA0uFp7
 A8WV4tQhCjsONPhOD8S4NKx1EGr0KYEKWFIFk4qC8eNYLrJtqEk/2XCuT/WN5cP8+/faNi
 RiNP5Y2H1sxqgq2x2tFHz02KlnUoazU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775643050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hf7QL1sMGdfqTMOqt+4QxiCcjlwfU1Q0KS3TJHkH0+E=;
 b=9/l4cis72qQqvCkzHrve+vuthNT2hf3/7pUzfG4W1B6yR8wL9r/K0DdULr39e0fyeOWpUG
 RF2KO2getxoRJODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EE554A0B3;
 Wed,  8 Apr 2026 10:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sA6vJaop1mkqXgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Apr 2026 10:10:50 +0000
Date: Wed, 8 Apr 2026 12:10:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lepillai@linux.ibm.com
Message-ID: <adYpsZP2IKxco4au@yuki.lan>
References: <20260408053655.3818590-1-lepillai@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260408053655.3818590-1-lepillai@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B00134E945
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added new_behavior flag to detect kernel version
 Kernel >= 6.11: Tests that creat() succeeds (write to executed file
 allowed)
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
Cc: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static int new_behavior;
> +
>  static void verify_creat(void)
>  {
>  	pid_t pid;
> @@ -33,16 +35,26 @@ static void verify_creat(void)
>  
>  	TEST(creat(TEST_APP, O_WRONLY));
>  
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL, "creat() succeeded unexpectedly");
> -		return;
> +	if (new_behavior) {
> +		/* Kernel >= 6.11: write to executed file is allowed */
> +		if (TST_RET != -1) {
> +			SAFE_CLOSE(TST_RET);
> +			tst_res(TPASS, "creat() succeeded as expected (new behavior)");
> +		} else {
> +			tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
> +		}
> +	} else {
> +		/* Kernel < 6.11: write to executed file returns ETXTBSY */
> +		if (TST_RET != -1) {
> +			tst_res(TFAIL, "creat() succeeded unexpectedly");
> +			SAFE_CLOSE(TST_RET);
> +		} else if (TST_ERR == ETXTBSY) {
> +			tst_res(TPASS, "creat() received ETXTBSY");
> +		} else {
> +			tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
> +		}
>  	}
>  
> -	if (TST_ERR == ETXTBSY)
> -		tst_res(TPASS, "creat() received EXTBSY");
> -	else
> -		tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
> -
>  	SAFE_KILL(pid, SIGKILL);
>  	SAFE_WAITPID(pid, NULL, 0);
>  }
> @@ -50,9 +62,13 @@ static void verify_creat(void)
>  static void setup(void)
>  {
>  	if ((tst_kvercmp(6, 11, 0)) >= 0) {
> -		tst_brk(TCONF, "Skipping test, write to executed file is "
> -			"allowed since 6.11-rc1.\n"
> -			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
> +		new_behavior = 1;
> +		tst_res(TINFO, "Testing new behavior: write to executed file is "
> +			"allowed since 6.11-rc1 (2a010c412853)");
> +	} else {
> +		new_behavior = 0;
> +		tst_res(TINFO, "Testing old behavior: write to executed file "
> +			"returns ETXTBSY");

Apart from the code being ugly and having way too much verbose messages
the test is likely broken with -i 2 command line option on newer
kernels.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
