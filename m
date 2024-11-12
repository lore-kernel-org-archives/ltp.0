Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656E1D597B2
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 22:50:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDBED3D6309
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 23:50:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0E8E3C4BFA
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 23:49:52 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5BC68203C56
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 23:49:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 633671F365;
 Tue, 12 Nov 2024 22:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731451790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvyj7ii88Zy/7CO0U88oyDKs1fzdEB6BAcGkHWTgGRQ=;
 b=UsgAvA4XLYsjmJrucamGLU+Hm+KHVlasmUdcHBLv1kMMWNfjz0sXqWT7YyYlLDHfIW0j0r
 JETwUVNaEAQXbT3qsKDI4/yYrvRTcnDM70iOa4qOk7ilf/7Db8EwKSXedZ4XWiUFOGcydH
 Of3MczspwtB/A3n5PAaXdZo7snXv1uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731451790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvyj7ii88Zy/7CO0U88oyDKs1fzdEB6BAcGkHWTgGRQ=;
 b=sIYWgWZ5C63HvvamZJUD9anL5az6jARWLGPRjzi4k/C52kojNAoj8acy5bJd2lqWgZNmlF
 ij83WxLpx2zmOVBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UsgAvA4X;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sIYWgWZ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731451790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvyj7ii88Zy/7CO0U88oyDKs1fzdEB6BAcGkHWTgGRQ=;
 b=UsgAvA4XLYsjmJrucamGLU+Hm+KHVlasmUdcHBLv1kMMWNfjz0sXqWT7YyYlLDHfIW0j0r
 JETwUVNaEAQXbT3qsKDI4/yYrvRTcnDM70iOa4qOk7ilf/7Db8EwKSXedZ4XWiUFOGcydH
 Of3MczspwtB/A3n5PAaXdZo7snXv1uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731451790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvyj7ii88Zy/7CO0U88oyDKs1fzdEB6BAcGkHWTgGRQ=;
 b=sIYWgWZ5C63HvvamZJUD9anL5az6jARWLGPRjzi4k/C52kojNAoj8acy5bJd2lqWgZNmlF
 ij83WxLpx2zmOVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 342B713301;
 Tue, 12 Nov 2024 22:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6ozECo7bM2czCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Nov 2024 22:49:50 +0000
Date: Tue, 12 Nov 2024 23:49:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241112224948.GD234224@pevik>
References: <20241031085934.57039-1-maxj.fnst@fujitsu.com>
 <Zyn/IUYuWpAoswZP@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zyn/IUYuWpAoswZP@wegao>
X-Rspamd-Queue-Id: 633671F365
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] llistxattr03: Convert docs to docparse
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
Cc: Xiao Yang <yangx.jy@fujitsu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > -* Description:
> > -* llistxattr is identical to listxattr. an empty buffer of size zero
> > -* can return the current size of the list of extended attribute names,
> > -* which can be used to estimate a suitable buffer.
> > -*/
> > + * Copyright (c) 2016 Fujitsu Ltd.
> > + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * llistxattr is identical to listxattr. An empty buffer of size zero
> > + * can return the current size of the list of extended attribute names,
> > + * which can be used to estimate a suitable buffer.
> > + */

IMHO the best description was in v1 of the test:

https://lore.kernel.org/ltp/1454058489-25625-3-git-send-email-yangx.jy@cn.fujitsu.com/

llistxattr(2) with an empty buffer of size zero can return
the current size of the list of extended attribute names.

What was then in v3 committed is slightly misleading.

"llistxattr is identical to listxattr" is from man page, but it's IMHO
irrelevant. Also first "can" is wrong (it should always work, not just
sometimes).

I dared to rewrite before merge:

 * Verify that llistxattr(2) call with zero size returns the current size of the
 * list of extended attribute names, which can be used to determine the size of
 * the buffer that should be supplied in a subsequent llistxattr(2) call.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
