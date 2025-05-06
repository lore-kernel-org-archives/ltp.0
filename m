Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D67C3ABBC
	for <ltp@archiver.kernel.org>; Tue,  6 May 2025 22:05:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E40C3CBD19
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 00:05:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DF063C8447
 for <ltp@lists.linux.it>; Wed,  7 May 2025 00:04:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D862B60007F
 for <ltp@lists.linux.it>; Wed,  7 May 2025 00:04:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1FD81F38A;
 Tue,  6 May 2025 22:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746569088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5SEO/BUF45/R56QrdjybLS0Ff97NSgaXN/R0w3goos=;
 b=mh/xrGYLXhmuAVbySRDDYQijBhjIH/bPAtl81iQ0fYJfBLPjAU+jq+RJnHL9K3gaPxTcP6
 5ie5kHj4xXk+332tli5meuaQjhGqhZx+k2PM4rBI2ZbK1NVAHUDPN6bVlxACSu6vogjXW0
 hi2nnERGW90Fm5OWVF2/Hz2knwOyGq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746569088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5SEO/BUF45/R56QrdjybLS0Ff97NSgaXN/R0w3goos=;
 b=pPIe0pikl7YDS1Eba9k6MIj2ZYm0b33DS1LzcLtM4HAMNfKmp8lROikA598YlyL4UJiZrd
 pK3v+r8A5bKjHJDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746569087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5SEO/BUF45/R56QrdjybLS0Ff97NSgaXN/R0w3goos=;
 b=O8eVc41ig93wCzJQ0wNUPuPNUkkqxoQ1qq9lXw0e3/HampCWbSo3WqXA+yG5MMsqJgS2fQ
 wLyjzQxGW9Hz434eAqTdluMst3g5Em+EQ/C8c3dJ+JV5e9WorO/trs6tdjpzY2lvPNIKSy
 fg2ucbyuE1byC3/8IrxFmtHQ0dD6+FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746569087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5SEO/BUF45/R56QrdjybLS0Ff97NSgaXN/R0w3goos=;
 b=ctFRbQYdJwtb/3BBY+A4eH9fzfyeP4hSdn+yr/ZBLXvn6HWquQYOh9tM4IhEb2mnFrucke
 56gdwui8h4t65iAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB4A1137CF;
 Tue,  6 May 2025 22:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IAjlLH+HGmivSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 May 2025 22:04:47 +0000
Date: Wed, 7 May 2025 00:04:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250506220441.GA99522@pevik>
References: <20250430130417.43523-1-pvorel@suse.cz> <aBSHoimhpmTj1l_A@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aBSHoimhpmTj1l_A@yuki.lan>
X-Spamd-Result: default: False [-2.42 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; NEURAL_SPAM_SHORT(0.88)[0.294];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/4] shell loader rewrite to support TST_SETUP
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

> Hi!
> > we are getting there, but not yet finished.

> > one remaining problem - it requires *full* path in PATH. I wonder what
> > basic I'm missing.  The current change requires to use full path
> > otherwise execvpe() fails.

> > I suppose it is due change cwd due creating temporary directory - it
> > fails only with:
> > "needs_tmpdir": true
> > shell_loader_setup_cleanup.sh does not suffer this problem.
> > It's also not dash related, problem is on bash as well.

> That is exactly it. The test cannot run scripts that it cannot find so
> we need an absolute path to the directory the scripts are in. If you
> look at run_tests.sh we do srcdir=$(realpath $(dirname $0)) and prefix
> all the paths with that directory.

+1, thanks for the reminder (I forget my code :), we were discussing it
together). I see whether I add it to tst_loader.sh or tst_env.sh.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
