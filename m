Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFA6C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 09:10:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC8D33CEE19
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 10:10:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5A543CB3D1
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 10:09:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 094741400DCC
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 10:09:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F771221A1;
 Thu, 14 Dec 2023 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702544993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eJzhd7GYCdgZ85V1jyG4nCrlQoIh8wUMX3JJWQEOsrM=;
 b=pc+V2NtCUOS5xy4YU3ojFBfC92mVXd3hMjY4b0cWpxcM8NsNmG/N3D80P+yzZfpqgOTncC
 4tntaMYh8ScqpJCSrUU/Bn+DB3VaqZPo0YQq5HvUp1Wwxy5WjL/SHNsGxdAwU8wNcox0ey
 BbiosX7hvujzrpmO4Y1n68rrfhmNpDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702544993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eJzhd7GYCdgZ85V1jyG4nCrlQoIh8wUMX3JJWQEOsrM=;
 b=1AFBoQXRQmf9wY9zzYBrmUO9z4Sp5nvN6fdTdsvp34yKL+/T4hYpCUcTRQF2J0b6yccFlW
 BFl2f1bAYMU1j4CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702544993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eJzhd7GYCdgZ85V1jyG4nCrlQoIh8wUMX3JJWQEOsrM=;
 b=pc+V2NtCUOS5xy4YU3ojFBfC92mVXd3hMjY4b0cWpxcM8NsNmG/N3D80P+yzZfpqgOTncC
 4tntaMYh8ScqpJCSrUU/Bn+DB3VaqZPo0YQq5HvUp1Wwxy5WjL/SHNsGxdAwU8wNcox0ey
 BbiosX7hvujzrpmO4Y1n68rrfhmNpDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702544993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eJzhd7GYCdgZ85V1jyG4nCrlQoIh8wUMX3JJWQEOsrM=;
 b=1AFBoQXRQmf9wY9zzYBrmUO9z4Sp5nvN6fdTdsvp34yKL+/T4hYpCUcTRQF2J0b6yccFlW
 BFl2f1bAYMU1j4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AA2E137E8;
 Thu, 14 Dec 2023 09:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Wd3YFWHGemWXRAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 14 Dec 2023 09:09:53 +0000
Date: Thu, 14 Dec 2023 10:09:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZXrGTkJIh4YluH3T@rei>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-2-pvorel@suse.cz> <ZXoAKxPxfXxU8bxw@rei>
 <20231213234044.GA774490@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213234044.GA774490@pevik>
X-Spamd-Result: default: False [6.17 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(0.18)[0.061];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.cz];
 R_SPF_SOFTFAIL(4.60)[~all:c]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[27.78%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: ++++++
X-Rspamd-Queue-Id: 6F771221A1
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pc+V2NtC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1AFBoQXR;
 dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of chrubis@suse.cz)
 smtp.mailfrom=chrubis@suse.cz
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib/tests: Add test for testing tst_res()
 flags
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Maybe it would make sense the loop over the flags here instead, so that
> > we don't have to produce second TPASS message.
> 
> I'm not sure if I follow you. I wanted to use the flag in tst_res(),
> but for these two there would be tst_brk(TBROK) due missing result.

I mean that if we put TBROK last in the array we can do:

	for (i = 0; i < ARRAY_SIZE(...); i++)
		tst_res(....);

I.e. loop over all the flags in a single call of the function, which
would mean that we do not have to add artificial TPASS at the end.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
