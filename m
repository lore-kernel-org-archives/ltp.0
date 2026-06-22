Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96884CDB46F
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 10:00:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AE513E53B0
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 12:00:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE4623E53B0
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 12:00:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EC29614002DC
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 12:00:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F00B75978;
 Mon, 22 Jun 2026 10:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782122406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7apGiRHX3AOnGqqO5KgM8hHkLamu7tkHgTVgORvPJSc=;
 b=i1o0QUHGjGQ2gYgk5SSxudAZc/XWzjT77LmzUpnZNizh17px/AtqvAL+OvInb2iEO0PxIZ
 mbGe9JAW2bBPp47hg673eGtzkP7MVQtgMf9wF3Bvrw5vyEN8+pRfFw5SVrv9+GFwKkmw67
 pFZeF2hDiTXi3muGAJ1gHWI4M40PTM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782122406;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7apGiRHX3AOnGqqO5KgM8hHkLamu7tkHgTVgORvPJSc=;
 b=hxzpE3Kgu53WthehXeVh4CRVyLz3qHxEXD5YS34TQzqRNCrPdTE8E7eQaOzU1gNBestDtj
 zeClCW37fJolYOCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782122405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7apGiRHX3AOnGqqO5KgM8hHkLamu7tkHgTVgORvPJSc=;
 b=ocAhp+8RZjLcobVm9TFGiWB7jjzBmEC6dD7Xwww3imZdDzuWBUUFeTfMeoHE+T8/YzZsyS
 YTMfH83Wvr+hcHznpoNgxNdgoZgM0+6B6kr2qY6W/DZMbdyE+ioy1mTywBlTbiSdBkQwd3
 GbOiLEi9IVpva6Je+7OdpBhcdik5/b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782122405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7apGiRHX3AOnGqqO5KgM8hHkLamu7tkHgTVgORvPJSc=;
 b=bmtrs3ZlGYmdzmENffd2aEYqzC2MJ+D81IxjNzEaEf3bJdjGqRo/yX/4/KaSQy8CIGQU7c
 WNw1gCeknO/KBICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40888779A8;
 Mon, 22 Jun 2026 10:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JvaYDqUHOWpDVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 22 Jun 2026 10:00:05 +0000
Date: Mon, 22 Jun 2026 11:59:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ajkHmVoetXBnSDD7@yuki.lan>
References: <20260622-metadata_groups-v3-0-45651d685c3c@suse.com>
 <20260622-metadata_groups-v3-1-45651d685c3c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260622-metadata_groups-v3-1-45651d685c3c@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] metadata: add tests grouping support
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
The code looks good to me now:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Please fix the minor issues pointed out by the ltp-agent before
applying.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
