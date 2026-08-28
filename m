Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162C0C61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:26:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E2D53E2FD2
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:26:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 722363D8567
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:26:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD2EE60011C
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:26:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0427F21A1D;
 Fri, 28 Aug 2026 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787909173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QyqxuR+E/kdO/RvLbno8YnIjspwnTNd5HIN2SKk98u4=;
 b=p4hZl4lMxLHFSKMmavpEBEJ9BcFlztW9WMr0WGu+YPcmtnv1QPCso8zM0R5ni9j+iExKBf
 os5hFD506KFzfrEL6pyoOcbkE9CxQyaSren6rFVZEYvnMlknNlHKH1G0Sw3iPYUxH1YSE3
 0yf5vAsK3SCnbW2qn111Tja/J8E3kr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787909173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QyqxuR+E/kdO/RvLbno8YnIjspwnTNd5HIN2SKk98u4=;
 b=w9klhFOp4GEOlBjrrKjFJ+JsZU1O9aTNd+5kpWdtEThx2z9svKdofMPUt3939ZxgPhYNv9
 oLx0khK5ePII2YAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787909169;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QyqxuR+E/kdO/RvLbno8YnIjspwnTNd5HIN2SKk98u4=;
 b=rpgRIwJ1p+SJ6I2flVvEFIb7avi9Etz8SbRujWBLMj/Lu9NPBrhZ2AfmGbqh9NflmfTpEg
 ZYU8D47szKhILgMNMxIAM7sbEAYob5atwUcgiS6bxLnpXBzAdsbJ+tHy5OCimupNfjEfEw
 tth+WO/YZc7oL6kEyXG9xbNMSriUCtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787909169;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QyqxuR+E/kdO/RvLbno8YnIjspwnTNd5HIN2SKk98u4=;
 b=jGOwRHOTfpOGj6KwSdNf7SWFwHZIKNy9bG3SinR3g0P9wmgTEVx1oHvYJCWFhmR+nMsjs9
 Qc9e+bjp/u3k1zCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FFD613674;
 Fri, 28 Aug 2026 09:26:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IN7NCjBUkWr7dQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Aug 2026 09:26:08 +0000
Date: Fri, 28 Aug 2026 11:26:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260828092602.GA715959@pevik>
References: <20260821013917.28499-1-wegao@suse.com>
 <20260826075301.10826-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260826075301.10826-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] shmctl03: Fix 32-bit compat mode failure
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> On 64-bit kernels, the default shmmax and shmall values often
> exceed the range of a 32-bit unsigned long or are clipped
> differently by the kernel's compat syscall layer than they
> appear in /proc.

FYI an old comment from Arnd Bergmann [1]

[1] https://lore.kernel.org/ltp/c9ba86f6-dea8-47bd-88e1-edf49e4bf9fd@app.fastmail.com/

> Link: https://lore.kernel.org/ltp/aJm5SBOaRoe1e0PB@yuki.lan/
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
> v7->v8:
> - Improving and Shortening the Commit Message.
> - Renaming the Assert Flag: Renamed TST_ASSERT_BITWISE to TST_ASSERT_TRUNC_32BIT.

>  include/tst_assert.h                        | 42 ++++++++++++++++++---
>  lib/tst_assert.c                            | 27 ++++++++++---

Wouldn't it make sense to split library part into separate commit?

>  testcases/kernel/syscalls/shmctl/shmctl03.c | 17 +++++++--
>  3 files changed, 72 insertions(+), 14 deletions(-)

> diff --git a/include/tst_assert.h b/include/tst_assert.h
> index dcb62dfea..045942b1b 100644
> --- a/include/tst_assert.h
> +++ b/include/tst_assert.h
> @@ -21,14 +21,46 @@ void tst_assert_int(const char *file, const int lineno,
>  #define TST_ASSERT_FILE_INT(path, prefix, val) \
>  	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)

> -/*
> - * Same as tst_assert_int() but for unsigned long.
> +/**
> + * TST_ASSERT_SATURATED_INT - Clamp the sysfs/procfs value to INT_MAX.
> + *
> + * If this flag is set and the value read from the sysfs/procfs file exceeds
> + * INT_MAX, the compared value is clamped (saturated) to INT_MAX.
> + */
> +#define TST_ASSERT_SATURATED_INT   0x01

IMHO enum (instead of plain definitions) would be more suitable for this
(see tst_cmd.h). First good benefit is that will do the check for correct
values for free.

