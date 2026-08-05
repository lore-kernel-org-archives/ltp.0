Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5FFC55822
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 06:53:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A88233E2CD4
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 08:53:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A7323E24A4
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 08:53:21 +0200 (CEST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E04660077A
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 08:53:20 +0200 (CEST)
Date: Wed, 5 Aug 2026 14:53:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785912799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G04cxOPUDNOsCDDmnT2mu3Ts1FinW/Og9I+xMUTjwsQ=;
 b=Z0ZORJOGtOxMXUSGHhLMv+HE/uYRZ6mW6SrlXWkK5qSNVEoqLvmkIZaYaLNBzXMMYUYKDm
 Zi7j9KA/Zie+Ic2o5UqqOfrZik50ndGOSGVQg+WNIy0fktmRlapdQ1WG2UtbzjAWXISHKA
 shLR0OeOOLyNoJZ7n8ZbJOYmf8USMGI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: linuxtestproject.agent@gmail.com
Message-ID: <anLdzKj7Z4HYhb7T@linux.dev>
Mail-Followup-To: linuxtestproject.agent@gmail.com,
 Wake Liu <wakel@google.com>, ltp@lists.linux.it
References: <20260805025418.1249003-1-wakel@google.com>
 <20260805040954.7675-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260805040954.7675-1-linuxtestproject.agent@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Use backoff polling to wait for loop device nodes
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

The AI comments make sense, I overlooked them before ack your patch.

TST_RETRY_FN_EXP_BACKOFF() is not a drop-in replacement here: it
depends on tst_multiply_timeout(), which is not declared by test.h
for legacy-API users, and its timing semantics do not match the
commit message. In particular, the argument 1 is 1us, not 1ms,
and the cap is the macro's own timeout-adjusted threshold rather
than 100ms.

On Wed, Aug 05, 2026 at 04:09:54AM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wake,
> 
> On Aug 5, 2026, Wake Liu wrote:
> > lib: Use backoff polling to wait for loop device nodes
> 
> > +				path_set = TST_RETRY_FN_EXP_BACKOFF(
> > +					set_dev_loop_path(rc, path, path_len),
> > +					TST_RETVAL_EQ0, 1);
> 
> Could the declaration of tst_multiply_timeout() be made available to this
> legacy-API library, or could polling avoid this macro? The macro expands to a
> call to tst_multiply_timeout(), but test.h does not declare it. GCC reports an
> implicit declaration and Clang rejects both new call sites under C99:
> 
> > error: call to undeclared function 'tst_multiply_timeout'; ISO C99 and later do not support implicit function declarations
> 
> > tst_find_free_loopdev() and tst_attach_device() (starting at 1ms delay,
> > doubling each try, capped at 100ms) to wait for the device node to be
> > successfully populated.
> 
> Could this timing description be corrected or the requested timing be
> implemented? TST_RETRY_FN_EXP_BACKOFF(..., 1) starts at one microsecond and
> uses one second as its maximum-delay threshold, subject to
> tst_multiply_timeout().
> 
> Verdict - Needs revision
> 
> ---
> Note:
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
