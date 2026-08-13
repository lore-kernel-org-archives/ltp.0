Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23ADC5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786649962; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GVlxFo8sUpi5SG7xLOMnXNpX/DV0V1QBPWaWNB4y4JA=;
 b=j+s/umhCjS7DGL54Lm/RgMqQvOImXMU5pQiaKXsgHQJdjOpEYYgjafTYNjbN/7Yh21Q/P
 KcY4XEMBqdcpWGV+JNapnPnExOHLvcpePjeEvpu28CdSf35z+Nw1YmeZ90clYrVtTT/Lx24
 myEom7y56WHmu0o5QqQNLdUd+rsY4tU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D54F83C6FCB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 21:39:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79B183C5E07
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 21:39:03 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C3706200248
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 21:39:02 +0200 (CEST)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso177354a91.3
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786649941; x=1787254741; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mzaeA+cYOnqvdGp+aELoc7NyMQhgLsZ+oGZ0NvXA+ao=;
 b=T54Ufzbu9BbE6o04+fOdqu7fVsszUEY7N1mwWR2aOk1bru4lTndG+fCpm4tv/rr1/p
 yuRlkT2bjQXuOF1gg9NP9ycYmJRDBh7YaQ23UrI8pS3VyTp7mLqloXVDpuXFK8Opf/MI
 q9FXT35ZCTqe/spyKDrxI1BYlo/idT0bPP6F9mnkLKDdrwoW755RT1lr/Br/Pp2DUJwg
 vSS5V+xDAcCAdk3Su/7DvpLgN+Gb/jDo/6IhFfYZ4wAkDConAa5uES04QsA+yfno5WQn
 L9n+Fm4caNNTgkTS209drPHj5dqaEV1gRooKhawE6iY7rq1JNGVm67X4imH7WldDwhMX
 2q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786649941; x=1787254741;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mzaeA+cYOnqvdGp+aELoc7NyMQhgLsZ+oGZ0NvXA+ao=;
 b=P2I39xiKIaWyZ6gyJNnR5rYHIjOWMBiN+sqWk020hzjJR3I0Hh5wk9KNRKoctOaXPt
 MRdgjDOSOoS+F05Qa4WqbmgnczdDhRwCz/faEjqy0L04jw6H3HcjuDBS7Xd0TPJd5p2Q
 ukKCb3O5uTgM305SMLgPL9V3k3Z1IfW3R9RQ/HzAKBeiQP4X7dJnsHHO60ndA/qcrcVA
 ohF0sjI6/kK7kbp1Gfs4lYAGRpY40bF9DlpJ5ZNVzEkJvONg6H0OTo83V3ArL6PoytiI
 CxcrqbQl6CjHqbX07l6J75X83j7/6/ECG0OTCi4vkU44qXxHsJuYG+3j2MarataNJdoi
 t/Yg==
X-Gm-Message-State: AOJu0YxU5COdK4t/sogr453F03wXZnqcD8B0IFPpuPyy28z5NrbJaXYE
 G1Nu3jxhyhVfzweKwa+T+yFavTK6QUkV5Y63o+NZXS/Vpq2RQ2bI8iOR6dtl5WQqwA==
X-Gm-Gg: AR+sD11dlRhE9l+cZRsD79wIiosNq9EOJiAmKcZMeLeBMj4/ZxJEgKkbb7tJr8x0Abe
 EkaWEWurGqus59h/RJvsZ5HAU2K4rPABjXT1YSwKsAYb3xyxHt4wCPl8PIYnqlRMkQfr/lP/nWJ
 qDKw/eXSdyZjgB6oN6XolOCTJ2wqRswyDDmpXgECFuudL00Kt1nVYcwgPjj8Uqy4WRqj6WyKksN
 6b6sn3M46ltZ/Fn/mZ723fbACHbCDJ4wOfJHOWrmdryknDD+CW9KgnYuzXaFm0W0MjOoHPHik4z
 yZ+rnwMtulmRc+0cdGFA0E2blqYXSyLntU89rkio8wEuvdfsgUsSdhqZVcybbtPO4UPE39YDhV1
 fDxTzV0M9n293nHRkju0iUbVbJCkPaz1T2Ok3DAWiOFC2Iq1Q+FynR4MU4c5RxcynU4YkGpIB/p
 y9I2L3rcYKX6usQnaqsAaPlDqf8nZ6FtRGy59bjjI2x8zT+eYuiUuqVUhJFJo2P6U1dy2CAWxlc
 v7FAFnUtbRNkMjspoYIqBeiasBW/dE=
