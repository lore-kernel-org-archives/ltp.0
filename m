Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1E8C3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 20:05:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DD103CFE27
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 21:04:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEC953C1CE0
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 21:04:43 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 387E060129A
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 21:04:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CF551FD12;
 Mon,  8 Jan 2024 20:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704744281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1UnimpeKSw4rKpdjkNSV6BvcUf/czK6HMI0cxCsTQQ=;
 b=jUvzH9W8tjdeM/ehEkxk+0vJvIsdoePkRui71tmPGgUBnCjcMR8+S/FZ7npwLHJiNDumZq
 qfzuFH0X2d9RK/rJkAyNZaKgAjjGFx10zjRvJ1BgGay5D2iX+wn2vCFtlCUDymhjLjcJfp
 JOVzEuGolx/zCGj3fpg3uxpWS/hE6xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704744281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1UnimpeKSw4rKpdjkNSV6BvcUf/czK6HMI0cxCsTQQ=;
 b=ev5vTR3nBC6fuEMlOYO/RpezQopITbzQPJo8Ah/Hcm2HL0sLNNFhClPG6h4BS6Bt4XTCS/
 gr+LnGUpoWVAR1CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704744281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1UnimpeKSw4rKpdjkNSV6BvcUf/czK6HMI0cxCsTQQ=;
 b=jUvzH9W8tjdeM/ehEkxk+0vJvIsdoePkRui71tmPGgUBnCjcMR8+S/FZ7npwLHJiNDumZq
 qfzuFH0X2d9RK/rJkAyNZaKgAjjGFx10zjRvJ1BgGay5D2iX+wn2vCFtlCUDymhjLjcJfp
 JOVzEuGolx/zCGj3fpg3uxpWS/hE6xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704744281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1UnimpeKSw4rKpdjkNSV6BvcUf/czK6HMI0cxCsTQQ=;
 b=ev5vTR3nBC6fuEMlOYO/RpezQopITbzQPJo8Ah/Hcm2HL0sLNNFhClPG6h4BS6Bt4XTCS/
 gr+LnGUpoWVAR1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B31313686;
 Mon,  8 Jan 2024 20:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9ks8ElhVnGXAMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Jan 2024 20:04:40 +0000
Date: Mon, 8 Jan 2024 21:04:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240108200438.GA1599609@pevik>
References: <20231207194011.273027-1-pvorel@suse.cz>
 <ZZvK9OL6MduUpWZQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZvK9OL6MduUpWZQ@yuki>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8CF551FD12
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jUvzH9W8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ev5vTR3n
X-Spamd-Result: default: False [-2.21 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.00)[44.47%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[12];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,redhat.com,fujitsu.com,linux.dev,vger.kernel.org,gmail.com,suse.cz];
 RCVD_TLS_ALL(0.00)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] Add support bcachefs filesystem
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
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> I suppose that it's fine to merge the first two patches to enable
> bcachefs in LTP before there release.

> For the first two patches:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks a lot, merged these two. We now have bcachefs support in LTP :).


> For the last patch that disables check for STATX_ATTR_COMPRESSED it
> looks like this is missing plumbing in bcachefs so I would avoid adding
> workarounds into LTP for now.

Sure, it makes sense. Hopefully Kent finds time to fix it soon.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
