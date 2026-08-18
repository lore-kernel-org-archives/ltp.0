Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AED7C5DF81
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 20:27:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 363D53CD151
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 22:27:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AE463CCA83
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 22:27:33 +0200 (CEST)
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A378820097A
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 22:27:33 +0200 (CEST)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-4b25c60f07cso120954b6e.1
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787084852; x=1787689652; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CfaBtaqNRogNG2W4cZgLph7DB/gNA4hX3R3C+wTUCtA=;
 b=sxt939p9OKxxKyJvK/jk6xiT/fg7hth8ngV3beSwJKHHE+mtwofQq1IB59d18h9IYa
 +W/zRuvvAU3wjo1ydbGz9N9+9a1yuZo/0WRZXSA5FYbi70XJBPDESe6KxM+pXyZmgYZD
 vGc4E4rzdiqC9i6h5uK09n1Z/MQGY0YjV/HAjBLy6CSoTZ0vaUT0Tdwp+CCXg8bPHxmK
 1LE/yjJpSDsTm1ZR/oUPm1/t712RzYYf8ojiU62O4Cr8NGCv+y24T0j7tIf4Vf0/7Qku
 ujmI/M4EaV+bdZDxrunZpt/9n9Ck1zePPKWJWWi0wIriFBB25pDpPGvXx0Czwtkj6C5J
 jpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787084852; x=1787689652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CfaBtaqNRogNG2W4cZgLph7DB/gNA4hX3R3C+wTUCtA=;
 b=JjBKJXhraC4LYU0K27rML/uU8Cj1c79caU25iE6BC3j9bj1c1RgQsLxM1EmWA+ArzH
 JkCnIqHKXwnF8H5A72OSB/YQz82u7Bnh3ajCUdBZFHqexF8Z2DFF6hTWrwX07ws4bY9w
 AJKsVVYHjoZKIdZ2EjNsGWZGu3XY7iwu088eE5r/ZLhMTuabHL/TQ0A1C3DDxmHdmiOl
 JtO6D4pmO7+AJolRamswvFL0KNUbUiGagxJlTL+FZssc8YC0cBz8jTUfV4YF0O5Pz2eC
 y8gx5HojIOAdFdIflRq/PzcuCg1EioSiXPMv+Jd+LB9UwxEnwIIVk1shgrmoDZr3ka9m
 hJUw==
X-Gm-Message-State: AOJu0YzHGhxKwee1I0DVYw8cIPE9uGnf8eEa8LoG2AdWOgGpW+DQ+XE8
 Vz0FlsjuUyhMu/e7fq56VmG2qBfijv2Q3iZ9f7Ml2ZecWZ6Gu2WJZzhM
X-Gm-Gg: AR+sD103vDT6h+VLmEmrXjeqzE/PHtx6J9VYEOMIkJnifFLpGI85N/2SntwmAmHaSFL
 SJ86nd+PSZ8vdJLgEDJgI8gCZnqlhM4+GyAUcSBHr3iCj/VXLXeee7DiVA7ymCoHFeQlYwLgHs4
 S/7hzwQbqnBRsZ3M2GBzOgtn6R5/cWoqNYWz9r/DVPvrkSwzxSyu209EJdaTQG5SoYOqRPxJgBQ
 fCi6Yx6k1PJmztV3OLKgdYUftBpY1GORrejoCqmrQ9yFUeJ4oltBf0TAF9AI+I/fFCXr5lJqGVC
 i1ScjBp/txDAjH6yc3zjttVKXDsnvuJ6c5EmtktWdLnXKxdi4ODY5Mv43M7AtuEGQHb359v9ICb
 6UUlu44DpP3OO2ExeOgj95qO1orunrlFo/orC6kvAFmf7nd441wMVnu0NZq8ZoepGmhTuKRkSsJ
 vPMyjP6ZRa5NRzTfctOckZVropYB2b4d5qn60VS4HPjtThnQDJisoVQ52c2F8eyRAxnoTBub9L7
 bYWif2dyDRQ4KnbAg1ipw/16Z7EcFYWROdNQPO2gHWPJDZVS01ws2uEVQSg0vjjm8z6Bq2Yd8fU
 YRUscykhuXs+
X-Received: by 2002:a05:6808:f0b:b0:48b:1e49:24a8 with SMTP id
 5614622812f47-4b2b915d578mr251497b6e.11.1787084852148; 
 Tue, 18 Aug 2026 13:27:32 -0700 (PDT)
Received: from
 runnervmzvulz.ovgwafzskgce5kl1gcs2ansmda.ex.internal.cloudapp.net
 ([64.236.169.116]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2960491f9sm4149979b6e.9.2026.08.18.13.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 13:27:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Tue, 18 Aug 2026 20:27:30 +0000
Message-ID: <20260818202730.9105-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818143106.43797-1-samir@linux.ibm.com>
References: <20260818143106.43797-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap: Migrate alloc-instantiate-race test from
 libhugetlbfs
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

Hi Samir,

On August 18, 2026, Samir Mulani wrote:
> hugemmap: Migrate alloc-instantiate-race test from libhugetlbfs

> Migrate the alloc-instantiate-race.c test from libhugetlbfs [1] to LTP
> as hugemmap36.

Could this be corrected to hugemmap42, which is the test added by this
patch?

> +hugemmap42 hugemmap42

Could a second runtest entry exercise "-m private"? Without an option,
setup() defaults to MAP_SHARED, so the new pthread path is not run by the
hugetlb suite.

> +	err = sched_setaffinity(getpid(), mask_size, cpuset);

Could this pass 0 as the pid? sched_setaffinity() applies the mask to the
thread ID supplied in pid. In the MAP_PRIVATE path, getpid() identifies the
thread-group leader for both pthreads, so both racers change the main
thread's affinity and remain unpinned.

> +	p_sync = SAFE_MMAP(NULL, (totpages - 1) * hpage_size,
> +			   PROT_READ | PROT_WRITE, MAP_SHARED, fd_sync, 0);
> +
> +	run_race(race_type);

Could each hugepage in p_sync be written before run_race()? mmap() without
MAP_POPULATE does not fault these pages in. Consequently all free hugepages
remain available to the racers instead of only the final page, and the
allocation race is not exercised. The source test explicitly touches each
page for this reason.

> +	if (p_sync != MAP_FAILED) {
> +		unsigned long totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +
> +		SAFE_MUNMAP(p_sync, totpages * tst_get_hugepage_size());
> +	}

Could the exact length passed to mmap() be saved and reused here? The
current free-page count is not the mapping length. On an abort with the
current code it is one page larger, and munmap() may remove an adjacent
mapping. After the pages are faulted in, a pre-existing hugepage pool can
instead make it smaller and leave part of p_sync mapped.

> +		{NULL, NULL, NULL}

Could this use the standard empty sentinel "{}"? check-hugemmap42 reports
LTP-005 for this options array.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
