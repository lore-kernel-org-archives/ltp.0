Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65178CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:23:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF7703CE4FC
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:23:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 352313CA983
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:23:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0FADB1000F22
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:23:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F1C421AD9;
 Mon, 18 Sep 2023 11:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695036192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VWRGoqwvmzam44fx8oLAnWtHB2Gjj1iUJTs6EtvzZ+w=;
 b=qj6BCY1xnV+hqgO90BopzdiLacMylitTHcEanLq5jwcJbtiH8hI4bXoFjNqvzREh4irlJP
 cmGI30pow7rSBC4YaVDdWHUDA3WPZODW5pzYt7wE9OwlwONkTh9o6ldY9hW7FLq/Jkt4cY
 vJyeOuizbDCgfuhOPdbpzyBSNdE9Y5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695036192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VWRGoqwvmzam44fx8oLAnWtHB2Gjj1iUJTs6EtvzZ+w=;
 b=R28JKm6JdPMRa2ygZbMdWfSjfM6KTDrd+NIDhU16ndNIjWT8TOunFQpPTjmljXD5P+TImc
 9HxKPBC5xOk6L0Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF4D013480;
 Mon, 18 Sep 2023 11:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gqQWMB8zCGXJVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 18 Sep 2023 11:23:11 +0000
Date: Mon, 18 Sep 2023 13:23:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230918112310.GB29246@pevik>
References: <ZQF5J0UJ25_QLwcQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQF5J0UJ25_QLwcQ@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

Hi all,

Richie suggested [1] to merge my fix for zram01.sh [2] [3].
If we agree on this, I'll send v2 with renamed function
check_read_mem_used_total() as Li suggested [4].

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/87a5tjhl24.fsf@suse.de/
[2] https://lore.kernel.org/ltp/20221107191136.18048-2-pvorel@suse.cz/
[3] https://patchwork.ozlabs.org/project/ltp/patch/20221107191136.18048-2-pvorel@suse.cz/
[4]
https://lore.kernel.org/ltp/CAEemH2fYv_=9UWdWB7VDiFOd8EC89qdCbxnPcTPAtGnkwLOYFg@mail.gmail.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
