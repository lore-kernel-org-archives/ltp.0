Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD40C4345F
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 09:13:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CC423CFFA1
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 11:13:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D69303CFEB3
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 11:13:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B30C31000A65
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 11:13:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 956DE5FC0B;
 Tue, 23 Apr 2024 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713863588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUzlMGlQX+RVQFMDfMsHeNe/Ow9RUvyekPvxd8kDZi4=;
 b=UjzkB24hLjEPlZH011N/8ff3XF9zm1S8yD4ZzCyP1LWcijvSVihQ6VuNLYPY3O3D9bYtnV
 r6Z9vAKfV0ikXiH+TqGLy9aEg9ub+V0ZawoJqiyR38U/mijWTPnOGJqgnlVvDrU21t242p
 UcyQR3sU8lCfAfQ7mcE8NmY5BW57Gow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713863588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUzlMGlQX+RVQFMDfMsHeNe/Ow9RUvyekPvxd8kDZi4=;
 b=swd9XjSsWV0Tv11YnTY/3JcOFRsGClWcWgouAdNh300qTSVQjbc4oCWvwq8uvvCdXXVJRK
 B62xZOV6s247VRAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UjzkB24h;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=swd9XjSs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713863588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUzlMGlQX+RVQFMDfMsHeNe/Ow9RUvyekPvxd8kDZi4=;
 b=UjzkB24hLjEPlZH011N/8ff3XF9zm1S8yD4ZzCyP1LWcijvSVihQ6VuNLYPY3O3D9bYtnV
 r6Z9vAKfV0ikXiH+TqGLy9aEg9ub+V0ZawoJqiyR38U/mijWTPnOGJqgnlVvDrU21t242p
 UcyQR3sU8lCfAfQ7mcE8NmY5BW57Gow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713863588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUzlMGlQX+RVQFMDfMsHeNe/Ow9RUvyekPvxd8kDZi4=;
 b=swd9XjSsWV0Tv11YnTY/3JcOFRsGClWcWgouAdNh300qTSVQjbc4oCWvwq8uvvCdXXVJRK
 B62xZOV6s247VRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B65313894;
 Tue, 23 Apr 2024 09:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oS+PHaR7J2Z0FwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Apr 2024 09:13:08 +0000
Date: Tue, 23 Apr 2024 11:13:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240423091305.GA123724@pevik>
References: <20240417092506.23625-1-xuyang2018.jy@fujitsu.com>
 <2150334.9o76ZdvQCi@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2150334.9o76ZdvQCi@localhost>
X-Spamd-Result: default: False [-3.69 / 50.00]; BAYES_HAM(-2.98)[99.93%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 956DE5FC0B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getrandom: Add negative tests for getrandom
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yang Xu, Avinesh,

FYI this broke in CI. Using <sys/random.h> without m4 check broke old libc
(glibc < 2.25 or musl < 1.1.20). I suggest to ignore kernel < 3.17 (we still
have 3.10 support in docs although it's not CI).

I'm on travelling, but I'll should manage to send patch today.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
