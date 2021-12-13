Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA84CC433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:44:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD1A73C8989
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 09:44:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CE203C8809
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 09:43:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8A135200B8C
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 09:43:56 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A0C141F3B0
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639385035;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGjYXZfDGwDvZtihI5hG0924zmLqxDYM13C4Wwcsthc=;
 b=xi096QM6Coa0Q+5m+Ba27mvL1oNosuohvcfAQ/JkcQNrQQiaq5BDL7w3SKrS0COiFRuHvf
 6GIU8Vkzaz5y68go38APBWffeQdx8341FXHENc1ULzSJ6L7lj2qEo2n7jLZdnJkyVr9eKl
 U4svBalzpWY3cL5hlgC+DVn4lxNY5co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639385035;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGjYXZfDGwDvZtihI5hG0924zmLqxDYM13C4Wwcsthc=;
 b=VRu2mbApCjJW6V726Y9VUghM0rWBGJfHWyW4UFZtMhFfOGAS6A5RXVFMRLrLyQDAXjOcC+
 SeLAy3BQgv4c07Dg==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6E0FFA3B8A;
 Mon, 13 Dec 2021 08:43:55 +0000 (UTC)
References: <20211210134556.26091-1-pvorel@suse.cz>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Dec 2021 08:22:00 +0000
In-reply-to: <20211210134556.26091-1-pvorel@suse.cz>
Message-ID: <87tufcao8l.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/maintainer-patch-review-checklist.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
> index c7bb47810..4e2b267ac 100644
> --- a/doc/maintainer-patch-review-checklist.txt
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -34,6 +34,9 @@ New test should
>    GPL-2.0-or-later; the licence for test (e.g. GPL-2.0) should not change
>    unless test is completely rewritten
>  * Old copyrights should be kept unless test is completely rewritten
> +* Tests for new functionality in mainline kernel should be merged after final
> +  release of kernel which contains that functionality (it's not enough when the
> +  feature gets into rc1, because it can be reverted in later rc if
> problematic).

What is the concern? All I can see is that we merge a test which is for
a feature that is never included

The issue is we may forget to merge patch sets for features which are
included (a far worse result). It's more stuff waiting around in the
queue. At the least we should have a procedure for tracking them (like
tagging github issues for review at each mainline release).

If a test requires a kernel config which doesn't exist in mainline we
could also look for that automatically.

>  
>  ### C tests
>  * Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C API]
> -- 
> 2.34.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
