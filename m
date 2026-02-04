Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0698E9537B
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 11:57:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FF713CE0CD
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 12:56:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D20473CACD1
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 12:56:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2DF006008F0
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 12:56:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78A323E705;
 Wed,  4 Feb 2026 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770206200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBgNc68nksvKSrv98nT1pTUOCKkBbzqQ+nqaSnfdGa4=;
 b=c0oYQFUR3R0vc5bWAajtWh9nVA9g3K3w+Ib7ko2EzaSHFyZxzcP3Z3TZg4PdK3vs/kelS0
 yphRd6h9eDVZl9xvvNKiSUIV2+I3Hz4aupwkym3fBK1UW8iG2A3k4iVtXl4IwklaoeJ61w
 Jen16ZxQu0lfEOrBJWWOXr6fPfFksys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770206200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBgNc68nksvKSrv98nT1pTUOCKkBbzqQ+nqaSnfdGa4=;
 b=bLVgJ1XT1QhztZIOuTTiJZi3VvuiVwGqgSTsP6+tRlCHS5g8EKTwwG66ZDN6F2sJBgFFv7
 HajVmPRRFPouidAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c0oYQFUR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bLVgJ1XT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770206200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBgNc68nksvKSrv98nT1pTUOCKkBbzqQ+nqaSnfdGa4=;
 b=c0oYQFUR3R0vc5bWAajtWh9nVA9g3K3w+Ib7ko2EzaSHFyZxzcP3Z3TZg4PdK3vs/kelS0
 yphRd6h9eDVZl9xvvNKiSUIV2+I3Hz4aupwkym3fBK1UW8iG2A3k4iVtXl4IwklaoeJ61w
 Jen16ZxQu0lfEOrBJWWOXr6fPfFksys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770206200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBgNc68nksvKSrv98nT1pTUOCKkBbzqQ+nqaSnfdGa4=;
 b=bLVgJ1XT1QhztZIOuTTiJZi3VvuiVwGqgSTsP6+tRlCHS5g8EKTwwG66ZDN6F2sJBgFFv7
 HajVmPRRFPouidAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DF433EA63;
 Wed,  4 Feb 2026 11:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t0yREfgzg2lqOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Feb 2026 11:56:40 +0000
Date: Wed, 4 Feb 2026 12:56:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260204115638.GA224465@pevik>
References: <20260203094317.685385-1-vasileios.almpanis@virtuozzo.com>
 <DG596JIOEG2S.14PUR2IXLFTC5@suse.com> <aYMQ63RcLp5KdlVt@yuki.lan>
 <aYMXDMKoSJkRWUrE@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aYMXDMKoSJkRWUrE@redhat.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 78A323E705
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runltp: fix regex for disabled testcases
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Kirk has been stable for some time, I suppose that it's about the time
> > we finally remove runltp from LTP.

> +1

Very good point, patchset posted:
https://lore.kernel.org/ltp/20260204115339.224261-1-pvorel@suse.cz/T/#t
https://patchwork.ozlabs.org/project/ltp/list/?series=490958&state=*

Kind regards,
Petr

> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
