Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72A5C46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 10:11:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 357C93CE4D2
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 12:11:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 776583CA3D7
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:11:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3C0B260065B
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:11:10 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7963A1FDA8;
 Mon, 18 Sep 2023 10:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695031870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eRmuQ/xkaKA1u14+e8VtGxgaIovidjaMy/a9Ap6fgW8=;
 b=LoZI1yIuvckoNqd/Z1j5G9v5vlOmmd4AU0s0S+y8eZnNHElGnYm1wgTyBumM+/q2xV8Cea
 bqo2kE+MXpWIjLBhQSRmZNrFLBxuvVaq021hrZ2gmPbo5wsH4Kih5+o2JdC4QTQjqN8yXV
 f80kPHkxgaKLpjAItBthLYwzfjlu6IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695031870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eRmuQ/xkaKA1u14+e8VtGxgaIovidjaMy/a9Ap6fgW8=;
 b=e/nSqTcg0Hno92bXsmMj+PqegmVt+pfFzKF2dsNAkrWSZxSixq743sfZx4J7s/7GdOg2SF
 e7HKbpMsRgltJnBg==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2D1D82C142;
 Mon, 18 Sep 2023 10:11:10 +0000 (UTC)
References: <20230918092219.24151-1-andrea.cervesato@suse.de>
 <20230918092219.24151-2-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 18 Sep 2023 11:09:47 +0100
Organization: Linux Private Site
In-reply-to: <20230918092219.24151-2-andrea.cervesato@suse.de>
Message-ID: <875y47hjus.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] Replace runltp-ng with kirk framework
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

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Kirk application is the runltp-ng successor and it aims to merge
> multiple Linux testing frameworks in one tool, providing support
> for remote testing via Qemu, SSH, LTX, parallel execution and much
> more.
>
> This patch deprecates runltp-ng, which is not replaced by kirk. All
> runltp-ng features are present in kirk and even more.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .gitmodules     | 6 +++---
>  tools/kirk      | 1 +
>  tools/runltp-ng | 1 -
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  create mode 160000 tools/kirk
>  delete mode 160000 tools/runltp-ng
>
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
> index 000000000..666a2bd8d
> --- /dev/null
> +++ b/tools/kirk
> @@ -0,0 +1 @@
> +Subproject commit 666a2bd8dbf583732ed415abf1bae39bd8791061
> diff --git a/tools/runltp-ng b/tools/runltp-ng
> deleted file mode 160000
> index e842511ed..000000000
> --- a/tools/runltp-ng
> +++ /dev/null
> @@ -1 +0,0 @@
> -Subproject commit e842511ed2c680e3b2ea6dec790913a41d5ed937
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
