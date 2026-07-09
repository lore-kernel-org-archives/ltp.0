Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5476DC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 11:17:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D89A3CD4AC
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 13:17:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E74BA3C0F6F
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 13:17:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62C91600123
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 13:17:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BF82875E87;
 Thu,  9 Jul 2026 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783595856;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBCcB+PJeoSRn1VzCvWSps/ZCC044t4RyjSFucfaTiU=;
 b=eay0tLyPWqNjmrP/ckrBAMwWWnAD/H0x73fvnPMZxymyWMZAvTQz9n44D5wEZKSrEoVrh2
 D24r8atqscNP21ArEXCjU36VlhD4MOIxi7rY+DnJ1Mtarwj4C8ats+k6Z1iHpcWVo1SbbX
 Ssb0/FQnZ2JW7sPktK+p14hLQODLw4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783595856;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBCcB+PJeoSRn1VzCvWSps/ZCC044t4RyjSFucfaTiU=;
 b=D9wFmwP0KZtVsubanSmvXDWiz4AD0SGn+xG9R2Lnb2+jc9SZxOWxNqmZKLpHO/AlYDgLO3
 KANunpFme6+E9rDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783595854;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBCcB+PJeoSRn1VzCvWSps/ZCC044t4RyjSFucfaTiU=;
 b=HaR8bVIB+vZOO7+pieFfENW0c7IL+vb+J3hX5To8Xum7/qCjfGvswSsvxToUrzAK3swWGt
 eji16lVsyERlF8fmB1O4AAnZrA3LzfI8ak3pDJxuYKjriOs+fwzu8969RJtAD5Adyfx4KF
 QQTJw5K/YPQNj9nutLnNI6j4+OMuI5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783595854;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBCcB+PJeoSRn1VzCvWSps/ZCC044t4RyjSFucfaTiU=;
 b=JVeYHxaLJPnzPIlK9vudKE86ClHzWH4k0nIcUsRF5wAThFSV4UaYMAV3odDnhTjoA/69s2
 5LE2/7gv3JBSHeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AD1C779AA;
 Thu,  9 Jul 2026 11:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pC5SHE6DT2qwLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jul 2026 11:17:34 +0000
Date: Thu, 9 Jul 2026 13:17:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260709111732.GB874350@pevik>
References: <20260709085353.345957-1-chrubis@suse.cz>
 <20260709085353.345957-2-chrubis@suse.cz>
 <20260709105159.GA874350@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709105159.GA874350@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] syscalls: Add epoll_create03
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > +/*\
> > + * Verify that :manpage:epoll_create() fails with EMFILE when the per-process
> Please add 2 to the manpage link.

> :manpage:epoll_create(2)

I'm sorry, also `` are needed:

:manpage:`epoll_create(2)`

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
