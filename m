Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC3CC433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:16:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3A753C9722
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:16:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F92C3C9644
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:16:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CC02D1000F00
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:16:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EA4E71F45E;
 Fri, 21 Jan 2022 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642760201;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C1JRWEll0JseZmwnlJHCCXStZaaMMGBi56gJm37ZLxw=;
 b=WFR6o9z7APm4BTXROFFmovd0pvf6H/MT3Azvokna86weL1p89ie3wH0Rpl9vh4n24kfEqF
 9/FC7nFgc/Lhh8ikY7UR6mVUno7xuSK3I1V8AK6gSd9mF8MfeFrZVB7JDQevQz9Ul5sCgu
 urFyGrTd+Zd40vgzmNR59Coewqfe4BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642760201;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C1JRWEll0JseZmwnlJHCCXStZaaMMGBi56gJm37ZLxw=;
 b=2JqeXQvbuNY1/1aFh2ni4y8AVNjKr/fDGL3e08N9p71kJeop4AqiTDqbSXdaUIWG3RzKWN
 Guax4M0Vj84Wp7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B149113C0F;
 Fri, 21 Jan 2022 10:16:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I/LVKQmI6mEWaQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 10:16:41 +0000
Date: Fri, 21 Jan 2022 11:16:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YeqIB+Y4rO2XK57i@pevik>
References: <20220121100604.1072-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220121100604.1072-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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

Hi all,

[Cc Li ]

> tmpfs does not support it.
Verifying with .all_filesystems, that only tmpfs is problematic
- tested on exfat, ntfs over FUSE, vfat (common linux filesystems obviously work)

That's why I avoided opening file with O_DIRECT in setup().

BTW I wonder what is the reason of duplicate entries in ltp-aiodio.part4?
i.e. dio_sparse, aiodio_append, dio_append, dio_truncate...
To create bigger load?

IMHO it'd make sense to run at least one test on .all_filesystems to check more
filesystems (dio_append seems to be quick), but I wouldn't done it when there
are duplicate entries.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
