Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A4DC48292
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 18:43:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3591A3CF733
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 19:43:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D84FB3CC6CE
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 19:43:39 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E35491400C40
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 19:43:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AAC12220F4;
 Mon,  5 Feb 2024 18:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707158617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rlp2ujd/pHP6y7h7vH24rrlr6nRShAUxhnXfTU8WkAI=;
 b=0hWXrZBBTaz5M//gvpWqgPayDFxvC4x5viPDETpgaWHI5oRWAzH6JKUQFGtJqppSUbxbsN
 RnCJHWJYkK+z99qMggagX55vBpMr9sdmDkiGvyDmERr33e7z0iI1TC1o6QoYSJ4X9kWIxO
 iSlpA8nEqJuNEDWzbxWobKsdy+YKv24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707158617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rlp2ujd/pHP6y7h7vH24rrlr6nRShAUxhnXfTU8WkAI=;
 b=XtuKXtA5KRt/HybOtOlq0j+hNKkfgVWx1KsiiCaLuk9THrpeU6tuyOiY7cGlbURQakRuhG
 x2edJzjS6omuynCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707158617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rlp2ujd/pHP6y7h7vH24rrlr6nRShAUxhnXfTU8WkAI=;
 b=0hWXrZBBTaz5M//gvpWqgPayDFxvC4x5viPDETpgaWHI5oRWAzH6JKUQFGtJqppSUbxbsN
 RnCJHWJYkK+z99qMggagX55vBpMr9sdmDkiGvyDmERr33e7z0iI1TC1o6QoYSJ4X9kWIxO
 iSlpA8nEqJuNEDWzbxWobKsdy+YKv24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707158617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rlp2ujd/pHP6y7h7vH24rrlr6nRShAUxhnXfTU8WkAI=;
 b=XtuKXtA5KRt/HybOtOlq0j+hNKkfgVWx1KsiiCaLuk9THrpeU6tuyOiY7cGlbURQakRuhG
 x2edJzjS6omuynCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 532D5132DD;
 Mon,  5 Feb 2024 18:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id suTrA1kswWUTMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Feb 2024 18:43:37 +0000
Date: Mon, 5 Feb 2024 19:43:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240205184335.GB242730@pevik>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0hWXrZBB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XtuKXtA5
X-Spamd-Result: default: False [-0.34 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.83)[85.18%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AAC12220F4
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yang Xu,

I'm sorry, this is not applicable due my checkpatch cleanup,
but it's Superseded anyway.

@Yang Xu FYI I touched the same test swapon03.c [1]:

The cleanup is not that much important (I'll rebase it after your changes),
the second commit [2] is more important - failure on swapon03 on TMPDIR on
tmpfs. I wonder if your MAX_SWAPFILES fixes will improve it.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=393561
[2] https://patchwork.ozlabs.org/project/ltp/patch/20240205022857.191692-2-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
