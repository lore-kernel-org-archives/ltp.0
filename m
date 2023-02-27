Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0E7C64ED8
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 11:23:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 666783CDE53
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 12:23:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EE6A3CAF43
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 12:23:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 18398145E0B2
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 12:23:25 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 47DFE219C3;
 Mon, 27 Feb 2023 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677497004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z94SqzQfItGYtMc6Fz/VBURyFxttY9pGANoAKvf0xl8=;
 b=udLSapz23soyitYuyguFWutlwatgWJsmnQOiRPxfC4ABBDqkbAieLf3FIdDduSVkCJsuKf
 ayDPTcNdcox3DAe43dSz2JvsnFlkZ/IOr8kOnnLQiAZZIZKWMXdecC1XGxWILUJSpcyTTT
 CbYlM5IceLDkDGmk9MeyN5mala0/rok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677497004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z94SqzQfItGYtMc6Fz/VBURyFxttY9pGANoAKvf0xl8=;
 b=IKIkXQ8LfL0d+jnY+dHudsPFI8VVmOLMSghsD8qoTLMbNc7kVYpFhD+QKAgN7m8LxtNbvb
 LSgly5Ly26b4CaAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 48A442C141;
 Mon, 27 Feb 2023 11:23:23 +0000 (UTC)
References: <87h6vpq2lk.fsf@suse.de>
 <20230220102645.16842-1-william.roche@oracle.com>
 <20230220102645.16842-2-william.roche@oracle.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: william.roche@oracle.com
Date: Mon, 27 Feb 2023 10:16:04 +0000
Organization: Linux Private Site
In-reply-to: <20230220102645.16842-2-william.roche@oracle.com>
Message-ID: <87k003bbdn.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [LTP PATCH v3 1/1] madvise11: Add test for memory
 allocation / Soft-offlining possible race
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

william.roche@oracle.com writes:

> From: William Roche <william.roche@oracle.com>
>
> Test a possible race condition between mmap() allocating memory and
> madvise() used to Soft-offline an unrelated memory page.
> As fixed with the following kernel commit:
> d4ae9916ea29 mm: soft-offline: close the race against page allocation
>
> If everything works, restore all poisoned pages created by this test.
>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.de>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: William Roche <william.roche@oracle.com>

Merged, thanks!

I think this test is well worth the effort.

This took an extra week to get merged because we were at a workshop.

> +
> +static int sigbus_received;

I added volatile in an extra patch to this. Usually I would recommend
tst_atomic* instead, but it is protected by a mutex anyway.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
