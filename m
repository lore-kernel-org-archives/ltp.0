Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4664CCD1296
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 09:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BA953CF72A
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 11:31:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D78C23C60FA
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 11:31:15 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 574D6140119C
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 11:31:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 144E234D8D;
 Wed, 10 Apr 2024 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712741474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcvP6aoAJaAHjqMEVa07Hu2JDmEmqyQtV/FvEjEEnqM=;
 b=3bRgQ6J/bgowfHzHkQMFk2R1mr8p3LDydoPkhtbG6fsuWnNzpkLSvBa91/uMKnFNmt9+jH
 64JZXVpvsTnZoWfaxZI0jlXsLpSTF5NGWwwg6X1+LUo4QYGySzJXsle6Hdz0KL0PuyXzyz
 nSelKEsWAwImcr5/dXaUlhV/ZX8CkNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712741474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcvP6aoAJaAHjqMEVa07Hu2JDmEmqyQtV/FvEjEEnqM=;
 b=Yd7q5RsvPAqO/L2N0RmQlhW6hYlL+BqWR0oNjje6gDC7RTYQXpdfxyQydjL406vHygBcjL
 qZu7hffRXXPBRLDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="3bRgQ6J/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Yd7q5Rsv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712741474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcvP6aoAJaAHjqMEVa07Hu2JDmEmqyQtV/FvEjEEnqM=;
 b=3bRgQ6J/bgowfHzHkQMFk2R1mr8p3LDydoPkhtbG6fsuWnNzpkLSvBa91/uMKnFNmt9+jH
 64JZXVpvsTnZoWfaxZI0jlXsLpSTF5NGWwwg6X1+LUo4QYGySzJXsle6Hdz0KL0PuyXzyz
 nSelKEsWAwImcr5/dXaUlhV/ZX8CkNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712741474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcvP6aoAJaAHjqMEVa07Hu2JDmEmqyQtV/FvEjEEnqM=;
 b=Yd7q5RsvPAqO/L2N0RmQlhW6hYlL+BqWR0oNjje6gDC7RTYQXpdfxyQydjL406vHygBcjL
 qZu7hffRXXPBRLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F341713691;
 Wed, 10 Apr 2024 09:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id spZNOmFcFmaSSwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Apr 2024 09:31:13 +0000
Date: Wed, 10 Apr 2024 11:30:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZhZcL9cH5bVDWL_k@yuki>
References: <20240401150015.301640-1-samasth.norway.ananda@oracle.com>
 <Zg_oLGuLcssY-rYY@yuki>
 <e2368059-647c-4d98-8c90-2cc5f3bb34a4@oracle.com>
 <20240409101753.GA107959@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240409101753.GA107959@pevik>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 144E234D8D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mremap06: fallocate is not supported on nfsv3
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
Cc: calum.mackay@oracle.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > > -	if (ret == -1)
> > > > +	if (ret != 0) {
> > > > +		if (errno == EOPNOTSUPP || errno == ENOSYS) {
> > > > +			tst_brk(TCONF,
> > > > +				"fallocate system call is not implemented");
> > > > +		}
> > > >   		tst_brk(TBROK, "fallocate() failed");
> > > > +		return;
> 
> I suggest to merge this now, without return (it can be removed before merge).
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Shouldn't we limit this only to nfs, to make sure that fallocate() is
not accidentally disabled on other filesystems? At least that what I
suggested when I replied to the patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
