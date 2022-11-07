Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7CCC433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 14:45:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 320B53CDA0F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 15:45:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 611A43C01D2
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 15:45:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B8A13100054A
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 15:45:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB34E1F889;
 Mon,  7 Nov 2022 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667832300;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gC5T4Zc8FoH4Yn/iBKeSNLFyTOj7c+VBEIEQx8ZKspE=;
 b=khLX6IqYEA+7oGoqK0cg4HKjHa6gXdSGL3xb06CDLeT1O2QO2X3IgeQZMu0PzSUA8uA6at
 jXacMtFfxe7UJkcNnwQgw13v1Sj8Wb5BRpiLH45jvJe48S2rWIqYFe6V0ejUzGIoodpy8R
 nhRgsNk+7G9npPdzVTTiqwnco/V9ojc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667832300;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gC5T4Zc8FoH4Yn/iBKeSNLFyTOj7c+VBEIEQx8ZKspE=;
 b=8ZMOGn+FztMCjDtFgL4Kn+Ii8/11zPR0fCR8T2nfzu7jwQol9crbDPuTTM1S2lxxqL1QRn
 9GE/UxtciKha5tAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79B8913AC7;
 Mon,  7 Nov 2022 14:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iQucG+wZaWOPCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Nov 2022 14:45:00 +0000
Date: Mon, 7 Nov 2022 15:44:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y2kZ6mSaR1eew/ve@pevik>
References: <20221021115333.13725-1-pvorel@suse.cz>
 <20221021115333.13725-3-pvorel@suse.cz> <87v8nrvul4.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v8nrvul4.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] Makefile: Update copyright, use SPDX
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

Hi Richie,

> I would just merge, but it won't apply

> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

I rebased and merged this one. I will send new version of fist patch,
so that more people can have change to review.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
