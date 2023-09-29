Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95423E743EF
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 07:06:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B56DA3CE0F8
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 09:06:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0665A3CB62A
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 09:06:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 660DD602787
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 09:06:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4ACE81F8C3;
 Fri, 29 Sep 2023 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695971200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pI7n7/0G6wEclOD+7akogDuGGeShtZOPxSpOfu3ni20=;
 b=GvE0NvMi8HnD6IaFqsc1GE5+GCLIkBOxPTeUOLTqTHermr2/F6AtA8rc11oJ8Iq+QG04Q7
 WNwXpZ2uBErdvMp8SwoiLs8H/wSylqCQtlbFzeKwcNsn86unktgPQaON2bgOLV0uGlPlJL
 gRh4MqkZ0OQ0/R6y4eKVsnrz0puz540=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695971200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pI7n7/0G6wEclOD+7akogDuGGeShtZOPxSpOfu3ni20=;
 b=6Fqdb0bzXMzswnHCEOxh8nYr9ectl4ge7vmUqvTMjBKM16CaWo46hU5c52u1NDVnK83kY1
 EyP8HJIwdLrIlBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E995C1390A;
 Fri, 29 Sep 2023 07:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YlKHN393FmUpQwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Sep 2023 07:06:39 +0000
Date: Fri, 29 Sep 2023 09:06:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20230929070638.GA333901@pevik>
References: <20230927202121.300325-1-pvorel@suse.cz>
 <20230927202121.300325-6-pvorel@suse.cz>
 <12123900.MKNY5bReCh@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12123900.MKNY5bReCh@localhost>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/6] doc: Update release procedure
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh, Li, Cyril, all,


> Hi Petr,
> Thank you for these scripts and documentation, makes the release process very 
> clear.
> I didn't try running the scripts but looks fine.
> Few minor spelling and grammatical nits below:

Avines, thanks a lot for your review and catching typos.
I shortened the output of the examples a bit and merged.
https://github.com/linux-test-project/ltp/wiki/LTP-Release-Procedure

Now waiting for CI to finish the build (just for sure) before tagging the
release and doing the rest the work.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
