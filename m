Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572E6C77B7F
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750809001; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Ys8VymHYHYzVxEz7UAQpo31qyA2UK/AxFUBdguwFA5c=;
 b=JCpNYmLJfxL3rC3hjAF6eF/L9MIRLHPhdtpre9dUBbBLBF3dD+NqJfHfAVI+3hqOkPLDX
 PUyyp1DAx8jrLA0EchlyezbBg6bYp1HztfMSwmI52tnRXuKcA2pojN7iqB5j8gI2d1VnNgu
 uAbOPn5rdH7wHqwCF1b6DhzpmiHvXPU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868D53CCAEA
	for <ltp@archiver.kernel.org>; Wed, 25 Jun 2025 01:50:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 293883CCA86
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 01:49:39 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5BF0B10002BF
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 01:49:38 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453749af004so5768095e9.1
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 16:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750808977; x=1751413777; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LYXKvb4WIbtZzKogRcA6GAxGFFF18L0Ix8D86QVuX/U=;
 b=ESyaa+sDxaoSKIIslTL2OJDoPgCjdwpGtISAdKIiW5OjMvNQGa+57ETfBzrI3rwpWX
 EC+cnKHvhkZW6ad1AouWi+HADbPcZ8uieKkAKDi90ubKFAKlnnF5lYaCkvwxNUt1aK42
 mmnWUlqAINyH0BAaAQkysgVwp9TWvv6yIGmdXM/O8RV1eTOP3gIEO0fZ4/94zhWzdVDH
 tRFFVEFOVoRw27ItX/Arfx+1+iWXTmlN8DOUA0fhrPxRRa17vAxzGnNPP//VJS4B2nng
 Hky8lqG6+B93wWBsLrxd6ATapkWBys4lFb05j1tKZb3e3a9d97uBY0eTc0WoZVVNBJYa
 aJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750808977; x=1751413777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYXKvb4WIbtZzKogRcA6GAxGFFF18L0Ix8D86QVuX/U=;
 b=Adp00Pxy14pRh+xb+HWyJO/W8uuFgXnWKDXnlkPRMLkbem4otYu5E2OqbWA8AVsXDf
 +edFS8E1Q8LFQpufyRTfAVmRqeek4P89VR6u39YjcGHda+U43luUK7PREyAewWw5IcR8
 gdP+wZbXNeJ6v+yBIIgeNXpLuP8x7sJvY3Cna0UvWwcs+FeSOM9r+JVD+vkTRzGvrulL
 REKmTdtnUq//GynygyADeXIqIxcvGRwXYiQtfgmlJSNNFn9dbDVtFzXDdAVQiWyom33B
 XCoe1CQMjU2gYYnjDMXLJEzbxVDBbO7N6abC2Yy+sIUreV9uEy8DCpHtdiwy5oqeBCfh
 dUqg==
X-Gm-Message-State: AOJu0YwksxuHdRH4LYQgdFkW5HoPLs7NkRFYLAGSjespAx6aDNqxlVbk
 0D49Ugk+evnoUTMunhLkHTxbqMEBvXVaCkOu2xwldioZA5OLm8e8/29PKHPAVfRZyw==
X-Gm-Gg: ASbGnctCfEyVCVKSndSevh4garXsBHZKmftswXXgu7Qe8Zz5b9XzPC1otM5dmSsSIx6
 LXzcL0a50LuLOsO0Wj/D6Lt7t3Yunybxj86Keb4kmgC5lgbzJlXqhEUNv4sAYCpnXwmfCFQbF7j
 cE1qrZKrmmHK9Xz8eSOpQd1F9ZfX0/uI6YwxAl/vu2jddDYqJZhZLppuHCfQtjMt5ZKEM36wD64
 wtR6wSywNVRhB717dw57wM3g4F6XoJ5TmFoTyvLdi0Z/X2dyn+HUQtV7Spbi8kX60IT07IdMtbL
 cWJsoYwo3nyx2UwgMBuyNDi1DvsoA7YP7ZV0mSlJgXFtIkSievzBx8gxjj+UIQ==
X-Google-Smtp-Source: AGHT+IERV/xR8AA2fhKi5T1dOZsaThiy3+80FiJO7u9kI6FmpT6nFkd67kg2kJid3BV7f4Il652E0Q==
X-Received: by 2002:a05:6000:18a5:b0:3a5:1241:c1a3 with SMTP id
 ffacd0b85a97d-3a6ed64e56bmr375345f8f.50.1750808977598; 
 Tue, 24 Jun 2025 16:49:37 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c8873652sm3003401b3a.177.2025.06.24.16.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 16:49:37 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:49:06 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <aFviMs0k__9ilhvJ@MiWiFi-CR6608-srv>
References: <20250624131413.63830-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250624131413.63830-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_test: Add min_runtime to control lower
 bound of scaled runtime
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 24, 2025 at 09:14:13PM +0800, Li Wang wrote:
> When LTP_RUNTIME_MUL is set to a value < 1.0 (commonly in CI or fast test
> modes), the effective runtime of tests may be scaled down too aggressively.
> For some tests especially those relying on probabilistic triggers or sampling
> (e.g., fuzzy sync, CVE stress loops, long fault injection), this can result in
> too few iterations or missed conditions, leading to unreliable results.
> 
> This patch introduces a new field: .min_runtime;
> 
> If set, this specifies the minimum allowed runtime (in seconds) after applying
> the LTP_RUNTIME_MUL scaling factor. The final runtime is calculated as:
> 
>   MAX(runtime * LTP_RUNTIME_MUL, min_runtime)
> 
> If min_runtime is not set, a default minimum of 1 second is enforced.
> 
> This approach replaces the need for special flags such as
> TST_NO_FRAC_RUNTIME_MUL and provides a more systematic, flexible solution.
> 
> To validate this logic, I ran the `fuzzy_sync` tests on a Cortex-A55
> CPU at 1.2GHz, running Linux 5.14 (aarch64), with only a single core
> assigned using `taskset` to simulate a worst-case, single-core execution
> scenario:
> 
>     time taskset -c 0 ./cve-2016-7117
> 
> (The test was locally modified to only perform the sampling phase.)
> 
> This setup allows accurate measurement of sampling duration under
> heavily constrained CPU conditions.
> 
> Based on the observed sampling time, I apply the following policy
> for setting `.min_runtime` in affected tests:
> 
>   1. If the sampling time is very short (< 1s), set .min_runtime = 2.
> 
>   2. If the sampling time is > 2s but still less than .runtime,
>      set .min_runtime = 2 * sampling_time, and leave .runtime unchanged.
> 
>   3. If the sampling time exceeds .runtime, set .min_runtime = .runtime
>      and remove .runtime.
> 
> This ensures that the sampling phase is not prematurely interrupted due
> to aggressive runtime scaling, which is especially important in CI and
> low-power platforms.
> 
> This change improves test reliability under constrained runtime conditions
> without sacrificing flexibility for fast-path test execution.
> 
> Tested on:
>   - Cortex-A55, 1.2GHz
>   - Linux 5.14.0-587.536.el9iv.aarch64
> 
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Ian Wienand <iwienand@redhat.com>
> Cc: Wei Gao <wegao@suse.com>
> ---

Reviewed-by: Wei Gao <wegao@suse.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
