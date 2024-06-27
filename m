Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CD5C2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 11:40:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E74E3D1304
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 13:40:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDF873D122E
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 13:40:20 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9F939600284
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 13:40:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38ED01FBBC;
 Thu, 27 Jun 2024 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719488418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8jWzzPBcNR7Sk0eD7ZL0yoZnJZ7B5u1Uql+O3fyjk0=;
 b=iFPsUXkVduoH+CNyT3TH+1R+AsiYj0et3jKpH4DV3tOJji60HwhK5vI8wbEV/A06biVTHO
 Z60Nk0oP2VnVz9lEXEQYFBPEOkfsR9zVg1CUPr6lALn3neaXOkTDDCaWmAxi4CKI7PSqVW
 Qz+mmyS9JgsH6gccjZ0XMqRv/0fF31Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719488418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8jWzzPBcNR7Sk0eD7ZL0yoZnJZ7B5u1Uql+O3fyjk0=;
 b=RbX81QuZit0JzNGcsFYfI2NsfbGFVvPV7sYWd0E9MkLBmK+ihfTJgH4+Jz0XpgEmuwjbn6
 jE2t0/9INduVd1Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719488418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8jWzzPBcNR7Sk0eD7ZL0yoZnJZ7B5u1Uql+O3fyjk0=;
 b=iFPsUXkVduoH+CNyT3TH+1R+AsiYj0et3jKpH4DV3tOJji60HwhK5vI8wbEV/A06biVTHO
 Z60Nk0oP2VnVz9lEXEQYFBPEOkfsR9zVg1CUPr6lALn3neaXOkTDDCaWmAxi4CKI7PSqVW
 Qz+mmyS9JgsH6gccjZ0XMqRv/0fF31Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719488418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8jWzzPBcNR7Sk0eD7ZL0yoZnJZ7B5u1Uql+O3fyjk0=;
 b=RbX81QuZit0JzNGcsFYfI2NsfbGFVvPV7sYWd0E9MkLBmK+ihfTJgH4+Jz0XpgEmuwjbn6
 jE2t0/9INduVd1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DC541384C;
 Thu, 27 Jun 2024 11:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id as6mGaFPfWYRQQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Jun 2024 11:40:17 +0000
Date: Thu, 27 Jun 2024 13:40:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Zn1PluxR0lVO1qdn@yuki>
References: <CAEemH2fsBssjDyyozHnFt4T5y7LCWFEDqfN3nE7t3kyd19FjLg@mail.gmail.com>
 <20240627031440.799114-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240627031440.799114-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] msgstress01: remove TWARN from runtime
 remaining
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
> To mask the issue where a warning is being treated as a failure in CI
> logs, we modify the code to change the message type from TWARN to TCONF.
> 
> Additionally, we refine the condition under which the test reports as
> PASS to ensure that it also accounts for the `stop` flag. This prevents
> the test from incorrectly reporting success when it had to stop due to
> runtime constraints.
> 
> This warning easily happens especaill on debug/slower kernel:
> 
>     msgstress01.c:217: TWARN: Out of runtime during forking...
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/ipc/msgstress/msgstress01.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> index 8b1e9a8c0..9231a0b5f 100644
> --- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> +++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> @@ -214,7 +214,7 @@ static void run(void)
>  			break;
>  
>  		if (!tst_remaining_runtime()) {
> -			tst_res(TWARN, "Out of runtime during forking...");
> +			tst_res(TCONF, "Out of runtime during forking...");

This part looks good.

>  			*stop = 1;
>  			break;
>  		}
> @@ -242,7 +242,7 @@ static void run(void)
>  	tst_reap_children();
>  	remove_queues();
>  
> -	if (!(*fail))
> +	if (!(*fail) && !(*stop))
>  		tst_res(TPASS, "Test passed. All messages have been received");

However this would cause the test to report TBROK in the case that we
ended up out of runtime in the second for loop because in that case no
results will be reported by the test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
