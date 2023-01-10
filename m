Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99185C54EBC
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 10:26:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E2153CCB18
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 11:26:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 788613C85F1
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 11:26:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B712C1000540
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 11:26:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7CB0E38B6B;
 Tue, 10 Jan 2023 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673346397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n17qoW7dTYzwkGh2pDQJPJN+UxFHLUnq5ZVGlbaD/7I=;
 b=lz0CPgzh1QPzdHAhfHjBVUMdXrqRymLDZlM7iNvIZOn4v5C4ERA1tEVtG49MaxPiGPa6bw
 FY6Ar82gUnc899mhUY1d5PSQlK7Ub3LQzK2mPsveWTK7+YmsdujQBX6nr4pRuUoNru68m6
 VTFkfiTsmMKW381cN0ozu5snyXUciAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673346397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n17qoW7dTYzwkGh2pDQJPJN+UxFHLUnq5ZVGlbaD/7I=;
 b=4aobwG/qF8JCR76FW9X633QKQp9dt0aT/3aIET1Xx/0VAel4l9TWhnVq3sStzzUZNX3fKb
 dZsgANBizBaOpHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24B571358A;
 Tue, 10 Jan 2023 10:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AzeFB109vWOHVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 Jan 2023 10:26:37 +0000
Date: Tue, 10 Jan 2023 11:26:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y709W2qjGVFqvnvU@pevik>
References: <20230104100730.20425-1-pvorel@suse.cz>
 <2226132.28uSQYClPH@localhost> <874jsyiufl.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874jsyiufl.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie, Avinesh,

thanks for your review.
> Hello,

> Please merge.
Before merge, are you ok with one more change?

Kind regards,
Petr

+++ .github/pull_request_template.md
@@ -9,6 +9,11 @@ We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list
 * Commits should be signed: Signed-off-by: Your Name <me@example.org>, see
 https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
 
+* Commit message should be meaningful, following common style
+https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes
+https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
+https://chris.beams.io/posts/git-commit/
+
 * New code should follow Linux kernel coding style, see
 https://www.kernel.org/doc/html/latest/process/coding-style.html.
 You can run 'make check' or 'make check-foo' in the folder with modified code to check style and common errors.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
