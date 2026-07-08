Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BE1C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 12:31:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 758C63E5CA7
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 14:31:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E8D73E2788
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 14:31:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 912111400C78
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 14:31:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5BEBF75F0F;
 Wed,  8 Jul 2026 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783513860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6ayXBy6ONu7dvDXXThns2E1DlDHfmcxWhMkrEwKM1M=;
 b=0GU+2MAi2cE4aQqGmhbXyxhAzk6ngdpGaOfyAClDPcU8Ca5aqqRFO2xnafd7sgmIHRedkB
 aiZf0j2MbBTnJpXAaEfPZzwJBmBYMfZPHNs6br8OdES05tDj8v9gFylzn0m4nqhI104VxF
 YIWnYpWi+t44Yx7w+LAkdDyMwkzI/U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783513860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6ayXBy6ONu7dvDXXThns2E1DlDHfmcxWhMkrEwKM1M=;
 b=UalDSeH5FYoHLb9pW+V8rSkQtcTLwrGHU/bjaS801J16MAQe0JwXCOxOWmNliGhdYQ9RVY
 7XbGB+1/a0U0asDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0GU+2MAi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UalDSeH5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783513860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6ayXBy6ONu7dvDXXThns2E1DlDHfmcxWhMkrEwKM1M=;
 b=0GU+2MAi2cE4aQqGmhbXyxhAzk6ngdpGaOfyAClDPcU8Ca5aqqRFO2xnafd7sgmIHRedkB
 aiZf0j2MbBTnJpXAaEfPZzwJBmBYMfZPHNs6br8OdES05tDj8v9gFylzn0m4nqhI104VxF
 YIWnYpWi+t44Yx7w+LAkdDyMwkzI/U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783513860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6ayXBy6ONu7dvDXXThns2E1DlDHfmcxWhMkrEwKM1M=;
 b=UalDSeH5FYoHLb9pW+V8rSkQtcTLwrGHU/bjaS801J16MAQe0JwXCOxOWmNliGhdYQ9RVY
 7XbGB+1/a0U0asDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B7C3779AE;
 Wed,  8 Jul 2026 12:31:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XhQ5EQRDTmr/CwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jul 2026 12:31:00 +0000
Date: Wed, 8 Jul 2026 14:30:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Message-ID: <ak5C_StwTDuJFs6W@yuki.lan>
References: <20260701110038.175976-1-vasileios.almpanis@virtuozzo.com>
 <akzVEOMWp6p1NSr5@yuki.lan>
 <3717ecd4-8218-4a71-8e37-119300dc8a11@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3717ecd4-8218-4a71-8e37-119300dc8a11@virtuozzo.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5BEBF75F0F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] df01: detect "fuse" fstype in addition to
 "fuseblk"
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
> >>   setup()
> >>   {
> >> -	DF_FS_TYPE="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk)" /proc/mounts | awk 'NR==1{print $3}')"
> >> +	DF_FS_TYPE="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk|fuse)" /proc/mounts | awk 'NR==1{print $3}')"
> > fuse is a substring of fuseblk so just ($TST_FS_TYPE|fuse) should
> > suffice, right?
> 
> Hi Chris, looking at it again, yes you are right just fuse would catch 
> both cases. I see the patch is already in master
> do you want me to send another one or shall we leave it as it is?

Just send a patch againts latest git head that removes the fuseblk.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
