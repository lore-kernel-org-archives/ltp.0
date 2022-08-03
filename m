Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999E3C19F2A
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 04:48:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4489D3C9266
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 06:48:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B9AC3C899B
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 06:47:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 291431A006EA
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 06:47:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3FA20A0B;
 Wed,  3 Aug 2022 04:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659502074;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgTBeaYD7/5eTKgch/k8hcud2N/o7GIyljVU2Kod9pg=;
 b=WmSMx/jLl8Z7W9OZMifAdqEd8sCGl6vqjzkPQSKXAK3PpWCNeSp7aIeLt7dJ2XpX8axJ9D
 I2VB0AASWSh6OoOYUE4UjP85JeKoFapVwBhJcqvwf0iSW7j5RymrlsR+53Ho/T5/DcnNcL
 E526z15HHBESFmtHB8vPf7S6D9j78DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659502074;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgTBeaYD7/5eTKgch/k8hcud2N/o7GIyljVU2Kod9pg=;
 b=p9aBdLSnRO0Hw/2wAaMYW2lfq4DZ8GzEbQfoB0pEa6BR/RMWKoZBfiruDNVZgNoLPfZCBy
 0J+q3r74gQUi/4AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6008513A94;
 Wed,  3 Aug 2022 04:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d6ptFPr96WJwFwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 03 Aug 2022 04:47:54 +0000
Date: Wed, 3 Aug 2022 06:47:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Yun9+XK5CKzd1Uys@pevik>
References: <20220801151408.15947-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220801151408.15947-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor aiocp using new LTP API
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

Hi Andrea,

...
> -AD303 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/ff2 $TMPDIR/aiodio.$$/junkdir/ff2
> -AD304 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/ff3 $TMPDIR/aiodio.$$/junkdir/ff3
> +AD001 time aiocp -b 1k -n 1 -f DIRECT
Could we please get rid of time?
That's something we don't want in runtest files.

> +AD002 time aiocp -b 1k -n 1 -f SYNC
> +AD003 time aiocp -b 1k -n 2 -f DIRECT
> +AD004 time aiocp -b 1k -n 2 -f SYNC
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
