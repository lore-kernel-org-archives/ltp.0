Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28981C43334
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 11:58:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82E243C915E
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 13:58:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 350383C1C1B
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 13:58:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 68F5E6011E8
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 13:58:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B4F51FE2D;
 Thu,  9 Jun 2022 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654775913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0NOIosrn8D8E6anlVf6Fo3Mr0/rQherwpEebRVr3p1A=;
 b=quBm/J0FR6Wn2HDTGiacv+zHONuhWz+K7P4G+Gvu+rHIVMr5vbti0AYnE+HUIisTU+4v+H
 lJNGZHTo5OE7ebAKw/hXq0eGA3PZg7LM1vzOXh6lX71fQNudDAzPbnBM3G6EE7id3Aavf+
 BcEOLNMFKjPJwUhjS8qH1dEIe0oT4gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654775913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0NOIosrn8D8E6anlVf6Fo3Mr0/rQherwpEebRVr3p1A=;
 b=KkN6c+lzTgLcH/0xhm1kIJtuOR/+N9klt5ExME0ykNdgqUv5uxDo3fqSCirBlLQ59BAfTQ
 XLYR0Nmgve1ogmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09CC013A8C;
 Thu,  9 Jun 2022 11:58:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mtZBO2jgoWL2LgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jun 2022 11:58:32 +0000
Date: Thu, 9 Jun 2022 13:58:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Bogdan Lezhepekov <blezhepekov@suse.de>
Message-ID: <YqHgZkIMYUykg+Ef@pevik>
References: <20220216092553.32091-1-blezhepekov@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220216092553.32091-1-blezhepekov@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mc_opts/mc_verify_opts.c: Initialize local
 variable
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

Hi Bogdan,

> In some cases uninitialized array was used
> when comparing strings in main().

Good catch, indeed in case of error on getsockopt() on IP_MULTICAST_IF
gintf is really undefined.

Merged, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
