Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25AEC433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 15:08:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B60D93CD26A
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 16:08:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E44A73C01D2
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 16:08:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B7A8200970
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 16:08:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E4DA22B92;
 Mon, 14 Nov 2022 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668438523;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MWjni3NnmQllkoJU0psgaFr9LndPxwTw1nbMtHhV7hM=;
 b=E0rPRs/gCgBkcBcAucAsU/0HSNC1/bmtsC5qG4CTm3HfQIwjZAQu+PwGEz0bXwWLlvIPVA
 97y9TD329XIBLw84Wy+DWmMclrJUXzD+RcuMHPzym6D64xs86S3kHHcRH+UWxKitILeKDC
 lLhoSc+5f95kOIkiku97jnpBZ1y0Ke8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668438523;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MWjni3NnmQllkoJU0psgaFr9LndPxwTw1nbMtHhV7hM=;
 b=qHGk1PPAuiUfVLZZIxTi8owcClT0dOphXIqiQt6ZLhSdLTuF+jFQHMh+rkbRfbTDlInyTU
 qKs+IMWjmRqBI7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1F1013A8C;
 Mon, 14 Nov 2022 15:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MEDRJ/pZcmMBBwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 14 Nov 2022 15:08:42 +0000
Date: Mon, 14 Nov 2022 16:08:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y3JZ+MhZCBF0bLwm@pevik>
References: <20221111170410.16350-1-pvorel@suse.cz>
 <87y1sdspn1.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y1sdspn1.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runtest/mm: Use the default value for -p
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

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Test rewrite in 88321bfff introduced reasonable default value for -p
> > option "number of mapping children" (nproc -1 in range <1, 20>), let's
> > use it, instead of forcing -p 20.

Thanks for your review, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
