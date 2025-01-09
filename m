Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D828E7719B
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:03:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 896093C25F1
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 16:03:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 049473C20E2
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 16:03:01 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A8A711EFC43
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 16:03:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9112D210FE;
 Thu,  9 Jan 2025 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736434979;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JH9MAZpSQVp8NAkhSQaH1qiCC6hxxW4U53sCoCUTd8A=;
 b=YTHSuEc5nirauZHLr0mf9ovEDLVsT8nf6arhMZsqOgfgnYn5PTrACj5QKWW+QPXLvEZoJM
 ojVxI3H6uooALVIKJii5zTKd6ly29GrTZbaItSepGtHSv+MO7KHZNBFRiLN/oVS445gw3v
 3I5TG2Z8I2JrzZeK+34E+FKpgATTles=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736434979;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JH9MAZpSQVp8NAkhSQaH1qiCC6hxxW4U53sCoCUTd8A=;
 b=ZqwaXxUPZxFly18UhyPpCQ5IqCfq0rv5sy10dhaYvKk+T3vA7e6UFk5zcd+QMYBr1OWOUo
 E2hZf/fvHUk8LLDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YTHSuEc5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZqwaXxUP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736434979;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JH9MAZpSQVp8NAkhSQaH1qiCC6hxxW4U53sCoCUTd8A=;
 b=YTHSuEc5nirauZHLr0mf9ovEDLVsT8nf6arhMZsqOgfgnYn5PTrACj5QKWW+QPXLvEZoJM
 ojVxI3H6uooALVIKJii5zTKd6ly29GrTZbaItSepGtHSv+MO7KHZNBFRiLN/oVS445gw3v
 3I5TG2Z8I2JrzZeK+34E+FKpgATTles=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736434979;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JH9MAZpSQVp8NAkhSQaH1qiCC6hxxW4U53sCoCUTd8A=;
 b=ZqwaXxUPZxFly18UhyPpCQ5IqCfq0rv5sy10dhaYvKk+T3vA7e6UFk5zcd+QMYBr1OWOUo
 E2hZf/fvHUk8LLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F168139AB;
 Thu,  9 Jan 2025 15:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ug21EyPlf2cpawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jan 2025 15:02:59 +0000
Date: Thu, 9 Jan 2025 16:02:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>
Message-ID: <20250109150257.GA353478@pevik>
References: <20240522060321.2223-1-maxj.fnst@fujitsu.com>
 <Zuk6k_8ryjwZqpO9@yuki.lan> <20250109094523.GB184406@pevik>
 <TY3PR01MB12071EE8DF7FA90BEEB2BA549E8132@TY3PR01MB12071.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TY3PR01MB12071EE8DF7FA90BEEB2BA549E8132@TY3PR01MB12071.jpnprd01.prod.outlook.com>
X-Rspamd-Queue-Id: 9112D210FE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_EQ_ADDR_SOME(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 
 =?utf-8?b?5Zue5aSNOiAgW1BBVENIXSAgcnRfc2lncXVldWVpbmZvOiBB?=
 =?utf-8?q?dd_negative_tests_for_rt=5Fsigqueueinfo?=
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr

> > Hi Ma Xinjian,

> > Gently ping.

> Thanks for the ping, but this patch has been merged into before.
> https://lore.kernel.org/ltp/Zw587CW6NtzV8es2@yuki.lan/

My bad, thanks for info, I updated patchwork status.

Kind regards,
Petr

> Best regards
> Ma

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
