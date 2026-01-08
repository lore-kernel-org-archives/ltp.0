Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854D7D185F1
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 13:07:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 068193C649C
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 14:07:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C72DA3C59A7
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 14:07:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1BCF1600296
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 14:07:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B9F1340F8;
 Thu,  8 Jan 2026 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767877632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPX4CB7LtYVDy6bcPUMeefyj7xuUptIhanwV7HkT1CI=;
 b=ko7GJ9A5dC4b/z9adg7gSPyi4nc8SK1lkS8I1UdlVRMAlKB/aqzR5hynCUm1fKY5SolX7L
 rryQb2MltGbI2bxr6ObP7YNZbZa2CiJHWgb9hKTGAInOilsdv3O4L6n9K6Z2nP5RNWf7EY
 /p2+RbhSdx75B/Tv7GTSTdSNdQfG22s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767877632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPX4CB7LtYVDy6bcPUMeefyj7xuUptIhanwV7HkT1CI=;
 b=6MSwd32fSa1ENk9Ian9Z51P3pJsEoEzCn6nu5u/Ch387ZkDx3Swy4MXcGgjn3OqbCmXCPe
 AjuJ3gZ6smtNk8Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767877632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPX4CB7LtYVDy6bcPUMeefyj7xuUptIhanwV7HkT1CI=;
 b=ko7GJ9A5dC4b/z9adg7gSPyi4nc8SK1lkS8I1UdlVRMAlKB/aqzR5hynCUm1fKY5SolX7L
 rryQb2MltGbI2bxr6ObP7YNZbZa2CiJHWgb9hKTGAInOilsdv3O4L6n9K6Z2nP5RNWf7EY
 /p2+RbhSdx75B/Tv7GTSTdSNdQfG22s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767877632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPX4CB7LtYVDy6bcPUMeefyj7xuUptIhanwV7HkT1CI=;
 b=6MSwd32fSa1ENk9Ian9Z51P3pJsEoEzCn6nu5u/Ch387ZkDx3Swy4MXcGgjn3OqbCmXCPe
 AjuJ3gZ6smtNk8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6701C3EA63;
 Thu,  8 Jan 2026 13:07:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VB05GACsX2mKcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Jan 2026 13:07:12 +0000
Date: Thu, 8 Jan 2026 14:07:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260108130707.GA4263@pevik>
References: <20260108130002.256854-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260108130002.256854-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] uaccess.c: Skip on Lockdown/Secure Boot
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

Hi Avinesh,

> following the commit (fca9460dee fw_load: Skip on Lockdown/Secure Boot)
> to take care of

> ltp_uaccess    0  TINFO  :  module signature enforcement: off
> insmod: ERROR: could not insert module ltp_uaccess.ko: Key was rejected by service

...
> @@ -39,6 +40,12 @@ static const char dev_tcase[]	= "/sys/devices/" DEV_NAME "/tcase";
>  static const char module_name[]	= DEV_NAME ".ko";
>  static int module_loaded;

> +static void setup(void)
> +{
> +	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
> +		tst_brkm(TCONF, NULL, "Cannot load unsigned modules in Lockdown/Secure Boot");
> +}
...
> +	setup();

Thanks for fixing it!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
