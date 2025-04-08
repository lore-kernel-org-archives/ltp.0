Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7AAC369A4
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 11:11:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 363DB3CB37E
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:11:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33F393C1948
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:10:45 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 42DE12003B5
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:10:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 32F842111F;
 Tue,  8 Apr 2025 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744110643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jloBitp0bD/4N9+I3VwS4leIPpXjsVFnCOsnrEyyFTA=;
 b=ZLdd9VjV2jtnryEoKbrW3icNX6HjqxFxUtOBcXs+Cu84/5dLXPi+su6w/nymhSMsFxXLDs
 czuNIrNe+7BQHwac3jBjtcMc8dqR/Kbyq6kJOlTbnRZaf53BKTofHDQVsRQYxRp4vDF2E7
 HCPCrf5szAj1kq2HORR2oTxiKs/5XFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744110643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jloBitp0bD/4N9+I3VwS4leIPpXjsVFnCOsnrEyyFTA=;
 b=jvfNn+zF3qW7juBKtC6ngAEjegmIdfAi6emnCVV2lgZ4UEOi8DojR1w9TxdxnxwuslvKwX
 +v0SMl5rrpqvh0CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZLdd9VjV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jvfNn+zF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744110643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jloBitp0bD/4N9+I3VwS4leIPpXjsVFnCOsnrEyyFTA=;
 b=ZLdd9VjV2jtnryEoKbrW3icNX6HjqxFxUtOBcXs+Cu84/5dLXPi+su6w/nymhSMsFxXLDs
 czuNIrNe+7BQHwac3jBjtcMc8dqR/Kbyq6kJOlTbnRZaf53BKTofHDQVsRQYxRp4vDF2E7
 HCPCrf5szAj1kq2HORR2oTxiKs/5XFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744110643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jloBitp0bD/4N9+I3VwS4leIPpXjsVFnCOsnrEyyFTA=;
 b=jvfNn+zF3qW7juBKtC6ngAEjegmIdfAi6emnCVV2lgZ4UEOi8DojR1w9TxdxnxwuslvKwX
 +v0SMl5rrpqvh0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E31AB13691;
 Tue,  8 Apr 2025 11:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X/ggNjIE9Wc0BQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 08 Apr 2025 11:10:42 +0000
Date: Tue, 8 Apr 2025 13:10:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250408111037.GB180787@pevik>
References: <20250407150133.115790-1-pvorel@suse.cz>
 <20250407150133.115790-4-pvorel@suse.cz>
 <a2197905-94b2-4f84-a19a-fb26b2ff65f4@suse.com>
 <20250408101412.GA174986@pevik>
 <fa9a3fe9-1ea4-4dfa-bc29-9897026e4122@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa9a3fe9-1ea4-4dfa-bc29-9897026e4122@suse.com>
X-Rspamd-Queue-Id: 32F842111F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/3] doc/Makefile: Allow to create and use .venv
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
Cc: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Ricardo,

FYI patchset merged.
Thanks for your review!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
