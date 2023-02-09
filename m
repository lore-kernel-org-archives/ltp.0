Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CF6C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:52:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12C073CC0A3
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 15:52:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E1353CB0EA
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:52:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BF8B11A007FE
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:52:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B69DF5CAE7;
 Thu,  9 Feb 2023 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675954323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EjkIQbT43hJ8H9PcYTBL55jUl8QfpNAyW1d/GpC48dw=;
 b=PHnsxY7oAC4I3iHQf8obZSAKPdCmLkLPAhhb4om8dKRxKrnts9mz+HIm7yP1yKlEuyHKo5
 Vy25GXREbAR9bEGPCvZfFqVoq+lvWBed7FVyAKpwgNPWkha7RvBRnf5ZVqaB3Ju2Ymx1Ud
 MELvIhLI7T59+PFnFRF240K9T15NhJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675954323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EjkIQbT43hJ8H9PcYTBL55jUl8QfpNAyW1d/GpC48dw=;
 b=HZYI7Qw1da7UpyBZCXCVIZBaLJnqzY/1YuQa6m/Q5mN4iGSLMF2K9CATJyOB2d9yBFasJU
 hqgdkLIPN5VjHDCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A36F5138E4;
 Thu,  9 Feb 2023 14:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZWmPJpMI5WOKIwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Feb 2023 14:52:03 +0000
Date: Thu, 9 Feb 2023 15:53:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y+UI7lmdULFVhMWN@yuki>
References: <20230129115021.25778-1-wegao@suse.com>
 <20230209131902.12260-1-wegao@suse.com> <Y+UAENJVDUSDPAay@pevik>
 <Y+UCwJZhgIlP5Sjs@yuki> <Y+UF4eCFAR0jy7P7@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+UF4eCFAR0jy7P7@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fsconfig: New case cover CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I'd test all kernels and expect them to return EINVAL.
> Because 722d94847de29 was backported to 5.10.x and 5.4.x stable kernels.
> It'd be worth to check how it behaves on older stable (e.g. 4.19.x) and either
> raise .min_kernel lower than 5.4 if easily modified behavior for older kernels
> or ask for 5.4 otherwise. (I mean .min_kver = "5.17", is too aggressive).

As long as the backported fix causes fsopen() to return EINVAL we should
check for it as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
