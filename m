Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA474C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 13:08:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01EAF3CA692
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 15:08:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 271193C54E8
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 15:08:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBC7E1400550
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 15:08:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E6C821118;
 Tue, 19 Apr 2022 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650373692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3xECIFYq3cxizdOTpazimKySTHktfGnADvorm1lNNM8=;
 b=AphPipIhp5EMfSymhnAM+8LZJWW0jCahzXa1/Hvfyc/fY5Q/bsz9Ytm28OR8+zlqAEZ0Hy
 h+6vEjfegZ7TpKt9rrXu3CqLhYJ7BPjxFCGxN2pdlJQDdZxNhDcZtA3HUv+JvPcYXX5mRC
 ztSuHcYQfp0oBIllTu6CgStmWvuE8h4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650373692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3xECIFYq3cxizdOTpazimKySTHktfGnADvorm1lNNM8=;
 b=saGSJtQxP9/zuczxsE3eaisrzsEMgg45l2aEJ+I9DkSMyVUn85BGinvtkKXhA23qDWhO6w
 vZPT1ALUWPTUNQDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2D15139BE;
 Tue, 19 Apr 2022 13:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hAILNju0XmI9fgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 19 Apr 2022 13:08:11 +0000
Date: Tue, 19 Apr 2022 15:10:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yl60xJbQJnO1Gndl@yuki>
References: <20220419064744.11487-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220419064744.11487-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] confstr01: Update to X/Open 7 (POSIX 2008)
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
>  static struct test_case_t {
>  	int value;
>  	char *name;
> @@ -30,55 +27,27 @@ static struct test_case_t {
>  	{ _CS_PATH, "PATH" },
>  	{ _CS_GNU_LIBC_VERSION, "GNU_LIBC_VERSION" },
>  	{ _CS_GNU_LIBPTHREAD_VERSION, "GNU_LIBPTHREAD_VERSION" },
> -
> -/* checking for obsolete configurations */
> -#ifdef _CS_XBS5_ILP32_OFF32_CFLAGS
> -	{ _CS_XBS5_ILP32_OFF32_CFLAGS, "XBS5_ILP32_OFF32_CFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_ILP32_OFF32_LDFLAGS
> -	{ _CS_XBS5_ILP32_OFF32_LDFLAGS, "XBS5_ILP32_OFF32_LDFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_ILP32_OFF32_LIBS
> -	{ _CS_XBS5_ILP32_OFF32_LIBS, "XBS5_ILP32_OFF32_LIBS" },
> -#endif
> -#ifdef _CS_XBS5_ILP32_OFF32_LINTFLAGS
> -	{ _CS_XBS5_ILP32_OFF32_LINTFLAGS, "XBS5_ILP32_OFF32_LINTFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_ILP32_OFFBIG_CFLAGS
> -	{ _CS_XBS5_ILP32_OFFBIG_CFLAGS, "XBS5_ILP32_OFFBIG_CFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_ILP32_OFFBIG_LDFLAGS
> -	{ _CS_XBS5_ILP32_OFFBIG_LDFLAGS, "XBS5_ILP32_OFFBIG_LDFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_ILP32_OFFBIG_LIBS
> -	{ _CS_XBS5_ILP32_OFFBIG_LIBS, "XBS5_ILP32_OFFBIG_LIBS" },
> -#endif
> -#ifdef _CS_XBS5_ILP32_OFFBIG_LINTFLAGS
> -	{ _CS_XBS5_ILP32_OFFBIG_LINTFLAGS, "XBS5_ILP32_OFFBIG_LINTFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_LP64_OFF64_CFLAGS
> -	{ _CS_XBS5_LP64_OFF64_CFLAGS, "XBS5_LP64_OFF64_CFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_LP64_OFF64_LDFLAGS
> -	{ _CS_XBS5_LP64_OFF64_LDFLAGS, "XBS5_LP64_OFF64_LDFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_LP64_OFF64_LIBS
> -	{ _CS_XBS5_LP64_OFF64_LIBS, "XBS5_LP64_OFF64_LIBS" },
> -#endif
> -#ifdef _CS_XBS5_LP64_OFF64_LINTFLAGS
> -	{ _CS_XBS5_LP64_OFF64_LINTFLAGS, "XBS5_LP64_OFF64_LINTFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_LPBIG_OFFBIG_CFLAGS
> -	{ _CS_XBS5_LPBIG_OFFBIG_CFLAGS, "XBS5_LPBIG_OFFBIG_CFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_LPBIG_OFFBIG_LDFLAGS
> -	{ _CS_XBS5_LPBIG_OFFBIG_LDFLAGS, "XBS5_LPBIG_OFFBIG_LDFLAGS" },
> -#endif
> -#ifdef _CS_XBS5_LPBIG_OFFBIG_LIBS
> -	{ _CS_XBS5_LPBIG_OFFBIG_LIBS, "XBS5_LPBIG_OFFBIG_LIBS" },
> -#endif
> -#ifdef _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS
> -	{ _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS, "XBS5_LPBIG_OFFBIG_LINTFLAGS" },
> +	{ _CS_POSIX_V7_ILP32_OFF32_CFLAGS, "POSIX_V7_ILP32_OFF32_CFLAGS" },
> +	{ _CS_POSIX_V7_ILP32_OFF32_LDFLAGS, "POSIX_V7_ILP32_OFF32_LDFLAGS" },
> +	{ _CS_POSIX_V7_ILP32_OFF32_LIBS, "POSIX_V7_ILP32_OFF32_LIBS" },
> +	{ _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS, "POSIX_V7_ILP32_OFFBIG_CFLAGS" },
> +	{ _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS, "POSIX_V7_ILP32_OFFBIG_LDFLAGS" },
> +	{ _CS_POSIX_V7_ILP32_OFFBIG_LIBS, "POSIX_V7_ILP32_OFFBIG_LIBS" },
> +	{ _CS_POSIX_V7_LP64_OFF64_CFLAGS, "POSIX_V7_LP64_OFF64_CFLAGS" },
> +	{ _CS_POSIX_V7_LP64_OFF64_LDFLAGS, "POSIX_V7_LP64_OFF64_LDFLAGS" },
> +	{ _CS_POSIX_V7_LP64_OFF64_LIBS, "POSIX_V7_LP64_OFF64_LIBS" },
> +	{ _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS, "POSIX_V7_LPBIG_OFFBIG_CFLAGS" },
> +	{ _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS, "POSIX_V7_LPBIG_OFFBIG_LDFLAGS" },
> +	{ _CS_POSIX_V7_LPBIG_OFFBIG_LIBS, "POSIX_V7_LPBIG_OFFBIG_LIBS" },
> +#ifdef _CS_POSIX_V7_THREADS_CFLAGS
> +	{ _CS_POSIX_V7_THREADS_CFLAGS, "POSIX_V7_THREADS_CFLAGS" },
> +#endif
> +#ifdef _CS_POSIX_V7_THREADS_LDFLAGS
> +	{ _CS_POSIX_V7_THREADS_LDFLAGS, "POSIX_V7_THREADS_LDFLAGS" },
> +#endif
> +	{ _CS_POSIX_V7_WIDTH_RESTRICTED_ENVS, "POSIX_V7_WIDTH_RESTRICTED_ENVS" },
> +#ifdef _CS_V7_ENV
> +	{ _CS_V7_ENV, "V7_ENV" },
>  #endif

This looks fine and as long as it compiles on supported distros and
compilers:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Btw, we can simplify the code a bit with macro like:

#define PAIR(name) {_CS_ ## name, #name}

>  };
>  
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
