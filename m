Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EF7C982DA
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 11:30:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E31C3EA16A
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 13:30:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 538A63E5814
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 13:29:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E138A200B09
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 13:29:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F3741F750;
 Fri, 18 Sep 2026 11:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789730987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPQY1xOkNgdAmkK4gDjSZQ+4npL8i4kTmSTuDr/5JZg=;
 b=ttqFnf1EYcnUQeLhQDeuPIwZhU1Bav7b4Jr7wP5hDYPLmd/RNqxJSWUB+wy+9bpWcEpUe6
 D5n2XxRHXlYJ9twJNSkAhOs8Nk6l9C9UQUitn4nt/+M3vmehj0ixAyjj/w3JiWh92Cpagp
 Y7QXsycrU6IpREBr8S87vgBRZMAIWF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789730987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPQY1xOkNgdAmkK4gDjSZQ+4npL8i4kTmSTuDr/5JZg=;
 b=e/TO9dMR2JmNmfr76h5l+bodQ6y8lDGlOo08zYtvmQBr92G/qupuHCrJYFvvljNk/9cHEe
 TMxfLawnvYIIP8CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zGEbXg7h;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="+n3Vh/pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789730983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPQY1xOkNgdAmkK4gDjSZQ+4npL8i4kTmSTuDr/5JZg=;
 b=zGEbXg7hxs6zijdv6gPxckE9Y2u+qGgQ6REd0wYNtDN/MJiVcP2Yp/sB3p/wG+T9E6HHoM
 SvIEnFIdhPfQX7w4OA0vsGf3+3k1cNVtTP+rPJ5kTJc5YBqAaTwMrACvKFzyxeSUkop9Td
 /pn6frnwkmaQ7leU+ghoo2B1k1X+iF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789730983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPQY1xOkNgdAmkK4gDjSZQ+4npL8i4kTmSTuDr/5JZg=;
 b=+n3Vh/pnyZxs6VHWY7uFVMX3o3xMbHoMiL2ilp3Vp2PRcwAErKcePGK+fAx287NpumYEQ/
 AmuA9S2doecA3MAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2C0C1348F;
 Fri, 18 Sep 2026 11:29:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ih7vMqYgrWpLPQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 18 Sep 2026 11:29:42 +0000
Date: Fri, 18 Sep 2026 13:29:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aq0gstynvNDWpGrr@yuki.lan>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-17-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-17-pvorel@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2F3741F750
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 16/36] keyctl22: Test KEYCTL_RESTRICT_KEYRING
 reject-all
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
> +static void run(void)
> +{
> +	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, ring_reject, 0, 0, 0));
> +	if (TST_RET == 0)
> +		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING with NULL type and restriction passed");
> +	else if (TST_RET == -1 && TST_ERR == EEXIST)
> +		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING reject-all already active");
> +	else
> +		tst_res(TFAIL | TTERRNO, "KEYCTL_RESTRICT_KEYRING reject-all failed");

This test should have the -i 2 enabled by default as well.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
