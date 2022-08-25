Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B872ECAA25
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 16:39:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E2103CA496
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 18:39:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1A303C3090
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 18:39:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B79F21A00682
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 18:39:16 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C735E5C11E
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661445555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Yg9WbKUOLvKuCOvd1ATSODq3HUj39dwbbpu9k1YxEA=;
 b=RsAT35VxyQFAwR4Lxr+okAPFhekALLoB5xmiF0qb2cYxUiHjzmJ2AX/Qm+8DT6mYZHiu31
 a8M0SYRwbGEEX1HRwG4GNREuq+yXfLBby5AM8qKIMpiVX2mzVolNVOs0TtkTIzBrdAhyb2
 GWWNSewvfkcVjR6iyVhRVpRCJvSv/iY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661445555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Yg9WbKUOLvKuCOvd1ATSODq3HUj39dwbbpu9k1YxEA=;
 b=nJRk4dQvoPdP6OXAM0OfY6rq6xFPavWj3RDpqTZEe9kI1GcuiHynLSDMV58HQc+nzfTGLs
 f8CbI6mR4mUjTdAA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9679B2C141;
 Thu, 25 Aug 2022 16:39:15 +0000 (UTC)
References: <20220825135528.19653-1-akumar@suse.de>
 <20220825135528.19653-2-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Thu, 25 Aug 2022 17:36:29 +0100
In-reply-to: <20220825135528.19653-2-akumar@suse.de>
Message-ID: <87sflk1dn1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] inotify_init1_02.c: Convert to new LTP API
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

> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1

Both conversions look perfect, but do we need a temp dir? It doesn't
look like the tests use the file system.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
