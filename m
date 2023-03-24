Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6CEC6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 05:51:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A31703CBF43
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 06:51:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 568513CA4F3
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 06:51:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 123881400FAB
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 06:51:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C71521871;
 Fri, 24 Mar 2023 05:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679637066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpRdws2WdX/QljXCj++ptvxXhajo959gICxwL2l2L1M=;
 b=C2hHTqPDx2jN74OzyyPi/jlmBTrW/q7RioHayaHIaYdQGRFbIbAI7zOXBprSRyunyLcygu
 vYuCOuANczDO6umxPnltyY/RbdNqqxkvy74pUfQN5mPXJNvtBjTkTearkKH6aBN75YYVT/
 4vlDzH832ce4Nlv/Vw2etEOp63fn93Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679637066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpRdws2WdX/QljXCj++ptvxXhajo959gICxwL2l2L1M=;
 b=ZpxNuxNWBenNaVK/8tGPHDEAYIxxinD9JtqcaYbwlv0bifr709VFJmaReOreaVEPELZXFH
 FquvcOOEAm9Y8aCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18A4513A10;
 Fri, 24 Mar 2023 05:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PImGA0o6HWSFMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 24 Mar 2023 05:51:06 +0000
Date: Fri, 24 Mar 2023 06:51:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230324055103.GA514297@pevik>
References: <20230314093725.3814-1-wegao@suse.com>
 <20230323121026.28710-1-wegao@suse.com>
 <20230323121026.28710-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323121026.28710-2-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/2] tst_kernel: Add function check if the
 kernel module is built-in
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

Hi Wei,

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/tst_kernel.h | 14 ++++++++++++--
>  lib/tst_kernel.c     | 36 ++++++++++++++++++++++--------------
>  2 files changed, 34 insertions(+), 16 deletions(-)

> diff --git a/include/tst_kernel.h b/include/tst_kernel.h
> index 9e17bb71e..884a1c7f9 100644
> --- a/include/tst_kernel.h
> +++ b/include/tst_kernel.h
> @@ -10,8 +10,18 @@
>   */
>  int tst_kernel_bits(void);

> -/**
> - * Checks support for the kernel driver.
> +/*
> + * Check if the kernel module is built-in .
Patchset merged with removed extra space before dot in the end.

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
