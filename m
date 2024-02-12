Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70311C4829E
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 19:30:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D14C43CF3D7
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 20:30:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BDC83C21DA
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 20:30:30 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B3A9F1400351
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 20:30:29 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0138E21E44;
 Mon, 12 Feb 2024 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707766228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybcrnqFBDckBDcHoQvb0nzS/QS5gkjoF+FlFJVf8yuM=;
 b=0NGKY+yUBSVAwCxCcBlrbH0szDpd813IvDBYJLuv9dbG4ed3jd/wuNRrOvg/mxpuBXyXOc
 1Dsul9KXU1mz55bmjFBoM5FXcHN9z1Wk0Tu9B3nw35pdNeQHt/YE0znk4MZ8JrWfYtLKag
 ARB2UCydiJh+ujR8OZBjjsMqoftHQvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707766228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybcrnqFBDckBDcHoQvb0nzS/QS5gkjoF+FlFJVf8yuM=;
 b=JxVQ8H0d3axVA4dC9wYbGugkXOpEXk2gHhN+ZJ4P1nHHfFztxj1yyDhE9dThOCWOawbODS
 DAEMVBOwRAjKABAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707766227;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybcrnqFBDckBDcHoQvb0nzS/QS5gkjoF+FlFJVf8yuM=;
 b=dQyoYKe+DqXRKwRGDxesFUzRZz/Fj8YKlv06T9ghJF/g7quMq13OIPfD3m7aCPH7sUxvUk
 yaHq2l/Ef7LtF+GJLyZNTTN0ao4+Ht34aHz+xFEs6JCM4Bu4s59wOH1UW4k41z0/+nGX9C
 HbmaWwZwNE/9KjsUazebShm/5NWjlaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707766227;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybcrnqFBDckBDcHoQvb0nzS/QS5gkjoF+FlFJVf8yuM=;
 b=xLWfRbGZlgjJw8YQmggyR3uFANoH8SvbmHcPGbJB+BFpiY9NjTYbCniaBw67UHsdQ1SSYi
 M8XgZooGz7iP2jDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BA71613212;
 Mon, 12 Feb 2024 19:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 6/aPK9JxymX8BgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 12 Feb 2024 19:30:26 +0000
Date: Mon, 12 Feb 2024 20:30:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240212193025.GA637011@pevik>
References: <20240205022857.191692-1-pvorel@suse.cz>
 <20240205022857.191692-2-pvorel@suse.cz>
 <CAEemH2dZn4jRjQbEX492uhb4DMHCOMq+C4zvYeq_0N1x8X_mPA@mail.gmail.com>
 <20240205110042.GA201808@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240205110042.GA201808@pevik>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dQyoYKe+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xLWfRbGZ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.99 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-1.28)[89.92%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 0138E21E44
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] swapon03: Swap is not supported on TMPFS on
 tmpfs
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Yang Xu,

this is invalid, replaced by:

https://lore.kernel.org/ltp/20240212192612.636901-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20240212192612.636901-1-pvorel@suse.cz/

Could we please merge this simple fix before Yang Xu cleanup patchset:

https://patchwork.ozlabs.org/project/ltp/list/?series=394113
https://lore.kernel.org/ltp/20240208100517.1974-1-xuyang2018.jy@fujitsu.com/

I'm sorry, that would mean to send rebased version, but IMHO better include
simple fix.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
