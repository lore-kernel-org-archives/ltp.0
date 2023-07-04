Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C6BEB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 09:26:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C825B3CE06A
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:26:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 635183C997B
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:26:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BEDE4140051A
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:26:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BF1922663;
 Tue,  4 Jul 2023 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688462792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9NF7gK1MYOVMTQ5ChEsKSF41cFknmJnYJL6lhV5jEI=;
 b=QJ2rDOS+AYER2Essn4n/a9Ctnfewa1a/0GaI6U0EQHysW/mHVDTWngncm/inXo9OROwSjT
 09LXVXPcWEGInObAtfE31u7Dfgxf46TD1MdlP8Dlth9Un9pq+iFp0MMVqPh4rwOoVEd59Y
 c1Mc6rfWRfGdfxVG4VXlbsOlxRlWGHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688462792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9NF7gK1MYOVMTQ5ChEsKSF41cFknmJnYJL6lhV5jEI=;
 b=RkXY2R0rJt/GiGeeU4dhJhaPP5V6kQUO1SFCOnLPL0In6fMIEnb7R342c5vj0Pecd8WFAC
 CFhs5dp9wSGfQxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8F3D133F7;
 Tue,  4 Jul 2023 09:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JWT+L8flo2T7TAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 09:26:31 +0000
Date: Tue, 4 Jul 2023 11:26:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230704092630.GB497945@pevik>
References: <20230704091933.496989-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230704091933.496989-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/3] Makefile: Add C header with generated LTP
 version
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Hi,

> obviously this is wrong, because $(top_srcdir)/Version (ltp-version.h
> dependency) is not specified in the top level Makefile (only Version is
> there). But I'm not sure if it should be changed to
> $(top_srcdir)/Version.

> I suppose ltp-version.h should be in include/, but here I'm completely
> lost with dependencies under lib/. My goal is to type make in lib/ and
> make sure the header is generated (dependencies correctly resolved).

> Kind regards,
> Petr

> Petr Vorel (3):
>   Makefile: Add C header with generated LTP version
>   lib/C-API: Add option -V to print LTP version
>   lib/C-API: Print LTP version at test start

>  .gitignore     | 1 +
>  lib/Makefile   | 4 ++++
>  lib/tst_test.c | 8 ++++++++
>  3 files changed, 13 insertions(+)

please ignore this patch. Subject was supposed to be
"[RFC PATCH 0/3] C API: print LTP version"

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
