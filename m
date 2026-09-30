Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3D3CA5FC7
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 14:29:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C421B3E5694
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 16:29:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1A653E5659
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:29:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13DA4600A66
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:29:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7045721AB2;
 Wed, 30 Sep 2026 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790778545;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wlvMhtY4rtmyQ5skAFIub35voKyPIOEjOu8xowJ6zc=;
 b=OO+Eq//eOiTx0qrJqjWd6+/e30/i4t5xecWbBoizs5PhS8YqIt9+HF6/Nyf8Eajpjz4yco
 z6ycPooK/ovXOujK9wd6LL+hGu8jU2J3l6DvzYR/6plVh7TTHquaMdFAdYNKa/kIw+oJX8
 0L/bFeW5lGOtW55KGGOJFK2lnc6SU5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790778545;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wlvMhtY4rtmyQ5skAFIub35voKyPIOEjOu8xowJ6zc=;
 b=tHVM6PwQEMfzu8QswoSbwx0QJQhyE9MVbzAXYSRZqBhrOEg3GTXJn1TFXNB9N81n8Nfax8
 SfItzZ4wFWIqUoCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kxmlRQWk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lBeyVZj6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790778541;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wlvMhtY4rtmyQ5skAFIub35voKyPIOEjOu8xowJ6zc=;
 b=kxmlRQWkUSnIOc2z+8uL9QEBhH1qA77FkCnK770POn+JRROBR3/oll9pjpzgIdDrTLr8q7
 j/9HnVtE/bKxwD60PSJ51/zE+zV3/y1Mh7EXdtBQo4a4tGXis8pCpWm6ZnAt1h8HBd6dD7
 9Ga/w+n6zKP9eSNkawoF5YO2IVBRkNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790778541;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wlvMhtY4rtmyQ5skAFIub35voKyPIOEjOu8xowJ6zc=;
 b=lBeyVZj6VCaZ8VHLb4NXeriIxsSF5F06Xt0Y3R/4Qqe6BlyB6buY2K01raUnhlcItX7F7f
 F8qbBFaNE5+jQ/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31BB1136AD;
 Wed, 30 Sep 2026 14:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 47rpAq0cvWpBdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Sep 2026 14:29:01 +0000
Date: Wed, 30 Sep 2026 16:28:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260930142855.GA2729765@pevik>
References: <20260928212733.2835408-1-anders.roxell@linaro.org>
 <445ee2bc-edb5-4517-b0e2-87e6df4eeb5e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <445ee2bc-edb5-4517-b0e2-87e6df4eeb5e@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7045721AB2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] accept02: Join the multicast group on lo
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

Hi all,

> Hi,
> I've tested the patch on affected kernel v4.4 and the bug is still
> reproducible. Let's merge it.

Martin, thanks a lot, we really appreciate your effort to test last minutes
before the release => this one made it into the release (merged).

Anders, thanks for fixing this.

Kind regards,
Petr

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
> Tested-by: Martin Doucha <mdoucha@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
