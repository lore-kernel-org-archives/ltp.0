Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1653C5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 10:03:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6D503CEF38
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 12:03:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E92A3C56E2
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 12:03:01 +0200 (CEST)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C2672600749
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 12:03:00 +0200 (CEST)
Date: Mon, 10 Aug 2026 18:02:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786356179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tlepu1RXToc3pG/zxXfCUi5sCBpZcGbMr+L4J0YSFgM=;
 b=ERnUlfWD0NmTnWvB48pnDxM/Y5kRGsxAjEMA+enNeS4ps64ImIr3JF4uF/EJqPTs7LN5EH
 S2N/8bBqWEub8YWQw2eD2ljuK00lfuaYJbf3RZtKbO3gon8vlNe2tNOoRYUhhoB5K3bW/b
 6HBtlZ2FeL8KuYi6gZiqx0zIBsDV/+c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Wake Liu <wakel@google.com>
Message-ID: <anmhyfuUdUrzQuWY@linux.dev>
Mail-Followup-To: Wake Liu <wakel@google.com>, ltp@lists.linux.it
References: <20260807234935.3248935-1-wakel@google.com>
 <20260810025817.1665141-1-wakel@google.com>
 <20260810025817.1665141-2-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810025817.1665141-2-wakel@google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/2] lib: Fix overflow in backoff polling and
 timeout multiplication
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

Hi Wake,

This patch is not necessary, the overflow is not reachable in practice.

MAX_DELAY is a compile-time constant <= 30 at all call sites, so
'MAX_DELAY * 1000000' never overflows int. And the backoff would
need tst_delay_ to reach 2^31 (a single ~35 min usleep) to wrap,
which the loop-device probing never approaches regardless of
LTP_TIMEOUT_MUL.

So, I'd prefer to keep the change minimal and apply only v6.


On Mon, Aug 10, 2026 at 02:58:16AM +0000, Wake Liu via ltp wrote:
> Prevent integer overflow in TST_RETRY_FN_EXP_BACKOFF() when the delay
> doubles. By using 'unsigned long long' for delay variables, we ensure
> the doubled delay is safely represented without wrapping to 0 (which
> causes an infinite loop). The loop will naturally terminate when the
> 64-bit delay exceeds 'tst_max_delay_' (capped at UINT_MAX).
> 
> Also fix potential overflow in tst_multiply_timeout() when the
> multiplied timeout exceeds UINT_MAX. Perform the calculation in double
> precision and cap the result at UINT_MAX.
> 
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  include/tst_common.h |  4 +++-
>  lib/tst_test.c       | 11 +++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/tst_common.h b/include/tst_common.h
> index e1f7c7907..058060fa4 100644
> --- a/include/tst_common.h
> +++ b/include/tst_common.h
> @@ -26,6 +26,8 @@
>  #define LTP_ALIGN(x, a)    __LTP_ALIGN_MASK(x, (typeof(x))(a) - 1)
>  #define __LTP_ALIGN_MASK(x, mask)  (((x) + (mask)) & ~(mask))
>  
> +unsigned int tst_multiply_timeout(unsigned int timeout);
> +
>  /**
>   * TST_RETRY_FUNC() - Repeatedly retry a function with an increasing delay.
>   * @FUNC - The function which will be retried
> @@ -42,7 +44,7 @@
>  	TST_RETRY_FN_EXP_BACKOFF(FUNC, ECHCK, 1)
>  
>  #define TST_RETRY_FN_EXP_BACKOFF(FUNC, ECHCK, MAX_DELAY)	\
> -({	unsigned int tst_delay_, tst_max_delay_;			\
> +({	unsigned long long tst_delay_, tst_max_delay_;			\
>  	typeof(FUNC) tst_ret_;						\
>  	tst_delay_ = 1;							\
>  	tst_max_delay_ = tst_multiply_timeout(MAX_DELAY * 1000000);	\
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 5c3607016..80463e7c6 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1855,10 +1855,17 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
>  	if (timeout < 1)
>  		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
>  
> +	double t = timeout;
> +
>  	if (tst_has_slow_kconfig())
> -		timeout *= 4;
> +		t *= 4;
> +
> +	t *= timeout_mul;
> +
> +	if (t > (double)UINT_MAX)
> +		return UINT_MAX;
>  
> -	return timeout * timeout_mul;
> +	return t;
>  }
>  
>  static void set_overall_timeout(void)
> -- 
> 2.55.0.654.g21b8a5bc05-goog
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