> +
> +/**
> + * TST_ASSERT_TRUNC_32BIT - Keep only the lower 32 bits of the read value.
> + *
> + * If this flag is set, only the low 32 bits of the value read from the
> + * sysfs/procfs file are compared.
> + */
> +#define TST_ASSERT_TRUNC_32BIT     0x02
> +
> +/**
> + * tst_assert_ulong() - Assert that an unsigned long value in a file matches.
> + * @file: The source file of the assertion (usually __FILE__).
> + * @lineno: The source line number of the assertion (usually __LINE__).
> + * @path: Path to the sysfs or procfs file to read from.
> + * @val: The expected unsigned long value to compare against.
> + * @flags: Bitwise flags controlling how the read value is processed.
> + *         Supported flags:
> + *         - %TST_ASSERT_SATURATED_INT: Clamps the value at %INT_MAX if it
Unfortunately lists aren't supported in kerneldoc parameters.  Therefore this
will not work, it will be rendered as inline:

Supported flags: - TST_ASSERT_SATURATED_INT: Clamps the value at INT_MAX if it exceeds it. - TST_ASSERT_TRUNC_32BIT: Keeps only the low 32 bits of the read value, truncating any higher bits. - 0: Direct comparison without any adjustment.

You will see it if you rebase the current master (I added tst_assert.h to the
docs), it'd be great to double check how the docs actually look like.

Therefore using enum will solve it because we don't need to list supported flags
(there will be link to the enum itself) - second benefit for enum.

> + *           exceeds it.
> + *         - %TST_ASSERT_TRUNC_32BIT: Keeps only the low 32 bits of the
> + *           read value, truncating any higher bits.
> + *         - %0: Direct comparison without any adjustment.
> + *
> + * This function reads an integer value from the file specified by @path
> + * and compares it with @val. It allows handling of 32-bit compat mode
> + * truncation/clamping on 64-bit systems via @flags.
>   */
>  void tst_assert_ulong(const char *file, const int lineno,
> -                      const char *path, unsigned long val);
> +                      const char *path, unsigned long val, int flags);

> -#define TST_ASSERT_ULONG(path, val) \
> -	tst_assert_ulong(__FILE__, __LINE__, path, val)
> +#define TST_ASSERT_ULONG(path, val, ...) \
> +	tst_assert_ulong(__FILE__, __LINE__, path, val, \
> +		TST_2_(dummy, ##__VA_ARGS__, 0))
I've never noticed TST_2_(), nice way to avoid passing 0 as flag.

>  /*
>   * Asserts that integer value stored in the prefix field of file pointed by path
> diff --git a/lib/tst_assert.c b/lib/tst_assert.c
> index b68bd5d39..9a606d863 100644
> --- a/lib/tst_assert.c
> +++ b/lib/tst_assert.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
>   */
>  #include <stdio.h>
> +#include <limits.h>
Why is this added?

>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_assert.h"
>  #include "tst_test.h"
> @@ -23,18 +24,32 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
>  	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
>  }

> -void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
> +void tst_assert_ulong(const char *file, const int lineno, const char *path,
> +		      unsigned long val, int flags)
>  {
> -	unsigned long sys_val;
> -
> -	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
> +	unsigned long long sys_val_64;
> +	unsigned long expected_val;
> +
> +	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val_64);
> +
> +	if (flags & TST_ASSERT_SATURATED_INT) {
> +		if (sys_val_64 > (unsigned long long)INT_MAX)
> +			expected_val = (unsigned long)INT_MAX;
> +		else
> +			expected_val = (unsigned long)sys_val_64;
> +	} else if (flags & TST_ASSERT_TRUNC_32BIT) {
> +		expected_val = (unsigned long)(sys_val_64 & 0xFFFFFFFFULL);
> +	} else {
> +		expected_val = (unsigned long)sys_val_64;
> +	}

> -	if (val == sys_val) {
> +	if (val == expected_val) {
>  		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
>  		return;
>  	}

> -	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
> +	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu (raw: %llu)",
> +		path, val, expected_val, sys_val_64);
>  }

>  void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *prefix, int val)
> diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
> index 9e1c2f099..0ac3f45c5 100644
> --- a/testcases/kernel/syscalls/shmctl/shmctl03.c
> +++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
> @@ -30,9 +30,20 @@ static void verify_ipcinfo(void)
>  	else
>  		tst_res(TPASS, "shmmin = 1");

> -	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> -	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
> -	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
> +	if (tst_is_compat_mode()) {
> +		/*
> +		 * On 64-bit kernel, shmmax is clamped to INT_MAX for 32-bit
> +		 * compat syscall, while shmmni and shmall are truncated
> +		 * to 32-bit.
> +		 */
> +		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax, TST_ASSERT_SATURATED_INT);
> +		TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, TST_ASSERT_TRUNC_32BIT);
> +		TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall, TST_ASSERT_TRUNC_32BIT);

> +	} else {
> +		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> +		TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
> +		TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
> +	}

nit: I'd personally code it with ternary operator, but whatever you prefer.

bool c = tst_is_compat_mode());
/*
 * On 64-bit kernel, shmmax is clamped to INT_MAX for 32-bit
 * compat syscall, while shmmni and shmall are truncated
 * to 32-bit.
 */
TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax, c ? TST_ASSERT_SATURATED_INT : 0);
TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, c ? TST_ASSERT_TRUNC_32BIT : 0);
TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall, c ? TST_ASSERT_TRUNC_32BIT: 0);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
