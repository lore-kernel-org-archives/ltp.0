Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C1BC3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 15:53:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E90593D3863
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:53:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C95F23D073A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:53:13 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A5EB960192F
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:53:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C35FA1F83C;
 Wed, 10 Jul 2024 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720626790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnUw+vMJdWSQQ6K2c11PtUkzE/Q78qdNewEu1qRRy3w=;
 b=ox+mEN38+8CC+LJVDVqP4MEe/9tvV8KcXe1HPnFu63HpnsG5Won9L63t0YAlLgDa9BmYsp
 YIXLLnEAXeencZYCP5rHbgUla8/pfIila1OcEKjoce7wcu9xtippumPgFZfOcWSeiKMgdY
 oOAIm2B/99KnLQOli8zaaVhuLF5smEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720626790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnUw+vMJdWSQQ6K2c11PtUkzE/Q78qdNewEu1qRRy3w=;
 b=L7ZAPz0u65WNXQ/4ajI0ZKh3eZAv12SrAcNIxqkV/RPZuQ7cw6ILKWffPuYKOp7T0lYJUa
 aW88J9WgVzGh70Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ox+mEN38;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L7ZAPz0u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720626790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnUw+vMJdWSQQ6K2c11PtUkzE/Q78qdNewEu1qRRy3w=;
 b=ox+mEN38+8CC+LJVDVqP4MEe/9tvV8KcXe1HPnFu63HpnsG5Won9L63t0YAlLgDa9BmYsp
 YIXLLnEAXeencZYCP5rHbgUla8/pfIila1OcEKjoce7wcu9xtippumPgFZfOcWSeiKMgdY
 oOAIm2B/99KnLQOli8zaaVhuLF5smEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720626790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnUw+vMJdWSQQ6K2c11PtUkzE/Q78qdNewEu1qRRy3w=;
 b=L7ZAPz0u65WNXQ/4ajI0ZKh3eZAv12SrAcNIxqkV/RPZuQ7cw6ILKWffPuYKOp7T0lYJUa
 aW88J9WgVzGh70Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6511E137D2;
 Wed, 10 Jul 2024 15:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KIBuF2aujmZBVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 10 Jul 2024 15:53:10 +0000
Date: Wed, 10 Jul 2024 17:53:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240710155308.GB300896@pevik>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-3-58e9af649a72@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240701-landlock-v1-3-58e9af649a72@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C35FA1F83C
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/10] Add landlock SAFE_* macros
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

Hi Andrea, Li,

...
> +++ b/include/tst_safe_macros.h
> @@ -14,6 +14,7 @@
>  #include <sys/stat.h>
>  #include <sys/vfs.h>
>  #include <sys/sysinfo.h>
> +#include <linux/landlock.h>

This will break build for more than half of the distros:

https://github.com/pevik/ltp/actions/runs/9876952862

It's mostly due missing <linux/landlock.h> on old distros, but there were also
redefinition of 'landlock_net_port_attr' at least on Fedora.

You even have some fixed version in your CI where only Leap 42 fails due
different problem), please send it (or post a diff here).
https://github.com/acerv/ltp/actions/runs/9778823237

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
