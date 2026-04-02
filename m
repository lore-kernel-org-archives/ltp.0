Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B598CD6AB16
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 21:47:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BFCE3E4E96
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 23:47:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25C7D3E21AE
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 23:47:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8826F200966
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 23:47:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1EE464D309;
 Thu,  2 Apr 2026 21:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775166457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ug0+lWDLHW1RHj94H+CiAbMfYlMgqkLN8E3xCiuikTc=;
 b=mZJjwwlr8aNmlOetC2njVIW0D+dJXvJhS7yuzRveG+ifipHZJL22MfSTe40N5Z8lk/W/CQ
 l7cH7uRFl1P8REHgmJJpYbTh6GBmWXj3VvL3vLe9EHnAaoatSVyphGXd4W0UnnLTWZ4qQa
 T5+Acml1dx+2h5Jb0ub9Feb6ULnu6Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775166457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ug0+lWDLHW1RHj94H+CiAbMfYlMgqkLN8E3xCiuikTc=;
 b=k/a+v1onIJuqvhHuiFBiFa2Y5azhmI4k6v/r7kmCspBvcd9HSAtKG0mk6TJPtlVWoTPwi5
 r/8M0vy7vEUiafCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775166457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ug0+lWDLHW1RHj94H+CiAbMfYlMgqkLN8E3xCiuikTc=;
 b=mZJjwwlr8aNmlOetC2njVIW0D+dJXvJhS7yuzRveG+ifipHZJL22MfSTe40N5Z8lk/W/CQ
 l7cH7uRFl1P8REHgmJJpYbTh6GBmWXj3VvL3vLe9EHnAaoatSVyphGXd4W0UnnLTWZ4qQa
 T5+Acml1dx+2h5Jb0ub9Feb6ULnu6Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775166457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ug0+lWDLHW1RHj94H+CiAbMfYlMgqkLN8E3xCiuikTc=;
 b=k/a+v1onIJuqvhHuiFBiFa2Y5azhmI4k6v/r7kmCspBvcd9HSAtKG0mk6TJPtlVWoTPwi5
 r/8M0vy7vEUiafCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E48D34A0B0;
 Thu,  2 Apr 2026 21:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DRM1MvjjzmmhTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Apr 2026 21:47:36 +0000
Date: Thu, 2 Apr 2026 23:47:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260402214727.GE225068@pevik>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-4-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260402121356.31266-4-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/17] lib: tst_kernel: Add
 tst_check_module_driver()
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

> @@ -200,16 +200,18 @@ static int tst_search_driver(const char *driver, const char *file)

>  int tst_check_builtin_driver(const char *driver)
>  {
> -	if (!tst_search_driver(driver, "modules.builtin"))
> -		return 0;
> +	return tst_search_driver(driver, "modules.builtin");
> +}

> -	return -1;
> +int tst_check_module_driver(const char *driver)
> +{
> +	return tst_search_driver(driver, "modules.dep");

Thinking about it twice, could we check for the module by reading
/sys/module/? Our current approach shows what module *should* be available, but
that might not be true for some reason (i.e. loadable module not installed).

Unfortunately while this works for loadable modules (and IMHO worth to add it),
builtin modules are here only if they have a version or at least one parameter
[1].  And this will not work at least for hwpoison_inject.

Kind regards,
Petr

[1] https://www.kernel.org/doc/Documentation/ABI/stable/sysfs-module

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
