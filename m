Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F38C47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 13:22:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49EBB3CE30B
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 14:22:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2545D3CB05E
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 14:22:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6A9E14094E0
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 14:22:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA7901FC11;
 Wed, 17 Jan 2024 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705497729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78KfotDcwzotLMd8ajam8soY0o3YvWemHYn8I8RtdSE=;
 b=0G3KEfc3k9+lRxRYsFWlJ9wezY8T5gibuCqmO9HBHsFq7tkwfsufsRdlLbw9CqdWcOAsyr
 jib7GxmU3budaO8rJ00Ic+9tQy05tK5dxqJuzdEL6eubdMvPVSuHy32VA65GBYkp38MLV6
 f9SuKdIwOIt4XK5bp80Iukp8ctCbyWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705497729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78KfotDcwzotLMd8ajam8soY0o3YvWemHYn8I8RtdSE=;
 b=OOzEh5++1iRrHl4jCPIu96BLbt+F9BLP4XIcID6A7o/hJZ3BtlBWkxhBdmjq7F47ySDIJ+
 u9CJFRJ2k+yXssAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705497728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78KfotDcwzotLMd8ajam8soY0o3YvWemHYn8I8RtdSE=;
 b=nZexqStkSkF5SJcXZt8jBiD+f54owEIoq01kwBnk7tXWtdpByKBlF4iFARtqbiBAx6HB0L
 74MadqBEf0pmPkJ0NKS9fXRcLPtPGrsgj240rtlJPohf2ok89H1d74k1YIhKJ64mo4CeAp
 hHUpRUywbx1tIvEy29QlpoJgceVvOv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705497728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78KfotDcwzotLMd8ajam8soY0o3YvWemHYn8I8RtdSE=;
 b=uxxfEDNfpRt/VYYQMG4kcS0NZNeYJNRJ7ouNu2ed42/pBBkDuq+PyAYKArix5jItTp/psi
 DEplCfgWN39OmFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F97713800;
 Wed, 17 Jan 2024 13:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z2z5JYDUp2XjawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jan 2024 13:22:08 +0000
Date: Wed, 17 Jan 2024 14:22:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <petr.vorel@gmail.com>
Message-ID: <ZafUiVgWlzv8nXSQ@yuki>
References: <20231031125114.5879-1-chrubis@suse.cz>
 <20240109192444.GA1670891@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240109192444.GA1670891@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nZexqStk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uxxfEDNf
X-Spamd-Result: default: False [0.16 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-1.53)[91.96%];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FREEMAIL_TO(0.00)[gmail.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BA7901FC11
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: add sched sysctl sanity test
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
Cc: chrubis@suse.com, pvorel@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The rest LGTM, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Fixed all the problems and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
