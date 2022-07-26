Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCD6C00140
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 14:05:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8135D3CA105
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 16:05:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 975953C1BC6
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 16:05:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E718600847
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 16:05:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A6881FF4B;
 Tue, 26 Jul 2022 14:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658844310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uaj7h/0anzgQIFiAikg5HIMj6Tj+YBJC497QuayPCtg=;
 b=QE8iTYIgmMAT5PkfsZS27fRXtKOBn6U+EmgtpdO32BxvetRkhunrQixrARSbLl/gUPKbML
 40wI4yf+PN4VRw8pmsnVF1bGxMrnkfxygf4QR6q+hDw2Cpg2fU2Qv5lSzUcUesfaghyYyP
 6gbiuSJV8MgC9osm6Tw3BwqRBAo2hNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658844310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uaj7h/0anzgQIFiAikg5HIMj6Tj+YBJC497QuayPCtg=;
 b=owxSrUwqEdyToEubwrXbL02TKmBr6f6L9DDkqZ1ZgA4K7TKhv9cGNYNQHHa6JjFBnMkYmo
 Syc1kY1dKg5jPxAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4313813322;
 Tue, 26 Jul 2022 14:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CizVDpb032LNMQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 14:05:10 +0000
Date: Tue, 26 Jul 2022 16:05:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Yt/0lNuB6i7wvxE1@pevik>
References: <Yt+RA5chfBh54kvI@pevik>
 <20220726115234.25310-1-rpalethorpe@suse.com>
 <Yt/YIR+anMcbsEp2@pevik> <878rog3tbo.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878rog3tbo.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tools: Check headers with checkpatch.pl
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

...
> > LGTM, just a small nit: target for headers contain .h extension.
> > Shouldn't we add .c for C sources for consistency?

> > It'd strange, that make check in testcases/misc/math/float/ does not include
> > tfloat.h, but make check-tfloat.h prints errors. But make check in lib/ works as
> > expected (adds also *.h).

> The Sparse based tool does include headers though. So really we are
> checking the target which includes more than just a single c file.

Ah, that makes sense then. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
