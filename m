Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049ABC46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 10:43:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52A6E3CCB23
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 11:43:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E94743C85F1
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 11:43:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B9291400063
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 11:43:43 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D09EE4E70C
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 10:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673347422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VC86ezjp6frv7h/2/mVgjKlVmOSADHtR9DrmNUBcx1s=;
 b=06urfxSMCd/GsIR+h+3eaBULpyT7BZ6E1zCt806SAEand7mSz7dA9LyFO+M2yIzxeJCU/P
 maqQRt9xcaKGu/lYuXBZA+2duXfHDD0Z6ASRcj3ZEODsiLYfDDWx3fGzmeZaOM9AV2yRJG
 vPYlVcdRJpclBGjEPFalJZRw/2ZHRCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673347422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VC86ezjp6frv7h/2/mVgjKlVmOSADHtR9DrmNUBcx1s=;
 b=Vou5/7sfsir9MVrUUTm9m7swwcQwGVFdF1AJL/aitt0xK7092dV7893i9B585CKQTDZLPX
 xo4Y3ZPhvUaPE/AA==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8A7532C142;
 Tue, 10 Jan 2023 10:43:42 +0000 (UTC)
References: <20230104100730.20425-1-pvorel@suse.cz>
 <2226132.28uSQYClPH@localhost> <874jsyiufl.fsf@suse.de>
 <Y709W2qjGVFqvnvU@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Jan 2023 10:38:40 +0000
Organization: Linux Private Site
In-reply-to: <Y709W2qjGVFqvnvU@pevik>
Message-ID: <87v8lehdpe.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] github: Improve pull request template
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

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie, Avinesh,
>
> thanks for your review.
>> Hello,
>
>> Please merge.
> Before merge, are you ok with one more change?

Yes, although

>
> Kind regards,
> Petr
>
> +++ .github/pull_request_template.md
> @@ -9,6 +9,11 @@ We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list
>  * Commits should be signed: Signed-off-by: Your Name <me@example.org>, see
>  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
>  
> +* Commit message should be meaningful, following common style
> +https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes
> +https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> +https://chris.beams.io/posts/git-commit/

This redirects to https://cbea.ms/git-commit/.

> +
>  * New code should follow Linux kernel coding style, see
>  https://www.kernel.org/doc/html/latest/process/coding-style.html.
>  You can run 'make check' or 'make check-foo' in the folder with modified code to check style and common errors.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
