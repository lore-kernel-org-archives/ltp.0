Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487E3CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:08:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC71C3E5F71
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:08:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DD6C3CE0D0
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:08:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CBB6E1A00701
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:08:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0919C5D902;
 Thu,  7 May 2026 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778144882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uy6Qq+llb5ARkm+aDEYjWSODNMdSfVJn11afrn2eJ08=;
 b=uKs/5qGD5qgep5zIm4A2BDpollh2BPg+iBdVKulbYp0pLp2Z5OBEvWK192WYCoT09EFtT6
 LnPbMlAW8C06cCfPUESvfirocHwB2TVbmLxxA0Kwb8TgOvt9I123rm5JDxJ6R0hKnnZiln
 FP1Hskck8z8LbSR8vr/Dyy5M0nZcgTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778144882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uy6Qq+llb5ARkm+aDEYjWSODNMdSfVJn11afrn2eJ08=;
 b=6BRcDYAghkzZ5ggzpoLXOzk2lgfLynawsGSWs4Oq+YAR8PcoPNbTCtAh6VONzULQPlrfZB
 1SQ7N+j2Ib/Sq9AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VHen6xzf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y130kTtH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778144878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uy6Qq+llb5ARkm+aDEYjWSODNMdSfVJn11afrn2eJ08=;
 b=VHen6xzfVipl8a4+rhWjatySRHXWRdlJ103wNgfG/w+bR4RR9I1sVpw/DjlIsKVsNx4JxX
 Ic2oGzMZWmBZ8476zmZxyz9HEXWfWPp1yPDe5Z8KnLrFqw/AReiUJj9EIT1Re1mlELBD4g
 liXdoQpi7+PNUA9cnnDOBAzZ15KQeYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778144878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uy6Qq+llb5ARkm+aDEYjWSODNMdSfVJn11afrn2eJ08=;
 b=Y130kTtHbNeWdarB5ZRK307IZlnQic+qLpPJjtFVs1QJnEvFTCzC3mXwjArNhSuFhrHNQ9
 GBrxHJaq5f8iB+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB2CC593A7;
 Thu,  7 May 2026 09:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WeZ4N21W/GlHbAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 07 May 2026 09:07:57 +0000
Date: Thu, 7 May 2026 11:08:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: pvorel@suse.cz, ltp@lists.linux.it
Message-ID: <afxWcDzTeqwPUvGN@yuki.lan>
References: <20260430091956.10915-1-chrubis@suse.cz>
 <afMwMO1yTBGDLQJc@linux.dev> <afNQuLNeBcYC_zAG@yuki.lan>
 <afvkSly0fxGwFiLY@linux.dev> <afw4Kz6SLbzZ1EKj@yuki.lan>
 <afxQIR7bdmlJmCIr@linux.dev> <afxVF3S-m9zDuZnF@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afxVF3S-m9zDuZnF@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, yuki.lan:mid]
X-Rspamd-Queue-Id: 0919C5D902
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_test: tst_reinit() abort when already
 initialized
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I look into Petr's patch, seems we can go another way to replace
> the checkpoint method.

I would rather change the binary to use TST_NO_DEFAULT_MAIN. It's not a
test, just a helper binary, the tst_test structure shouldn't have been
used to begin with.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
