Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7132C433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 16:52:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C2BB3C928A
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 17:52:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7B023C13E9
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 17:52:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2B7AF653A65
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 17:52:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 384641F37F;
 Wed,  5 Jan 2022 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641401563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B12uZ2YkA4ss5eQyLGyeQqeVriYjEu422khXgXhVAQU=;
 b=ha7VKqxl4sMCHOZciKSMv0gGP5/a/Odn9oZg92c6mdJ1nB2rnQ73UsBPTkwK9MJvNDOGNY
 wzCFLDI253Bi9t3vw2GWqIldsei+5eY6Bpcd80rHHofr0qwgQmgz0DBsX9b1RdJs0t4NVq
 Vza4SI4Z5lyxXVLuyPN3IhOnVBr75tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641401563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B12uZ2YkA4ss5eQyLGyeQqeVriYjEu422khXgXhVAQU=;
 b=VpLqiFlop5UzriNv5PHRNSRIvP79iC0u/1+MhoqGCeLk+1rqHtm4IKhPzTJ0VzkBE+kQhg
 nukUoz49WIBiOSDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07F2B13BF9;
 Wed,  5 Jan 2022 16:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kwEMANvM1WFpFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jan 2022 16:52:42 +0000
Date: Wed, 5 Jan 2022 17:52:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YdXM2RVh5WYaoV85@pevik>
References: <20211222192604.16839-1-pvorel@suse.cz>
 <20211222192604.16839-2-pvorel@suse.cz>
 <YdWzZzzOqpS2pN+3@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdWzZzzOqpS2pN+3@sol.localdomain>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] tst_af_alg: TCONF on ciphers disabled by
 FIPS
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

Hi Eric, Cyril,

> > NOTE: I asked Herbert Xu for confirmation that my code understanding is
> > correct and ELIBBAD is expected for ciphers disabled by FIPS.

> Can you link to the mailing list thread where it was established that ELIBBAD is
> the "expected" behavior?  Otherwise I guess this is fine.

Link added, fixed useless break and merged.
Thank you both!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
