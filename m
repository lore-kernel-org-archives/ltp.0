Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C07C43334
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 13:19:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EA4E3C9F6D
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 15:19:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 818343C062C
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 15:19:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 913611000224
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 15:19:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DB831FB75;
 Thu, 14 Jul 2022 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657804730;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3y2OF7XlcaL4oCtFxKduZT1hz3vXmKXsiE9SdQQi8x0=;
 b=dN/uMosmFLzRaTR0s9E7JOvqDuP9623fKZXLSGz6xgN+JvYEttuZtk5a4JpGWE8J4dNREW
 DNbXXYy70BRjzfrV4fN76V0vsxlB5K+anGF84uixMV0GHLXQcWzEej8dQruskyNc+OUzWa
 mxsJpmzjMdhR/Gb/u0vHE+RfTIztEto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657804730;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3y2OF7XlcaL4oCtFxKduZT1hz3vXmKXsiE9SdQQi8x0=;
 b=NEFicirmep8W3diK/cil7fjmUny9b+CFOr+ZyimFEo5QKiyEE+ph7nOutCgmyRLBwgUsuw
 uQfAY5hcjPkdfEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB61413A61;
 Thu, 14 Jul 2022 13:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id e4jnM7kX0GIzFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 14 Jul 2022 13:18:49 +0000
Date: Thu, 14 Jul 2022 15:18:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YtAXuBDka4VC90q/@pevik>
References: <20220714124611.9772-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220714124611.9772-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] open06.c: convert to new LTP API
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> -	if (mknod(fname, S_IFIFO | 0644, 0) == -1)
> -		tst_brkm(TBROK, cleanup, "mknod FAILED");
> +	SAFE_MKFIFO(TEMP_FIFO, 0644);
You changed test from mknod() to mkfifo(). May I know why?
It would be worth to mention the reason in the commit message.

Should not we keep mknod() ?
SAFE_MKNOD(TEMP_FIFO, S_IFIFO | 0644, 0);

According to man mknod(2) your change is correct:

       POSIX.1-2001 says: "The only portable use of mknod() is to create
       a FIFO-special file.  If mode is not S_IFIFO or dev is not 0, the
       behavior of mknod() is unspecified."  However, nowadays one
       should never use mknod() for this purpose; one should use
       mkfifo(3), a function especially defined for this purpose.

Also note LTP tests should test even deprecated kernel API, we *might* want to
test both mkfifo() and mknod() via .test_variants. But I'd like to hear the
input of the others, because both glibc and musl use SYS_mknod or SYS_mknodat
for mkfifo() implementation with very thin wrapper, thus not sure if it's worth
to test also mknod().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
