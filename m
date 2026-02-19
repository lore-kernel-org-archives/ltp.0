Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B71E9A03B
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 12:32:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2AE83D0732
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 13:32:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CB9C3D06DB
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 13:31:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B51FE60087D
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 13:31:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2B365BCC7;
 Thu, 19 Feb 2026 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771504301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/pEx+YroEiQz5mIpwp6oGBb16a01i/pmAKUCYMYH4JQ=;
 b=Gr1R/b05buOhkVfRrCQVDedZeQOpiF+S0X6o7qMFsk4U1Zmt0x1ql0nM0qY1suuXpC3jrb
 T8ADQ81kh91JHvioc2Vb5LHlVXni2VgvlLVESmdaQ7FSOka5NJPb3CUN6CENbqktGZwCRU
 QikrzJNJZGY/tOJGEMuxOJTC7D9ktGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771504301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/pEx+YroEiQz5mIpwp6oGBb16a01i/pmAKUCYMYH4JQ=;
 b=mWAg0QSM99ECZu08bfuV+1zfXnuK5mCqyQdhhGgE1wpUoHAlF44gSJi8tGlJr37NIh7yZV
 /httg2K+cH01ooDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771504299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/pEx+YroEiQz5mIpwp6oGBb16a01i/pmAKUCYMYH4JQ=;
 b=n1/STZxpGE+X2OKkrFxcMdRBjwoZFuKgeWDwYBlZPR9VSSw4sGmu0BJAsAHwd8NcqWygUj
 AvYojFkyqqFGQShSdeNy5PMUyA8e4TXP8vCQKGFZ9pcUVY0cxcVCcYCSABHQTbgE7xuslT
 tqpGEHkmmj+IvP85qYFspXdHY0Sv1co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771504299;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/pEx+YroEiQz5mIpwp6oGBb16a01i/pmAKUCYMYH4JQ=;
 b=TGUOs2pZ79i+HifeYOXL6B21Fms35E3dplbVFai5oclWF8AFIdxOGg3d6+K32RLPQKknAT
 sGW9V1AAspHof6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A64DF3EA65;
 Thu, 19 Feb 2026 12:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IlnNJ6sCl2kzcgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Feb 2026 12:31:39 +0000
Date: Thu, 19 Feb 2026 13:31:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aZcCrH2i_KFhonAG@yuki.lan>
References: <20260123-stream_refactoring-v1-0-281b85f6ab02@suse.com>
 <20260123-stream_refactoring-v1-1-281b85f6ab02@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123-stream_refactoring-v1-1-281b85f6ab02@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] Add safe macros for stream testing suite
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Introduce the following SAFE_* macros for stream file testing:
> 
> - SAFE_FREAD
> - SAFE_FWRITE
> - SAFE_FREOPEN
> - SAFE_FSEEK
> - SAFE_FTELL
> - SAFE_FILENO
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/safe_stdio_fn.h  | 18 ++++++++++
>  include/tst_safe_stdio.h | 18 ++++++++++
>  lib/safe_stdio.c         | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 123 insertions(+)
> 
> diff --git a/include/safe_stdio_fn.h b/include/safe_stdio_fn.h
> index 3818a86571a6d9bc63fcf432c93683bb3298e5b2..79c08080fd16489ea5bd1606083ae900ba3b294f 100644
> --- a/include/safe_stdio_fn.h
> +++ b/include/safe_stdio_fn.h
> @@ -32,4 +32,22 @@ int safe_asprintf(const char *file, const int lineno, void (cleanup_fn)(void),
>  FILE *safe_popen(const char *file, const int lineno, void (cleanup_fn)(void),
>  		 const char *command, const char *type);
>  
> +size_t safe_fread(const char *file, const int lineno, void (cleanup_fn)(void),
> +		  void *ptr, size_t size, size_t n, FILE *stream);
> +
> +size_t safe_fwrite(const char *file, const int lineno, void (cleanup_fn)(void),
> +		   const void *ptr, size_t size, size_t n, FILE *stream);
> +
> +FILE *safe_freopen(const char *file, const int lineno, void (cleanup_fn)(void),
> +		   const char *path, const char *mode, FILE *stream);
> +
> +int safe_fseek(const char *file, const int lineno, void (cleanup_fn)(void),
> +	       FILE *f, long offset, int whence);
> +
> +long safe_ftell(const char *file, const int lineno, void (cleanup_fn)(void),
> +		FILE *f);
> +
> +int safe_fileno(const char *file, const int lineno, void (cleanup_fn)(void),
> +		FILE *stream);

Newly added safe macros shouldn't add the cleanup_fn parameter, that is
kept only in the legacy macros that are stil used in the old library
tests.

Otherwise: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
