Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43575C88E7F
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 14:47:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A1BC3E8CA0
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 16:46:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56E713E48AE
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 16:46:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0BEE600934
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 16:46:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7162721D4D;
 Tue, 15 Sep 2026 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789483596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RLS+Gt1EbKQ5t9QGm9ZPLy0BH+i51wlxIFcdQzZFWT0=;
 b=AWCaRKA7nKmAsm0i5dwnj/g4BMaGY2ExZBTknswu0Fg+08vEJdvMkiHGvaWav/+bFIphH6
 Rihe933+s/4M7zcPvFwo7UXe692ZhXmqHBw11Z6lUSypFl17EyoxmnWl3HDNpZGho1Ke4V
 javFLPtzKyxGtZmb2yRvyaBA5sjDWQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789483596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RLS+Gt1EbKQ5t9QGm9ZPLy0BH+i51wlxIFcdQzZFWT0=;
 b=84WghzqzS8zjDgIMlkhARBvDQCnVtlfarC1c4O4UiA6s+HbuHwMvC7s4GgO+M3NaHu/pXI
 zhzMjcBeoe1vPxCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3VpndfJf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=98+55q9z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789483592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RLS+Gt1EbKQ5t9QGm9ZPLy0BH+i51wlxIFcdQzZFWT0=;
 b=3VpndfJfcdVoaIh1/xyM2LwRp5GX1rM8ScTQrHrv6U+uct70Ji+3gNP34Uxp1oVpmX+cBJ
 bK5QuWmhI3lUWe2RXpgqIJIAbeVp8zhXvfKrmSqOdIsvspUfjAznSkhfRp3rAi3j2EKtg6
 VASlt09yCELnakwiDD7VMcpIZsMfCyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789483592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RLS+Gt1EbKQ5t9QGm9ZPLy0BH+i51wlxIFcdQzZFWT0=;
 b=98+55q9zQGTwDdeuAhtaCSlaxY43DUTg6+NCjn3ZS5OqSl2iLaSvHKjXaUH+LGRU/n2F4k
 g4PORuPwGBs6ncCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B07A13432;
 Tue, 15 Sep 2026 14:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kcRVMEdaqWqWSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Sep 2026 14:46:31 +0000
Date: Tue, 15 Sep 2026 16:46:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Linux Test Project <ltp@lists.linux.it>
Message-ID: <20260915144629.GA1724177@pevik>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-4-43b78b15ef9f@suse.com>
 <aqO3RPWN_VlpnkRq@yuki.lan> <20260915144014.GA1722246@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260915144014.GA1722246@pevik>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7162721D4D
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 04/33] keyctl12: Test KEYCTL_DESCRIBE with too
 small buffer
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi!
> > > +static void run(void)
> > > +{
> > > +	size_t i;
> > > +
> > > +	memset(buf, 0xAA, sizeof(buf));
> > > +	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)buf,
> > > +				    desc_len - 1, 0), desc_len);
> > > +	if (!TST_PASS)
> > > +		return;
> > > +
> > > +	for (i = 0; i < sizeof(buf); i++) {
> > > +		if (buf[i] != (char)0xAA) {
> > > +			tst_res(TFAIL,
> > > +				"too small buffer was written to at offset %zu",
> > > +				i);
> > > +			return;
> > > +		}
> > > +	}

> > It may make sense to loop this with:

> > 	for (buf_len = 0; buf_len < desc_len; buf_len++) {
> > 		...
> > 	}

> > It should be fast and would increase the coverage..

> I suppose you want to check the actual key description in case it's longer than
> buffer size.

> desc_len is 12, sizeof(buf) is 64 therefore it's safe but I'll change it in v3
> so that it works in case of a longer key in the future.

Well, I thought I'd use

for (i = 0; i < desc_len; i++) {

but that could be problematic if desc_len (keyctl() return value) is higher
sizeof(buf). Maybe I did not get what you meant.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
