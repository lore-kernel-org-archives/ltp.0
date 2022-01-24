Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB48FC433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 17:19:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 913783C9396
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 18:19:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E4323C6F6F
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:19:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB94A1000457
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:19:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F2D5B1F382;
 Mon, 24 Jan 2022 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643044756;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fw534h5AHsj3wDozGBK9UcwZuDb1twr4dHdu3+LZ0+M=;
 b=Bvzb+IHHjyDLkF3ZjCk43UX2Soqu80AxB88Zcw/aSuRjd39C+7owX7ZdD3CM0yRdpq05u+
 kp7iILtgG1Rw6N+GKB63j575a8kYALtVPjbfK12rV9Pzyx9EsXSi6+lc8bKIACvPSh06Qa
 ocjY0TK/4bRwwP0tMKmtu8IUIOVbbk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643044757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fw534h5AHsj3wDozGBK9UcwZuDb1twr4dHdu3+LZ0+M=;
 b=jzmymY2OxCA4nBO0U8ApjCdeuqXnVbfPFuAxgX1uKYNiz1J7v7cBMh1uH3cBiJGdrGrbws
 qeZ8Tg/Ukm53i5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D17DB13C41;
 Mon, 24 Jan 2022 17:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eqgMMpTf7mHlWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 17:19:16 +0000
Date: Mon, 24 Jan 2022 18:19:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ye7fk1XvKjxYDC3y@pevik>
References: <20220114194444.16949-1-pvorel@suse.cz>
 <20220114194444.16949-3-pvorel@suse.cz> <Ye6/g0InSIT4J3kV@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ye6/g0InSIT4J3kV@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc/user-guide: Remove "2. Colorized output"
 section
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

Hi Cyril,

> > -| 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
> > -                          'n' or '0': never colorize.
> > +| 'LTP_COLORIZE_OUTPUT' | By default LTP colorizes it's output unless using
> > +                          pipe or redirect to file.  Force colorized output behaviour:

> Slightly better: "unless it's redirected to a pipe or file"
+1, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
