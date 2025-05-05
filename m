Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B56AC3ABAA
	for <ltp@archiver.kernel.org>; Mon,  5 May 2025 19:50:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B16A83CBF7C
	for <ltp@archiver.kernel.org>; Mon,  5 May 2025 21:50:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 861793CBEF8
 for <ltp@lists.linux.it>; Mon,  5 May 2025 21:50:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 56ACD600701
 for <ltp@lists.linux.it>; Mon,  5 May 2025 21:50:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F2CD21254;
 Mon,  5 May 2025 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746474609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y0YX/wN6S+pTuArcKROQ+cKUgTpo51Msi2Gii6WtAjo=;
 b=l1oXOR2WUS2wPfUW5lnM7jEZXfuzh6JAOQVKwYj+4KkrXUiQYgQ8/ce/vkLXhwkq5d8L1d
 tJFhfe6ZJAQ3YqFdbUQ5Tev6/O1YuK9vlcbZdooGDhfEDIly0JbWqxO6Y4v1DmKUGu5++P
 /5yWDu/DR2w+9BSEoromCIrM9VrUIBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746474609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y0YX/wN6S+pTuArcKROQ+cKUgTpo51Msi2Gii6WtAjo=;
 b=g3a5SzqfyhmZ8qOJOgXamwxqX13xQz6V0xplF+ZLTp/lGIvSwWXrOULvTpLI95CwStuU73
 sgmcZvuvvQMyGWDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l1oXOR2W;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g3a5Szqf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746474609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y0YX/wN6S+pTuArcKROQ+cKUgTpo51Msi2Gii6WtAjo=;
 b=l1oXOR2WUS2wPfUW5lnM7jEZXfuzh6JAOQVKwYj+4KkrXUiQYgQ8/ce/vkLXhwkq5d8L1d
 tJFhfe6ZJAQ3YqFdbUQ5Tev6/O1YuK9vlcbZdooGDhfEDIly0JbWqxO6Y4v1DmKUGu5++P
 /5yWDu/DR2w+9BSEoromCIrM9VrUIBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746474609;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y0YX/wN6S+pTuArcKROQ+cKUgTpo51Msi2Gii6WtAjo=;
 b=g3a5SzqfyhmZ8qOJOgXamwxqX13xQz6V0xplF+ZLTp/lGIvSwWXrOULvTpLI95CwStuU73
 sgmcZvuvvQMyGWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE4AC13883;
 Mon,  5 May 2025 19:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NrfBNnAWGWi2JAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 May 2025 19:50:08 +0000
Date: Mon, 5 May 2025 21:50:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250505195003.GB137650@pevik>
References: <20250429052247.GA144682@pevik>
 <aBSVO8uOE86UGIcp@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aBSVO8uOE86UGIcp@yuki.lan>
X-Rspamd-Queue-Id: 3F2CD21254
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; REPLYTO_EQ_FROM(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP in valgrind :)
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
> Awesome :-)

> It also opens some interesting questions, i.e. how do we make comparing
> results from two different tests easier. Currently they grep the test
> results for a summary, but maybe we can do better.

Kirk and compare json?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
