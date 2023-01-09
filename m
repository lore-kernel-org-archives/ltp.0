Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D1BC54EBE
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 11:05:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE0A73CCB82
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 12:05:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 694E03C6E7C
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 12:05:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 64B4F1400429
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 12:05:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35291387BF;
 Mon,  9 Jan 2023 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673262304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zC8xtE/jk2jf9UxRG3GMFsdYRTeP7/Aht8iN5FDeo1o=;
 b=LdRq4R7AYaFmsxMEPoJMVLpsfOsIhO3nP93vhvc2KuZ+AXwK1U6GLcm0JPFjpWtAdmQHzD
 z1higUbOOj+bh1gFvaFrmeUX0YFBo2HCugv67yTDCjAuyv/r+nVmjec6bXvGWFI1MabcUW
 n1gqiRGaqqSQGmiXMxH09m/FTf1MWdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673262304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zC8xtE/jk2jf9UxRG3GMFsdYRTeP7/Aht8iN5FDeo1o=;
 b=fzGqimQIZpxzcpb02zjEOAo+5kT3Xra3gohS1PizcdwUMJhi7iG2t0oYtaijzkl6ViZH0Z
 OgEJSjMQNc8TDqDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 680FD134AD;
 Mon,  9 Jan 2023 11:05:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qy65Ct/0u2OiMwAAMHmgww
 (envelope-from <akumar@suse.de>); Mon, 09 Jan 2023 11:05:03 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 09 Jan 2023 16:35:00 +0530
Message-ID: <2226132.28uSQYClPH@localhost>
Organization: SUSE
In-Reply-To: <20230104100730.20425-1-pvorel@suse.cz>
References: <20230104100730.20425-1-pvorel@suse.cz>
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>

On Wednesday, January 4, 2023 3:37:30 PM IST Petr Vorel wrote:
> * Signed-off-by
> * code style
> * links to wiki (API, maintainer checklist, ...)
> * wrap text in html comments (instructions will not be visible)
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .github/pull_request_template.md | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/.github/pull_request_template.md b/.github/pull_request_template.md
> index 477f49c6bc..1082bcdd88 100644
> --- a/.github/pull_request_template.md
> +++ b/.github/pull_request_template.md
> @@ -1,8 +1,22 @@
>  [ type description here; PLEASE REMOVE THIS LINE AND THE LINES BELOW BEFORE SUBMITTING THIS PULL REQUEST ]
>  
> -Although we *occasionally* also accept GitHub pull requests, the *preferred* way is sending patches to our mailing list: https://lore.kernel.org/ltp/
> -
> +<!--
> +* Although we *occasionally* also accept GitHub pull requests, the *preferred* way is sending patches to our mailing list: https://lore.kernel.org/ltp/
>  There is an example how to use it: https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial#7-submitting-the-test-for-review (using git format-patch and git send-email).
> -
>  LTP mailing list is archived at: https://lore.kernel.org/ltp/.
>  We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list/.
> +
> +* Commits should be signed: Signed-off-by: Your Name <me@example.org>, see
> +https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> +
> +* New code should follow Linux kernel coding style, see
> +https://www.kernel.org/doc/html/latest/process/coding-style.html.
> +You can run 'make check' or 'make check-foo' in the folder with modified code to check style and common errors.
> +
> +* For more tips check
> +https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist
> +https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
> +https://github.com/linux-test-project/ltp/wiki/C-Test-API
> +https://github.com/linux-test-project/ltp/wiki/Shell-Test-API
> +https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
> +-->
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
