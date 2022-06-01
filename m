Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07906C433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 10:34:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E7663C67E3
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 12:34:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D4D03C54F1
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 12:34:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0478F1400BE9
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 12:34:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 66FCA1F8C6;
 Wed,  1 Jun 2022 10:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654079642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hD88aAvxI69fHoKFyYyqyjQoiOQFSsvJ3jFFdQRwJC0=;
 b=xOg64qiRX1PaHdnbhFE83aJAreN2iaCXjvqpdd7ittz6XpQcemRMsbsbHlCWqvcUxlG2ZX
 zHLNQqD6AcecON0Wr3siwkALxyt6D9hw75/V3r7Q/2aCG1+wgDDiagKtfwl6+6JpXcOpca
 BTiIGY6WA3it0SdiXwsyy/SEu7x6iSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654079642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hD88aAvxI69fHoKFyYyqyjQoiOQFSsvJ3jFFdQRwJC0=;
 b=p7pPSqNYnbN5humRn9+uTBvZAXu3KmmNbdBYCsVkqaZLyie7vY9ndFAcippqsl2Uke3+Bh
 dwLKMwaEzD0/owDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19F171330F;
 Wed,  1 Jun 2022 10:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xoTbAppAl2IdFAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Jun 2022 10:34:02 +0000
Date: Wed, 1 Jun 2022 12:34:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YpdAmGFZR01I6zmA@pevik>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-6-pvorel@suse.cz> <YpTexs/dQDZdxr4m@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YpTexs/dQDZdxr4m@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/8] shell: Add tst_clear_device
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> Can't we just add clear command to the tst_device.c instead?
Not sure what you mean, can you be more specific?

I wasn't clear in git commit message that shell API also needs call
tst_clear_device(), but we use mkfs.* binary directly, instead of tst_mkfs_()
via SAFE_MKFS(), but this is obvious to you.

Alternatively we could create binary testcases/lib/tst_mkfs.c which would 
run SAFE_MKFS(). We already have all code in C and both C and shell API would be
even more consistent.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
