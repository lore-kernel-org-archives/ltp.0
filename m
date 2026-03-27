Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AE810ED658
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774607721; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=AGaUSBpuPUkfPJRh6VWd28avYq40bP9D4duxKquNk6Y=;
 b=jcdpOgUx7E8Qw0A/U7O6Loz21qoMUHDR82qDVVejI0VBxtyROxz7LvyEWa9c7Pu5CregG
 xq0zqXwi8r1+DoRqSEdh5GKI3kVVLhCEKZloJPDy4zcw0DMjwoKLZvGVLznAWNxpK+FChQ9
 ar/5MGkoXXiRvenwiRrpaLCCeptWzy8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13E5B3CF83F
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 11:35:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A4993C8411
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 11:34:56 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E382210007C6
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 11:34:55 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486fe2024a9so14785075e9.0
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774607695; x=1775212495; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yTJ1iOTtxuzrxBpLfpybutATIJUmwppMzDtYxG0o+Fs=;
 b=Rc3bcTRg1CXQ1ACBNwhivew3APbqJu689EStgPOxYNVjvuFGuYaa6QGuHnGalmRj0o
 i0w1cKtCtQbAQ7RilJWMTVBSd2SdNDwf07jL2NaSVRh8Ce+NKIBDpvE+BYxDiJBS+MJc
 xWuQ2VTAzjMzce01WSvnJ8q5Rb4Dk2sMccgRCkkaxsiF6WRPEe1qEih1kswJcTvEai7D
 +3PycSm7I2DGPV+T3GCRdXn3FT170kHP27XUR8leuIzNZ7XFSErZ5fr1A2BeW2aaU+qX
 IjLrZt9D3jplw5nT5LvREd9M/mqWzqNg40fZd+HxPYrhxzyZabvRm1fUZBEql0XRsqKC
 qFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774607695; x=1775212495;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTJ1iOTtxuzrxBpLfpybutATIJUmwppMzDtYxG0o+Fs=;
 b=P2iXvusFxWaZ3i97nAoEc1pU6VaMXcvz0HkNQKMdLKan2BeWhZ0M7Jy1MZ8L9im1j+
 350//0ScTIa/MVcUwFK1CrJ3VeCShmLOYF3uNmLSGhMr+OYePUWQnJXfyzXZSSZOPEfp
 jkYnEylnvEYF23BTcha7sHeiYdobdm1/RffE2Wn/iCU2d20S5ABajPi+cXf7nM/t6m7V
 DmuSEoz7FH2sLcmjOspdHR4V8gMjipwiSh5eMXhJJ4c9jQdnWa08RLV1SmSDgPEjD1Qm
 HnTifftcKsZlBN+Oq1aCpAZUUfg2ysn17W+zKwa0+9VT0RqhuNUmiyE6yVqDw4PCp0BS
 yNuA==
X-Gm-Message-State: AOJu0YwW81CFiWhjk3D7mZ8nNEH+7jichvG0GKrNJo9PhEaVcxMO6bJv
 hstXfA1g7rS7u7unqi5ui0GkuxywfaO1WOCgygFk/xkewKFc01RFMHgruH0k241tvA9wriomeWI
 Uv6nBxPOUVg==
X-Gm-Gg: ATEYQzwrEyT3qlVzw7YwCBUM3OxSYJgidpJP8Ds35x23S/K+b/XX1rMdSd2UimrMT3j
 l02WENIUaweN60iks45mOH3pMnahM+mIE7PPvlbBje9b3MfM0WRJOwlz7A2CsteMkBWCk5fBfhF
 MVvTmlEvfsfp6CccMfROOwS7UPjnS3zzWQzp3SP6Y2rtQaG3D1xfafBsNEqxzD716eJwE3hXVj3
 5ycD0lm4KXtBs/k+HwZyLv8oBq1AzqhBQWQ/bxT856mn27h7dBFREOWzbZMM4FAWr8njLzUjygK
 mb69BOlaDkJHvuQ5/tifuWW2U5/WFMfU6JkaqF4w8I8lBFhz6XZZ+FDWRXWZmjOPlYwAz27YqVS
 CA8smbWyGOD4JUtTrogbDqN+IRY2RGcW2qIfFaKjAZ2FxYFPI0T+MeqAFhC2AI/OHKeXdT9Rjf8
 vczq5Ykb8GkwqN94PhUfZ42eeHabvK5JlO1Q7FZvEBgHeoA8Jag5bIeZRCH9bPYFhRolBUHR5D1
 BzgbmDW3qkJ7jiYqHZ3ng/X8yJUKun+s50mFdCqxSUOFe01bgw5kAKnNL6y1PEXz3aURLQk+Hr8
 tXKjlJFiPza0
X-Received: by 2002:a05:600c:4e15:b0:485:35ee:f836 with SMTP id
 5b1f17b1804b1-48727d5a191mr31216165e9.2.1774607695259; 
 Fri, 27 Mar 2026 03:34:55 -0700 (PDT)
Received: from p200300ef2f4fc90094f4c5ce75c4603f.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48727c0cdf6sm34417045e9.2.2026.03.27.03.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 03:34:54 -0700 (PDT)
Message-ID: <69c65d4e.050a0220.3d4e82.a39c@mx.google.com>
To: lufei <lufei@uniontech.com>
In-Reply-To: <20260304080538.1793-1-lufei@uniontech.com>
Date: Fri, 27 Mar 2026 10:34:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Rewrite ftrace_regression01.sh with new C API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: lufei <lufei@uniontech.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi lufei,

A few issues need fixing before this can be merged.

[PATCH 1/2]

> +/*\
> + * [Description]
> + *
> + * Regression test for panic while using userstacktrace.

Drop the [Description] tag, it's deprecated.

> +#define FTRACE_FILE_CONTAINS_BUF_SIZE (1024 * 1024)
[...]
> +static inline int file_contains(const char *path, const char *str)
> +{
> +	char buf[FTRACE_FILE_CONTAINS_BUF_SIZE];

This puts 1 MiB on the stack. Use SAFE_MALLOC/free or a static buffer
instead.

> +		if (!file_contains(TRACE_OPTIONS, "userstacktrace"))
> +			tst_brk(TBROK, "Failed to set userstacktrace");

strstr("nouserstacktrace", "userstacktrace") is true, so this check
always passes even when the option is disabled. The original shell
version used grep -q "^userstacktrace" which anchored to line start.

[PATCH 2/2]

> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c

The old ftrace_regression02.sh is not deleted by this patch. You need
to remove it, same as you did for ftrace_regression01.sh in patch 1/2.

> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/kernel/stack_tracer_enabled", NULL, TST_SR_TCONF},
> +		{}
> +	},

This test doesn't use stack_tracer_enabled. Looks like copy-paste from
ftrace_regression01. Remove it.

The original shell test gated on kernel >= 3.2. Add .min_kver = "3.2"
to preserve that check.

[Both patches]

The runtest/tracing entries still reference the .sh files:

  ftrace_regression01	ftrace_regression01.sh
  ftrace_regression02	ftrace_regression02.sh

Update them to point to the C binaries.

The Makefile has INSTALL_TARGETS := *.sh ftrace_stress/* which won't
install the new C binaries. It needs updating as well.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
