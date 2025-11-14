Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B06CE7A8C
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 08:55:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 556E53CF812
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 09:55:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4287A3CF384
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 09:55:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C19E600D43
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 09:55:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 437E71F391;
 Fri, 14 Nov 2025 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763110523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yI2VQN9jW+4vgEn95t5JFKrivKyqkeZZjZIqxmuBl9g=;
 b=VoYY0OsbhOvWh8mCqU0nc4YmJBtBe8fp8tlsSzAXOxNDUfr21q+wpXyRMjcyYu73tpXWfP
 PC5mk6KZWYnXV2n+kzwXq8yk4zwGiYEGtXR14LJS9waXHM5x039ABN6jUXZdHbgZJYW6aw
 aOMjDvPPw/govhpi0tfwg1W4qGm/E5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763110523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yI2VQN9jW+4vgEn95t5JFKrivKyqkeZZjZIqxmuBl9g=;
 b=iurS2uGUhDmojdE86fJ9jooLVTjYVnwJa85/on/MpAYzsSlhsRpMQCpCiSCDTv8mUyMcx3
 IM96G4k6RVTSWLDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763110523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yI2VQN9jW+4vgEn95t5JFKrivKyqkeZZjZIqxmuBl9g=;
 b=VoYY0OsbhOvWh8mCqU0nc4YmJBtBe8fp8tlsSzAXOxNDUfr21q+wpXyRMjcyYu73tpXWfP
 PC5mk6KZWYnXV2n+kzwXq8yk4zwGiYEGtXR14LJS9waXHM5x039ABN6jUXZdHbgZJYW6aw
 aOMjDvPPw/govhpi0tfwg1W4qGm/E5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763110523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yI2VQN9jW+4vgEn95t5JFKrivKyqkeZZjZIqxmuBl9g=;
 b=iurS2uGUhDmojdE86fJ9jooLVTjYVnwJa85/on/MpAYzsSlhsRpMQCpCiSCDTv8mUyMcx3
 IM96G4k6RVTSWLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 363363EA61;
 Fri, 14 Nov 2025 08:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dLKqDHvuFmnpMQAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 14 Nov 2025 08:55:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Nov 2025 09:55:22 +0100
Message-ID: <13884671.uLZWGnKmhe@thinkpad>
In-Reply-To: <20251107102939.1111074-9-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
 <20251107102939.1111074-9-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/8] tst_test.c: Change fork_testrun() return type
 to void
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

Hi Petr,

On Friday, November 7, 2025 11:29:39 AM CET Petr Vorel wrote:
> Return code is not used any more.
very nit:
s/any more/anymore
(also applies in patch 6 and 7)

Reviewed-by: Avinesh Kumar <akumar@suse.de>
for all patches in the series.

Regards,
Avinesh
> 
> Fixes: a1f82704c2 ("lib/tst_test.c: Fix tst_brk() handling")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_test.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8098b3a010..e115ce689d 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1880,7 +1880,7 @@ void tst_set_runtime(int runtime)
>  	heartbeat();
>  }
>  
> -static int fork_testrun(void)
> +static void fork_testrun(void)
>  {
>  	int status;
>  
> @@ -1911,8 +1911,8 @@ static int fork_testrun(void)
>  	SAFE_SIGNAL(SIGINT, SIG_DFL);
>  
>  	if (tst_test->taint_check && tst_taint_check()) {
> -		tst_res(TFAIL, "Kernel is now tainted.");
> -		return TFAIL;
> +		tst_res(TFAIL, "Kernel is now tainted");
> +		return;
>  	}
>  
>  	if (tst_test->forks_child && kill(-test_pid, SIGKILL) == 0)
> @@ -1922,7 +1922,7 @@ static int fork_testrun(void)
>  		tst_brk(TBROK, "Child returned with %i", WEXITSTATUS(status));
>  
>  	if (context->abort_flag)
> -		return 0;
> +		return;
>  
>  	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
>  		tst_res(TINFO, "If you are running on slow machine, "
> @@ -1932,8 +1932,6 @@ static int fork_testrun(void)
>  
>  	if (WIFSIGNALED(status))
>  		tst_brk(TBROK, "Test killed by %s!", tst_strsig(WTERMSIG(status)));
> -
> -	return 0;
>  }
>  
>  static struct tst_fs *lookup_fs_desc(const char *fs_type, int all_filesystems)
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
