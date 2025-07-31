Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E15C87FCA
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 14:14:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C74973CBF27
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 16:14:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9673B3C9F61
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 16:14:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 291C26009F9
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 16:14:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65E3D1F807;
 Thu, 31 Jul 2025 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753971249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ZLLaFepC8s7MEeUyBCDe0AMGvbUtYx1MUC8SMR75vU=;
 b=f3e0AGDT1EOJaGSbEN6BOGgFhdxl6qGB+jdiW+8HjbYjPlvkSdrM2kJ4y1/4ECCUKW6SIn
 K35UlVrQ+Ziqh3SwlUXBTcNm69pA+uDMlo7yuzZf9nag4Wib/N3SpeqUJ68WPRLfxwrBN7
 4HDqk0xQEFmazskH4VE/T+Ash8Q98rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753971249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ZLLaFepC8s7MEeUyBCDe0AMGvbUtYx1MUC8SMR75vU=;
 b=w7/amVW67HUn0fozADGqdczeow6qK+u1Vg3mY672RIPZkerOgztdKvjdf2+mkjEiNhxmZQ
 /KD6+kMWb1Xty0AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753971249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ZLLaFepC8s7MEeUyBCDe0AMGvbUtYx1MUC8SMR75vU=;
 b=f3e0AGDT1EOJaGSbEN6BOGgFhdxl6qGB+jdiW+8HjbYjPlvkSdrM2kJ4y1/4ECCUKW6SIn
 K35UlVrQ+Ziqh3SwlUXBTcNm69pA+uDMlo7yuzZf9nag4Wib/N3SpeqUJ68WPRLfxwrBN7
 4HDqk0xQEFmazskH4VE/T+Ash8Q98rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753971249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ZLLaFepC8s7MEeUyBCDe0AMGvbUtYx1MUC8SMR75vU=;
 b=w7/amVW67HUn0fozADGqdczeow6qK+u1Vg3mY672RIPZkerOgztdKvjdf2+mkjEiNhxmZQ
 /KD6+kMWb1Xty0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34AF213A43;
 Thu, 31 Jul 2025 14:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SNnaCzF6i2jQewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 31 Jul 2025 14:14:09 +0000
Date: Thu, 31 Jul 2025 16:14:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250731141407.GA771928@pevik>
References: <20250731082400.1044073-1-ben.copeland@linaro.org>
 <aIt3iDeT3Memtmem@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aIt3iDeT3Memtmem@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] vma05: Fix false positives from stripped
 system libraries
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
Cc: dan.carpenter@linaro.org, lkft-triage@lists.linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ben, all,

FYI merged. Ben, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
