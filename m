Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B034E77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 13:12:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A077C3C1BDB
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 14:12:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5C8C3C1863
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 14:12:15 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 388FC140E716
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 14:12:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43F7921133;
 Wed,  8 Jan 2025 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736341934;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iLvT5busFMnk8LPUF5VOZYK+HNucjdfRY99HR60hE0=;
 b=A+ZTrfVsqiixP5oCJHaRTgAkj1VTvWUxyA58GWYK3XpR6cyhKKkcdaDVhYcPSXTJviCK0F
 M2d4gq6/hXDRLo9gbRRKZzafIhhTPZJrCNbI85J90A1YTnaQRaaYlh5gYrr6MAHDYfo7Qy
 SCV5kIRVsV0lt7jJe8Q63jOLzUY+qk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736341934;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iLvT5busFMnk8LPUF5VOZYK+HNucjdfRY99HR60hE0=;
 b=je80AGsvUtEWxZduzuhYX5SF1S3I1H0/K69oH2fPNFcWDT+sy459T9fvaBcuAJzRMNnP9H
 z5M5c5boG237AdCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736341934;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iLvT5busFMnk8LPUF5VOZYK+HNucjdfRY99HR60hE0=;
 b=A+ZTrfVsqiixP5oCJHaRTgAkj1VTvWUxyA58GWYK3XpR6cyhKKkcdaDVhYcPSXTJviCK0F
 M2d4gq6/hXDRLo9gbRRKZzafIhhTPZJrCNbI85J90A1YTnaQRaaYlh5gYrr6MAHDYfo7Qy
 SCV5kIRVsV0lt7jJe8Q63jOLzUY+qk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736341934;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iLvT5busFMnk8LPUF5VOZYK+HNucjdfRY99HR60hE0=;
 b=je80AGsvUtEWxZduzuhYX5SF1S3I1H0/K69oH2fPNFcWDT+sy459T9fvaBcuAJzRMNnP9H
 z5M5c5boG237AdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EAF2137DA;
 Wed,  8 Jan 2025 13:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x389Cq55fme7MAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Jan 2025 13:12:14 +0000
Date: Wed, 8 Jan 2025 14:12:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250108131212.GA30426@pevik>
References: <20250106132607.25627-1-chrubis@suse.cz>
 <20250106132607.25627-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250106132607.25627-3-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/6] tst_run_shell: Make the tst_test struct
 static
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

Hi Cyril,

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Suggested-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_run_shell.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> index 0b86233dd..54463c04d 100644
> --- a/testcases/lib/tst_run_shell.c
> +++ b/testcases/lib/tst_run_shell.c
> @@ -26,7 +26,7 @@ static void run_shell_tcnt(unsigned int n)
>  	tst_run_script(shell_filename, params);
>  }

> -struct tst_test test = {
> +static struct tst_test test = {

Thanks!

Could you please before merge also fix formatting error?

tst_run_shell.c:144: ERROR: "(foo*)" should be "(foo *)"

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr


>  	.runs_script = 1,
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
