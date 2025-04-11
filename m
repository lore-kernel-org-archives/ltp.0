Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD52C369A8
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 12:00:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08AC53CB230
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 14:00:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF5583CAEB7
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:59:46 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 35FE41A00CAC
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:59:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28F3B21169;
 Fri, 11 Apr 2025 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744372785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4ntcM2VsoGlW9Dbte1dx4PXMsAoaDH+4tgyJN9kOsE=;
 b=AxkE/Yar7DPwbqt1ELOY/GrbdwRETPXWXInqr7O6qYlEm7j+7dDYhYw5aIWh3DsCPI8v8z
 vzTerhsGmv3bKtrBTG2i3EGWTcgXIXxYcudcH/1OPWtBQ6nvtUXM5CYKabfbPi1Gkl4tJ1
 mBmhLicjG83XlZaL/Ejp4KL9MfVtApc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744372785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4ntcM2VsoGlW9Dbte1dx4PXMsAoaDH+4tgyJN9kOsE=;
 b=1GLlJXdODjDP1mqY6hFnYnymhnRFt5U1tynohKgZIdVfhc12iB87UyA3nPbbbaOB3OiiKW
 jcM/4LnbeZH96OBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="AxkE/Yar";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1GLlJXdO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744372785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4ntcM2VsoGlW9Dbte1dx4PXMsAoaDH+4tgyJN9kOsE=;
 b=AxkE/Yar7DPwbqt1ELOY/GrbdwRETPXWXInqr7O6qYlEm7j+7dDYhYw5aIWh3DsCPI8v8z
 vzTerhsGmv3bKtrBTG2i3EGWTcgXIXxYcudcH/1OPWtBQ6nvtUXM5CYKabfbPi1Gkl4tJ1
 mBmhLicjG83XlZaL/Ejp4KL9MfVtApc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744372785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4ntcM2VsoGlW9Dbte1dx4PXMsAoaDH+4tgyJN9kOsE=;
 b=1GLlJXdODjDP1mqY6hFnYnymhnRFt5U1tynohKgZIdVfhc12iB87UyA3nPbbbaOB3OiiKW
 jcM/4LnbeZH96OBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BC3F136A4;
 Fri, 11 Apr 2025 11:59:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id op0hATEE+WcBWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Apr 2025 11:59:45 +0000
Date: Fri, 11 Apr 2025 13:59:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250411115939.GB323772@pevik>
References: <20250408140944.36020-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250408140944.36020-1-mdoucha@suse.cz>
X-Rspamd-Queue-Id: 28F3B21169
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Fix bug in tst_test metadata validation
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

> The results pointer is NULL when do_setup() checks tst_test metadata
> validity. Print the invalid runtime value from the correct pointer.

Ah, core dump.  Good catch, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  lib/tst_test.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 9a23cd4a0..694861d95 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1267,10 +1267,8 @@ static void do_setup(int argc, char *argv[])
>  			tst_test->timeout);
>  	}

> -	if (tst_test->runtime < 0) {
> -		tst_brk(TBROK, "Invalid runtime value %i",
> -			results->runtime);
> -	}
> +	if (tst_test->runtime < 0)
> +		tst_brk(TBROK, "Invalid runtime value %i", tst_test->runtime);

>  	if (tst_test->tconf_msg)
>  		tst_brk(TCONF, "%s", tst_test->tconf_msg);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
