Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3B7E99057
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 08:53:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D4283E269D
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 10:53:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17EB93E1434
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 10:53:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 148591400DBD
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 10:53:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 533825BCE2;
 Fri, 10 Apr 2026 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775811192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YiGaW3YacK13wRYNUwjvl92SdQ7NY8IEDCZP8lVgjUs=;
 b=J6V0f6sf9xgM3wuiGDcvwMED1H1hCe5TliZW5ptFwnrFbD+qPfGCyjofgC3TBPQ4ZWcoug
 i+GiDqy8qeMBRPk+qze7IdsLfr/Z5KgrxZQ1tfA01TBvOGixQAlGskHiyhAxDLpYdZegxS
 ufOgQEK2eESu0P5+2+Po0MqisQmpMMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775811192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YiGaW3YacK13wRYNUwjvl92SdQ7NY8IEDCZP8lVgjUs=;
 b=bdCNLwSuNKVZTkqBFkhBOyS3BztxchyfIdrJ27/jA5WA3ysAdkhhD/JgmMthkgzcEXsVo5
 PaV3XsEn7nbHLIAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J6V0f6sf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bdCNLwSu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775811192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YiGaW3YacK13wRYNUwjvl92SdQ7NY8IEDCZP8lVgjUs=;
 b=J6V0f6sf9xgM3wuiGDcvwMED1H1hCe5TliZW5ptFwnrFbD+qPfGCyjofgC3TBPQ4ZWcoug
 i+GiDqy8qeMBRPk+qze7IdsLfr/Z5KgrxZQ1tfA01TBvOGixQAlGskHiyhAxDLpYdZegxS
 ufOgQEK2eESu0P5+2+Po0MqisQmpMMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775811192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YiGaW3YacK13wRYNUwjvl92SdQ7NY8IEDCZP8lVgjUs=;
 b=bdCNLwSuNKVZTkqBFkhBOyS3BztxchyfIdrJ27/jA5WA3ysAdkhhD/JgmMthkgzcEXsVo5
 PaV3XsEn7nbHLIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F024A0B2;
 Fri, 10 Apr 2026 08:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0jT4CHi62GnKGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Apr 2026 08:53:12 +0000
Date: Fri, 10 Apr 2026 10:53:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260410085305.GC33218@pevik>
References: <20260404014047.993528-1-wangming01@loongson.cn>
 <adYu_0Vea_Byk1EH@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adYu_0Vea_Byk1EH@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 533825BCE2
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] proc01: whitelist biba attr files returning EINVAL
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
Cc: gaojuxin@loongson.cn, ltp@lists.linux.it,
 Ming Wang <wangming01@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > proc01 already treats several attr files under /proc/self/attr and
> > /proc/self/task/*/attr as known exceptions that may return EINVAL
> > on read.

> > On systems exposing biba attr files, reads from
> > /proc/self/attr/biba/* and /proc/self/task/*/attr/biba/* also
> > return EINVAL, which makes proc01 report false failures.

> What is biba? There does not seem to be any mention of string 'biba' in
> upstream kernel. As a rule we do not add any fixes for out-of-tree
> patches to LTP.

+1, I was going to ask the same. Moreover, there is not even out-of-tree code
publicly available.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
