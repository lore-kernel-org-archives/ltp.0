Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA43C3DA7F
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 10:40:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8394E3D1E51
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 12:40:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E40613CB133
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 12:40:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55D4F1001191
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 12:40:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8C941F834;
 Wed, 31 Jul 2024 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722422409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pFIRxADrFXy7XaAh8HZDUT/EyGpjHXJj1wMI7eLQEp8=;
 b=XmcnYhahkQa4t8fPNlfFSbF+MNRC6ALH4SqWiAAHwQJs+YlOSYMXR+VUg5W/3ImycS6TDH
 ZSFO2EYiVcj/6udxJeG0GSXfqNheQBdN6l5PcczU6CSnofrzxu6e1SKQLMKdOiW3OBPemH
 jQK+GQX2vV89Pk8fngWc4K2lQoXMw1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722422409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pFIRxADrFXy7XaAh8HZDUT/EyGpjHXJj1wMI7eLQEp8=;
 b=D1VkKE77GxWQsDk+hf7/ldIBV4GGXFK+RKzyWLrFPSIm1zdwN+jJF3OKK0wtnb6z5UGTSg
 O0WJtSsyNt232eCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XmcnYhah;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D1VkKE77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722422409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pFIRxADrFXy7XaAh8HZDUT/EyGpjHXJj1wMI7eLQEp8=;
 b=XmcnYhahkQa4t8fPNlfFSbF+MNRC6ALH4SqWiAAHwQJs+YlOSYMXR+VUg5W/3ImycS6TDH
 ZSFO2EYiVcj/6udxJeG0GSXfqNheQBdN6l5PcczU6CSnofrzxu6e1SKQLMKdOiW3OBPemH
 jQK+GQX2vV89Pk8fngWc4K2lQoXMw1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722422409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pFIRxADrFXy7XaAh8HZDUT/EyGpjHXJj1wMI7eLQEp8=;
 b=D1VkKE77GxWQsDk+hf7/ldIBV4GGXFK+RKzyWLrFPSIm1zdwN+jJF3OKK0wtnb6z5UGTSg
 O0WJtSsyNt232eCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98AA613297;
 Wed, 31 Jul 2024 10:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mdVCJIkUqmazLwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 31 Jul 2024 10:40:09 +0000
Date: Wed, 31 Jul 2024 12:39:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZqoUaJ4sc30EHzNm@yuki>
References: <20240731073403.1406035-1-pvorel@suse.cz> <ZqoSvzmu3vmJugC7@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqoSvzmu3vmJugC7@yuki>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,linux.it:url];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A8C941F834
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] cachestat01: Reduce required space on 64kb
 page size
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
> > +	num_shift = MIN(tst_device->size*1024*2.6/page_size, 15);
> 
> I guess that we can make it future proof by rounding the 2.6 to 3 just

And that is on the wrong side obviously, so we should do rounding down
to 2 or 2.2 or something along the lines.

> to avoid failures in the future when filesystems consume just a bit more
> space for a metadata...
> 
> Other than that:
> 
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> 
> >  	page_data = SAFE_MALLOC(page_size);
> >  	memset(page_data, 'a', page_size);
> >  }
> > -- 
> > 2.45.2
> > 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