X-Received: by 2002:a17:90b:5450:b0:37f:b0a9:1a68 with SMTP id
 98e67ed59e1d1-3933b8470a1mr399835a91.7.1786649940499; 
 Thu, 13 Aug 2026 12:39:00 -0700 (PDT)
Received: from google.com (131.109.125.34.bc.googleusercontent.com.
 [34.125.109.131]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39339eca06fsm615149a91.4.2026.08.13.12.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:38:59 -0700 (PDT)
Date: Thu, 13 Aug 2026 19:38:55 +0000
To: Frank Ranner <frank.ranner@intel.com>
Message-ID: <20260813193855.GA882351@google.com>
References: <20260813152433.73259-1-frank.ranner@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260813152433.73259-1-frank.ranner@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 ltp] testcases/kernel/crypto/crypto_user02.c:
 fix hmac candidate probing
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
From: Eric Biggers via ltp <ltp@lists.linux.it>
Reply-To: Eric Biggers <ebiggers@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 13, 2026 at 05:24:33PM +0200, Frank Ranner wrote:
> Commit a4be708b4 ("try non-generic hmac names first") added a list of
> plain algorithm names (e.g. "hmac(sha256)") that was probed by copying
> each string directly into cru_driver_name, the same way the pre-existing
> "-generic" fallback names were already being probed.
> 
> That approach relies on the newly (or already) registered algorithm's
> actual cra_driver_name being identical to the probed string, which is
> not guaranteed. On current kernels, "hmac(sha256)" is satisfied by a
> non-instance "hmac-sha256-lib" driver matched via the loose cra_name
> fallback in crypto_alg_match(), while template instantiation of "hmac"
> produces driver names such as "hmac-shash(sha256-generic)". Since
> CRYPTO_MSG_DELALG always requires an exact cru_driver_name match, every
> one of the new candidates fails to delete, and setup() silently falls
> through to the legacy "-generic" names, which are themselves absent on
> kernels that dropped the generic hash implementations. The net effect
> is that the test still reports "No viable algorithm found" on affected
> kernels, unchanged from before the commit.
> 
> Fix this by not guessing the driver name at all. Probe each candidate
> by algorithm name (cru_name) instead of driver name, which lets the
> kernel resolve it however it currently does, then use a new
> CRYPTO_MSG_GETALG request to ask the kernel what driver name actually
> satisfies that algorithm. Only that authoritative, kernel-reported
> driver name is used for the deletability check and for the later
> CRYPTO_MSG_DELALG calls in the actual race loop. The race loop's own
> CRYPTO_MSG_NEWALG calls also switch to adding by algorithm name, since
> re-instantiating the same driver on each iteration requires the
> template-parseable "hmac(...)" form rather than its resulting driver
> name.
> 
> This adds tst_crypto_get_alg() to the shared crypto netlink helpers,
> built directly on the existing low-level tst_netlink send/recv
> primitives, so any future crypto test needing to resolve a driver name
> can reuse it instead of re-deriving this logic.
> 
> Verified locally: on a live 7.0 kernel, all of the plain hmac(<hash>)
> candidates for sha1/sha224/sha256/sha384/md5 resolve to permanent
> "-lib"-style drivers and are correctly rejected as non-deletable, while
> hmac(sm3) resolves to a genuine "hmac(sm3-avx)" template instance and
> is correctly selected; the race loop then runs to completion cleanly.
> Rebuilding the pre-fix version of this file on the same kernel confirms
> it falls through every new candidate and only succeeds via the legacy
> "hmac(sm3-generic)" fallback, reproducing the reported failure mode.
> 
> Fixes: c05a44cf ("testcases/kernel/crypto/crypto_user02.c: try non-generic hmac names first")
> Signed-off-by: Frank Ranner <frank.ranner@intel.com>

This misses the point of what I said in my last response.  In current
mainline kernels, if you request "hmac(sha256)" you get a
non-template-based algorithm with name="hmac(sha256)",
driver_name="hmac-sha256-lib".  With "hmac(sm3)" you do still usually
get a template-based algorithm, but that's just because the direct
support for HMAC-SM3 hasn't been implemented yet outside of a few random
hardware-specific drivers.  To actually get the template instance now
you would need to request "hmac(sha256-lib)", etc.

At the same time, there's zero reason for userspace to do that other
than verifying that these pointless UAPIs don't cause a kernel crash.
Honestly we should consider just deleting this test, as it is testing
implementation details of legacy stuff that is just causing confusion.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
