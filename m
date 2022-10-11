Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2D9C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 14:47:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74EEC3CA821
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 16:47:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 217103C07B4
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 16:47:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 332C1100061F
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 16:47:41 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7FA8533DB7;
 Tue, 11 Oct 2022 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665499661;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7/8QU7dwxvwQD1UAbqaFdWR4zxgS4WSsPeCRNrweG0=;
 b=0/pBIg0MsglJdTP44KSNiYBJQk0L0tesOqQQ5JOu9T0Q6ZUmlM9CDG9GHDxctEodGO2Bjd
 GuxuNosV1C0O6QgjlVdicjxEL+UMeUA+uzYsRiZjg62qwudT+3v6EqOG4oEZnyE2LiY4gL
 ichNEu3Ym8CUSGn339UBuQGkOrXhMfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665499661;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7/8QU7dwxvwQD1UAbqaFdWR4zxgS4WSsPeCRNrweG0=;
 b=LOCeODjusL/jUaZBJnyGTnoZRVcaoaGFDrs2HYZaHum14rIntPQ20WhuO3KJUzRIKcVX5s
 odKe0SR3ikAKHECA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BD5AD2C141;
 Tue, 11 Oct 2022 14:47:40 +0000 (UTC)
References: <20220817133929.234873-1-tudor.cretu@arm.com>
 <20220817133929.234873-3-tudor.cretu@arm.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tudor Cretu <tudor.cretu@arm.com>
Date: Tue, 11 Oct 2022 15:43:16 +0100
In-reply-to: <20220817133929.234873-3-tudor.cretu@arm.com>
Message-ID: <87o7ui5se0.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] build.sh: Allow specifying additional make
 options
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

Tudor Cretu <tudor.cretu@arm.com> writes:

> This enables build.sh to use make options such as TST_NEWER_64_SYSCALL or
> TST_COMPAT_16_SYSCALL, e.g.:
>
> MAKE_OPTS="TST_NEWER_64_SYSCALL=no TST_COMPAT_16_SYSCALL=no"
> ./build.sh ...

I'm not sure if you still want this one or not after the other patch was
dropped. In any case Petr seems to favor command line args (with docs)
over env variables. So it would be best to stick to the existing style
of this script.

>
> Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
> ---
>  build.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/build.sh b/build.sh
> index 1767cc21b..42c89ad97 100755
> --- a/build.sh
> +++ b/build.sh
> @@ -18,7 +18,7 @@ CONFIGURE_OPTS_OUT_TREE="--with-realtime-testsuite $CONFIGURE_OPT_EXTRA"
>  SRC_DIR="$(cd $(dirname $0); pwd)"
>  BUILD_DIR="$SRC_DIR/../ltp-build"
>  
> -MAKE_OPTS="-j$(getconf _NPROCESSORS_ONLN)"
> +MAKE_OPTS="-j$(getconf _NPROCESSORS_ONLN) $MAKE_OPTS"
>  MAKE_OPTS_OUT_TREE="$MAKE_OPTS -C $BUILD_DIR -f $SRC_DIR/Makefile top_srcdir=$SRC_DIR top_builddir=$BUILD_DIR"
>  
>  run_configure()
> -- 
> 2.25.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
