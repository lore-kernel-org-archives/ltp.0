Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862D1C5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 11:56:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8A3E3CF658
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 12:56:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2BA43C81F3
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 12:56:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=temperror (SPF Temporary Error: DNS Timeout)
 smtp.mailfrom=suse.cz (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 482996008BB
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 12:56:18 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 77FE9221AE;
 Fri, 23 Feb 2024 11:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708689378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0z2M4/acfJj2D2OiVqPfliCi2oNDThINlGhGQkhBrI=;
 b=L84bPn+DRamxJ4u/+pCru8k+qrD3DKK8YiyfWl96FKWkB9YDMmJzimWMF5hkqyBFEfk4st
 qgMUylD5VVv+Xe5deuyPHu5mnG151Hq4VFsr8B44dZKY+aYbHTcnI8WbYD0lz7AJ7kDvuO
 oPUvtMDIqdztZMDfaNbnRJnTIf7pko4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708689378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0z2M4/acfJj2D2OiVqPfliCi2oNDThINlGhGQkhBrI=;
 b=Ib7JOVf32yklSb6axdRvBL0nmlST3UAasuwvzoiSx7w318C5sj0uqXhcApGEN7FT0pRg6y
 gge+OdUrC2Xu6FBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708689378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0z2M4/acfJj2D2OiVqPfliCi2oNDThINlGhGQkhBrI=;
 b=L84bPn+DRamxJ4u/+pCru8k+qrD3DKK8YiyfWl96FKWkB9YDMmJzimWMF5hkqyBFEfk4st
 qgMUylD5VVv+Xe5deuyPHu5mnG151Hq4VFsr8B44dZKY+aYbHTcnI8WbYD0lz7AJ7kDvuO
 oPUvtMDIqdztZMDfaNbnRJnTIf7pko4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708689378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0z2M4/acfJj2D2OiVqPfliCi2oNDThINlGhGQkhBrI=;
 b=Ib7JOVf32yklSb6axdRvBL0nmlST3UAasuwvzoiSx7w318C5sj0uqXhcApGEN7FT0pRg6y
 gge+OdUrC2Xu6FBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CCCC13776;
 Fri, 23 Feb 2024 11:56:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id TgXiEOKH2GWvZAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 11:56:18 +0000
Date: Fri, 23 Feb 2024 12:56:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240223115616.GJ1423688@pevik>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.24 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.74)[83.90%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/7] libltpswap: Add tst_max_swapfiles api
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

Hi Yang Xu,

you introduced new formatting warnings, could you please fix it?

$ make check-libswap
libswap.c:279: WARNING: braces {} are not necessary for single statement blocks
libswap.c:289: WARNING: braces {} are not necessary for single statement blocks

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
