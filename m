Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69ADC433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 13:10:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD4E33CA65F
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 15:10:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65A5F3C02B1
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 15:10:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D6990600804
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 15:10:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38EDD210E3;
 Tue, 19 Apr 2022 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650373847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bg1edu57okWo66VFC132AR64NU5BtpGKGjAHrC0+g/Y=;
 b=HUDUJ8grdeq1nw1/7KUSJZJxe4/AkgHQ/PLVqdtG+ObegNnyo5mmX+CyAakWH1JLtHkxPp
 K10E/EaKXppBntWhRn47cYgr8SgBY6OKtBXzWOKEauLJKh7+WuIJ63YmML0DE98Kav/2Lj
 pEPaWA1T9B7FPjSU5keHdd7fUVM8eck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650373847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bg1edu57okWo66VFC132AR64NU5BtpGKGjAHrC0+g/Y=;
 b=kJyAmsP9h7RKr1Bd1uHzu2WU+gCc+r3Bgt52tcRKmyPOql9bZ7mOC9rI3x8jqNKNeOik6E
 AGKCgYIiP5H3yuBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FE82139BE;
 Tue, 19 Apr 2022 13:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9pp4C9e0XmJWfwAAMHmgww
 (envelope-from <pvorel@suse.de>); Tue, 19 Apr 2022 13:10:47 +0000
MIME-Version: 1.0
Date: Tue, 19 Apr 2022 15:10:46 +0200
From: pvorel <pvorel@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <Yl60xJbQJnO1Gndl@yuki>
References: <20220419064744.11487-1-pvorel@suse.cz> <Yl60xJbQJnO1Gndl@yuki>
User-Agent: Roundcube Webmail
Message-ID: <9c1127c64d34ac2c017774e0ba42f97f@suse.de>
X-Sender: pvorel@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] confstr01: Update to X/Open 7 (POSIX 2008)
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> This looks fine and as long as it compiles on supported distros and
> compilers:
Yes, I've tested it on CI.

> 
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> 
> Btw, we can simplify the code a bit with macro like:
> 
> #define PAIR(name) {_CS_ ## name, #name}
Thanks, I'll use it in this commit.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
