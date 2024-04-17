Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB9FC001CC
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 06:06:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A002E3CFB29
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 08:06:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 916B73CFAF4
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 08:06:07 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E6DFB208F62
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 08:06:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 685543384B;
 Wed, 17 Apr 2024 06:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713333964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KROTX0Q16Ahgzd3HZibmbSBYFeGfzQrWOq5vZhC2HJk=;
 b=l3E42JSSeH+vNRR92/D428+i3wC/bEC8CV9Z0Q9hrBYLIZeEMD3EJGceQsY3thyj7iP9/a
 ml7s3CIzEbdnQPGx0k0VzKGCYRKpT6/IY2rSLDjgpBxPgvepYZjlNfgdBdK0vx4E5aOrrl
 MrjgTbAd7YxsWIj6vjbEbUJHQy38i+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713333964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KROTX0Q16Ahgzd3HZibmbSBYFeGfzQrWOq5vZhC2HJk=;
 b=m9ylETVd2AxC+2raBK/wM/J9KC7jW0urIbx3VgAtC+UoKmgLmensB0sLWErJf6c9ffiIRX
 dgTm+ojduT4rBOBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l3E42JSS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=m9ylETVd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713333964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KROTX0Q16Ahgzd3HZibmbSBYFeGfzQrWOq5vZhC2HJk=;
 b=l3E42JSSeH+vNRR92/D428+i3wC/bEC8CV9Z0Q9hrBYLIZeEMD3EJGceQsY3thyj7iP9/a
 ml7s3CIzEbdnQPGx0k0VzKGCYRKpT6/IY2rSLDjgpBxPgvepYZjlNfgdBdK0vx4E5aOrrl
 MrjgTbAd7YxsWIj6vjbEbUJHQy38i+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713333964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KROTX0Q16Ahgzd3HZibmbSBYFeGfzQrWOq5vZhC2HJk=;
 b=m9ylETVd2AxC+2raBK/wM/J9KC7jW0urIbx3VgAtC+UoKmgLmensB0sLWErJf6c9ffiIRX
 dgTm+ojduT4rBOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA64B1384C;
 Wed, 17 Apr 2024 06:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LkJ+N8tmH2a5EAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 06:06:03 +0000
Date: Wed, 17 Apr 2024 08:06:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240417060602.GB681570@pevik>
References: <20240415172133.553441-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240415172133.553441-1-pvorel@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 685543384B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] proc01: Whitelist
 /proc/fs/nfsd/nfsv4recoverydir
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> /proc/fs/nfsd/nfsv4recoverydir started from kernel 6.8 report EINVAL.

Because Neil sent fix, I withdraw this patch.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-nfs/171330258224.17212.9790424282163530018@noble.neil.brown.name/


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
