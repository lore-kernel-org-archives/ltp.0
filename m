Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D21C7114A
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 06:56:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FD7B3CC1F8
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 08:56:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B79D73C0143
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 08:56:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 19ED71A001CE
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 08:56:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 435292121A;
 Tue, 17 Jun 2025 06:56:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 314C5139E2;
 Tue, 17 Jun 2025 06:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vkPJCqMRUWiaWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Jun 2025 06:56:35 +0000
Date: Tue, 17 Jun 2025 08:57:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aFERx8dRidPTqsvi@yuki.lan>
References: <20250617-ci_docs_build_fix-v1-1-7d0654f0cd7d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250617-ci_docs_build_fix-v1-1-7d0654f0cd7d@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 435292121A
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: revert "Run sphinx test only when files
 changed"
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

Hi!
> Revert 180bc2bb9 in order to build documentation when pushing
> to the master branch.

Maybe add a note here that the test catalog and statistics has to be
rebuild on each push.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .github/workflows/ci-sphinx-doc.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
> index e77c766871b98114417dc7d8d1cb108afe885735..457aa5a2355d1d93db243090ca31b1c634338b25 100644
> --- a/.github/workflows/ci-sphinx-doc.yml
> +++ b/.github/workflows/ci-sphinx-doc.yml
> @@ -5,7 +5,8 @@ name: "Test building sphinx doc"
>  
>  on:
>    push:
> -    paths: ['doc/**']
> +    branches:
> +    - master
>    pull_request:
>      paths: ['doc/**']
>  
> 
> ---
> base-commit: 2bce711e96004e619d51170302bf7ce9162f1231
> change-id: 20250617-ci_docs_build_fix-1f2f976a897d
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
