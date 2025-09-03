Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC40CA0FF2
	for <ltp@archiver.kernel.org>; Wed,  3 Sep 2025 13:20:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39BE73CD3E3
	for <ltp@archiver.kernel.org>; Wed,  3 Sep 2025 15:20:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61D4B3CD3C3
 for <ltp@lists.linux.it>; Wed,  3 Sep 2025 15:20:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FAB720092C
 for <ltp@lists.linux.it>; Wed,  3 Sep 2025 15:20:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A4F41F453;
 Wed,  3 Sep 2025 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756905631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iSnzZB56ET+28pCkhoYVKym/Fx5MZ7C2LM1lUFJ04Ec=;
 b=f1GobV6gcbygbg2Ho0Shz6AEAyS0hpovQkSpXfF0+PQdm0JQaJBfgn2MzyeP7uNP7JK7pL
 8839aoNNx3Qm3FvV43+HSON2kaT3sIWjbrhdQrEn0P9MAUfJgTwMqAirlcX/NJeswqhyrE
 pyHhN2J1CZ9KHhMSVBLDOVEWoEC/esY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756905631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iSnzZB56ET+28pCkhoYVKym/Fx5MZ7C2LM1lUFJ04Ec=;
 b=DIEJ+SBy1wL7s+5dUfRFoGNCg9QopZrVJZriGohJsApyyVIv65mjvM/7E71ZbDuZi3qwlI
 Ogt7oaqesx7c0FAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dHWndeVs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bQKvtb51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756905630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iSnzZB56ET+28pCkhoYVKym/Fx5MZ7C2LM1lUFJ04Ec=;
 b=dHWndeVsdonJm8eGbPnJo4IK3szqTOIJniJbEub6xPDa3QFYTvpI0M/d59hGnpGAEwpngG
 tphuErH5oNA85xbBelnGfmb78ac4p7iA8Q3Qj2X9OmcKMU8nGoRPyci8LC1BRgU9woc1cz
 5b2+q+4W7jAGI3gduDtLpUiDqi9yJKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756905630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iSnzZB56ET+28pCkhoYVKym/Fx5MZ7C2LM1lUFJ04Ec=;
 b=bQKvtb51xYSJ9/I3mdIwi+7hAQziAAzopvRhuiAIF9po1J/vnzBCiuha6omAnhDbeABA+J
 ScfDKKEn8IiYOHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BAAE13888;
 Wed,  3 Sep 2025 13:20:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 659yFZ5AuGiRPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Sep 2025 13:20:30 +0000
Date: Wed, 3 Sep 2025 15:21:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aLhAwykZPUXnH-u7@yuki.lan>
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <20250903131815.GA310083@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250903131815.GA310083@pevik>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 6A4F41F453
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
> > It's about the time we start to prepare for the September release. As
> > usuall I will go over the patches in the patchwork in the next week or
> > two. If there is something that you think should be part of the release,
> > please point it out so that I can have a look ASAP.
> 
> Cyril, I'd like to contribute 2 IMA fixes. Hopefully I'll send the patch this
> week on early next week.

Ack, that should be doable.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
