Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEF7CCA479
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 13:33:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8D9A3CA00C
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 15:33:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72AC3C9FE8
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 15:32:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0D8091000678
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 15:32:56 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3003C200C0
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1656941576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2h7LiFd+EHsBINVJVa6pJFECNBuJZHj9LL0ySxdpAE=;
 b=arR0hnK+MYnim7RvesccJPMWeGsdVy2UZc0J4H6ekhyepKJtDP4J7TW3SCEYkuWzzyWztD
 Gi5DXdpIXjM/TZabxnPCtLiQaAbnNalCJGsOYCHJB68Q6S8wrGyB7MOOh7G2gRp28jrz/T
 uvQi9Guaf0DqywTWneBBtOjbki6hS1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1656941576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2h7LiFd+EHsBINVJVa6pJFECNBuJZHj9LL0ySxdpAE=;
 b=RqvCjgbUHbi80iBQfu4dd+GoyNN9T+wVPcl8ECSbJ++VggH0LqrZzpWFtnjHR7RIgM23aq
 7Wnh4OrUhdFIC4AQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0039D2C1AF;
 Mon,  4 Jul 2022 13:32:55 +0000 (UTC)
References: <20220623080215.24186-1-akumar@suse.de>
 <20220623080215.24186-5-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 04 Jul 2022 14:31:56 +0100
In-reply-to: <20220623080215.24186-5-akumar@suse.de>
Message-ID: <87k08tt33s.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/6] Rewrite utime04.c using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

>  
> -/*
> - * void
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *  Remove the test directory and testfile created in the setup.
> - */
> -void cleanup(void)
> -{
> -
> -	tst_rmdir();
> -
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1
> +};
> -- 
> 2.36.1

Why don't we do this one on all file systems as well?


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
