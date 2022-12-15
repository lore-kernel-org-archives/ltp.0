Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6261CC4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 10:23:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46B893CBCCB
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 11:23:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8588F3C8B38
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 11:23:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EC2411A00A4A
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 11:23:04 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E211C21D58;
 Thu, 15 Dec 2022 10:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671099783;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqSafb1CNooqqreqBoaXgfRu7eoM0HJVpIEH4Jzvk1c=;
 b=IyGWW4LBnuFhtPXOEikN0SRhYGv7KMY2LyZI3Hn7dkUpTgod8pLuf9YbCXc2LE711bwz4d
 BoB2knRst62LlKbDHdzYxoCsWwVQ4jH5g5l82gtE74+VtPzZeWQvl2rEQsGMuJ6xUDRZ8c
 k/fLKYTZOxwlgf2nG7eLRlYTarPU3CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671099783;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqSafb1CNooqqreqBoaXgfRu7eoM0HJVpIEH4Jzvk1c=;
 b=sJEBzj4r/ENe3yU1Dvo01oKTIqJflP1D+Pjjxom7JMkvfz8FQfe5bKCjA9tWCJ6umi8cUp
 5G3QAvXkBgE+F7Cg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B6BE52C141;
 Thu, 15 Dec 2022 10:23:03 +0000 (UTC)
References: <20221215021903.2230206-1-raj.khem@gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Khem Raj <raj.khem@gmail.com>
Date: Thu, 15 Dec 2022 10:22:17 +0000
Organization: Linux Private Site
In-reply-to: <20221215021903.2230206-1-raj.khem@gmail.com>
Message-ID: <87tu1xotiw.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] testcases: Fix largefile support
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

Khem Raj <raj.khem@gmail.com> writes:

> Use standard functions ( not 64-bit equivalents ) which operate on off_t
> and pass -D_FILE_OFFSET_BITS=64 to enable LFS always so off_t is 64bit
> for these tests.
>
> This helps making it portable across musl which has removed the 64bit
> transition functions from _GNU_SOURCE namespace.

Looks and sounds reasonable, let's see if it works on older distros:

https://github.com/richiejp/ltp/actions/runs/3703162227

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
