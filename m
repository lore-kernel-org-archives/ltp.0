Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85C7EED60B
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 15:28:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AC3F3CE6A1
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 17:27:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C492E3CB576
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 17:27:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9825A1400F9A
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 17:27:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5CEC81FD73;
 Fri, 15 Sep 2023 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694791666;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaBAXIxNQHORxepXyves6M7YNPWedYDoFXbqapobX4w=;
 b=u3gNKBdGrmqT/NhiwhT55YKxfD9xLlFLwcmhhkRIRg47SJbKQJBMAFgpoWusB0k8h/KDdd
 /6aTIGd/nexdVDnML3vXG+WPCO1iGzrRlM0rPgD2L1rbnTrCpUiCIywJwPgA29+TTYXC2K
 3XvmY3xnpeyPd6x5sKU6iYcGb7cHpYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694791666;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaBAXIxNQHORxepXyves6M7YNPWedYDoFXbqapobX4w=;
 b=9OqMLtXIWMi5wic9HOUEZBQazNxUyexEiwgGrZo0f0p+cpzsxhMZwvOOpoMcXri6S1Fq08
 luvPBgAzNySyexCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B0791358A;
 Fri, 15 Sep 2023 15:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pMObA/J3BGVtHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 15:27:46 +0000
Date: Fri, 15 Sep 2023 17:27:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230915152744.GA73280@pevik>
References: <20230915144156.22380-1-andrea.cervesato@suse.de>
 <20230915144156.22380-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230915144156.22380-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Replace runltp-ng with kirk framework
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

Hi Andrea,

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> Kirk application is a fork of runltp-ng and it aims to merge multiple
> Linux testing frameworks in one tool, providing support for remote
> testing via Qemu, SSH, LTX, parallel execution and much more.
Maybe s/fork/successor/ ?

I'd note here, that kirk is based on runltp-ng and deprecating runltp-ng
(just to be obvious that it's not a huge change). Also I'd note there is a
backwards compatibility with runltp-ng.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .gitmodules     | 6 +++---
>  tools/kirk      | 1 +
>  tools/runltp-ng | 1 -
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  create mode 160000 tools/kirk
>  delete mode 160000 tools/runltp-ng

> diff --git a/.gitmodules b/.gitmodules
> index d1d558b9e..088023039 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -4,6 +4,6 @@
>  [submodule "tools/sparse/sparse-src"]
>  	path = tools/sparse/sparse-src
>  	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> -[submodule "tools/runltp-ng"]
> -	path = tools/runltp-ng
> -	url = https://github.com/linux-test-project/runltp-ng.git
> +[submodule "tools/kirk"]
> +	path = tools/kirk
> +	url = https://github.com/linux-test-project/kirk.git
> diff --git a/tools/kirk b/tools/kirk
> new file mode 160000
> index 000000000..805c56c2a
> --- /dev/null
> +++ b/tools/kirk
> @@ -0,0 +1 @@
> +Subproject commit 805c56c2a69b2e9f24ba13f64eab1bdad5885678
Why not add the master HEAD c7419dd ("Fix qemu login prompt recognition")?

https://github.com/linux-test-project/kirk/commit/c7419dd6f73d90f3f02aa17d30270e895e30c88e

IMHO it'd be better to use it, instead of 805c56c (HEAD~).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> diff --git a/tools/runltp-ng b/tools/runltp-ng
> deleted file mode 160000
> index e842511ed..000000000
> --- a/tools/runltp-ng
> +++ /dev/null
> @@ -1 +0,0 @@
> -Subproject commit e842511ed2c680e3b2ea6dec790913a41d5ed937

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
