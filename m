Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3FBC47DDF
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 10:31:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C558C3CF971
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 11:31:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E6D93CE0E9
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 11:30:55 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2F7BE14044B0
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 11:30:54 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17A2921E26;
 Tue, 30 Jan 2024 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706610654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ExAQKVyh01dUdYYtv5k0DPy+czALM4zaeaDeRd/ct8I=;
 b=wCPzOmysOmbebX1HYk4zU11joMlJoHWiPx78b61n1gVN+dzEeNbgdUk4yrR6hOPQdhQH6w
 VvjBlFapNA2aYtc2GKmNHSJnR5G0dAvGp3j8pMAfIx8Y42A8s9Dr+kAbqukb3AzmioHV8/
 er8vbZWP/5d5m0hWnsdj6Ju6SedlKq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706610654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ExAQKVyh01dUdYYtv5k0DPy+czALM4zaeaDeRd/ct8I=;
 b=fZXYR0nedQzGmCpartO4FkTwF4Mlr70itZdxqgohQwxGHaz0ld5Ij0VLLN7prvMfliXu4U
 FEgPmUpP6jFBcYBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706610654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ExAQKVyh01dUdYYtv5k0DPy+czALM4zaeaDeRd/ct8I=;
 b=wCPzOmysOmbebX1HYk4zU11joMlJoHWiPx78b61n1gVN+dzEeNbgdUk4yrR6hOPQdhQH6w
 VvjBlFapNA2aYtc2GKmNHSJnR5G0dAvGp3j8pMAfIx8Y42A8s9Dr+kAbqukb3AzmioHV8/
 er8vbZWP/5d5m0hWnsdj6Ju6SedlKq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706610654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ExAQKVyh01dUdYYtv5k0DPy+czALM4zaeaDeRd/ct8I=;
 b=fZXYR0nedQzGmCpartO4FkTwF4Mlr70itZdxqgohQwxGHaz0ld5Ij0VLLN7prvMfliXu4U
 FEgPmUpP6jFBcYBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E9E3E13212;
 Tue, 30 Jan 2024 10:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id /dT9Nt3PuGW7eQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 10:30:53 +0000
Date: Tue, 30 Jan 2024 11:30:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240130103052.GA753541@pevik>
References: <20240117173006.31521-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117173006.31521-1-mdoucha@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wCPzOmys;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fZXYR0ne
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.52 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.cz:dkim]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.31)[75.25%]
X-Rspamd-Queue-Id: 17A2921E26
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Add tst_is_compat_mode() helper function
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

Hi Martin,

> New helper function to simplify checks whether the test process runs
> in e.g. 32bit compat mode on 64bit kernel.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +int tst_is_compat_mode(void)
> +{
> +	return TST_ABI != tst_kernel_bits();

BTW setsockopt03.c and setsockopt08.c use:
if (tst_kernel_bits() == 32 || sizeof(long) > 4)

I guess they could also use tst_is_compat_mode().

And we have .skip_in_compat = 1, we could also add .require_compat (for
documentation purposes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
