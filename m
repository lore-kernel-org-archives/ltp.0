Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46549C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 15:35:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AFCD3CE81C
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 16:35:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17DC53CC301
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 16:35:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 698A71000DB0
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 16:35:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D0551FD15;
 Wed,  3 Jan 2024 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704296116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbpLZyKYJlqvzzczpliXyslU7kOmE7h3Y7UKrXT87cM=;
 b=IYGq6o7PUs8pH2wN3yWICSgUUhgHHYmT9hcalqDGYFU8JCMzhLIML5tHGVYLnKxLHPuGsj
 0jcXLjW+SUWZ/yO/aCScg+r6ZavyFQBORuXG2lFv8BRKUSXFUP+DFZaFFFp50Yo0iwZyix
 iZzn4m/xT3+2sb4VNctWevevKcLsEB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704296116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbpLZyKYJlqvzzczpliXyslU7kOmE7h3Y7UKrXT87cM=;
 b=3ASXElnML+Nw/pv/keLop0gDykR+pUwHBD/jfB4FUQS9mRHGDunoqa3qgyjlMTIQE0dgUt
 hXUQSk7gl+ouu0AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704296116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbpLZyKYJlqvzzczpliXyslU7kOmE7h3Y7UKrXT87cM=;
 b=IYGq6o7PUs8pH2wN3yWICSgUUhgHHYmT9hcalqDGYFU8JCMzhLIML5tHGVYLnKxLHPuGsj
 0jcXLjW+SUWZ/yO/aCScg+r6ZavyFQBORuXG2lFv8BRKUSXFUP+DFZaFFFp50Yo0iwZyix
 iZzn4m/xT3+2sb4VNctWevevKcLsEB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704296116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbpLZyKYJlqvzzczpliXyslU7kOmE7h3Y7UKrXT87cM=;
 b=3ASXElnML+Nw/pv/keLop0gDykR+pUwHBD/jfB4FUQS9mRHGDunoqa3qgyjlMTIQE0dgUt
 hXUQSk7gl+ouu0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F6141398A;
 Wed,  3 Jan 2024 15:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BNhEHbR+lWXMXAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 15:35:16 +0000
Date: Wed, 3 Jan 2024 16:35:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZZV-zZUu9L1jsFB3@yuki>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.14 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.05)[59.44%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IYGq6o7P;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3ASXElnM
X-Rspamd-Queue-Id: 9D0551FD15
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] libltpswap: Add get_maxswapfiles api
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
> +
> +/*
> + * Get kernel constant MAX_SWAPFILES value
> + */
> +unsigned int get_maxswapfiles(void);

Also this has to be with tst_ as well, I would name it simply
tst_max_swapfiles().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
