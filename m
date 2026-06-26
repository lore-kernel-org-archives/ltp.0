Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2110CD4F26
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782465270; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=9/to7+m5oIiXat42bxYzvlDFs8N8jCJAGYMBKaDt6w8=;
 b=id4UPH5qCvNzf6lnV9guiU6Az+6n+Z/i2l2L6xjHXDfL5OU5sG8FQkkOGwQ1qvhJgD4Sy
 z0XW4xu1IEWnThZ6R2IvvlamGSXacfyx0RqkfhfI3ejZhLVzwX9wFjVlWlPk0tMsRcMfi3p
 rxtqPW7gVQzQPRRwJmFtfr0qsGrNbsk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F2E83CFA87
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 11:14:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51C833D0676
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:13:54 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C34C1A00CBC
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:13:53 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so4228125e9.3
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782465233; x=1783070033; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=n+ayXuXpHm8j4uGeJ8JYL+SotqOKb5sMzYpJhvOjhqA=;
 b=Mk/Xd5bcjF4USvVcimIs1AZ7pMo8ezeI31Pfnfv86MzQ44i5QV/36Olm8az38fnxpd
 MP8kaW4meWIGjLHAPTkYx/JLFuWWr2rgB5SOzu2WfLlGMgA5X0nRqPrsP3TLMdLPkVz2
 ct8qybFXaoLq+1CoFOZz9HOqjHeGMtgAdlaZNriF34bwIxYpkudJfxgs107z6khJpyLH
 6WllEMAB8//QF5lq35azonE/BqQcDjvXpVwTjujaCtoByAK3GavlBRvBwd9uoTY7JPMY
 BSK/jmm0VAThoZKGhuE8Ly8woa7Sn8FrKyED5DpGl9wXsN4bJ8N7cTQnYrbBE7ik/giR
 deFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782465233; x=1783070033;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+ayXuXpHm8j4uGeJ8JYL+SotqOKb5sMzYpJhvOjhqA=;
 b=oH5gA8PU5qIse0M7Ir2j1SF9m4tu/YwKL8IXFP5i0cHl8oo5fbIUCnJTMXcpKLO9TR
 OhWEjh+Y4OwFWPdBHxzI7JJ6ssgOqGVVO0f4wvRamPEsF0LO0n46TRBcrRLZILseoICR
 HXunQxud2BBmSGFZUYNDY6HlQBnDT759ZUE9vsX3MkyPb/m4hiiATvkYGsh8kU0quMoR
 PuJkES3UCtjkYYAd90+OBLWDtD4cYEBAVosNbSgRxHqF7EDdVoDqdjKKDuFHFiOF6Src
 mVHskBVIagiHfCsmm7nA1IVgOi5TLWqKwkqH8g2a8U2bPPmPjbwD0BxPkkKigo3WE2ne
 2G9g==
X-Gm-Message-State: AOJu0Yx5OQNzsA0kYtfqszfSQ/iR3QEqpg8ivdo9/TokFYr6Yp5XaBkL
 PvTnYwDsiCmgGJMTUzFJACynrPFcnm8oB7Q1sw2kLDcN9bq7vk6m9o/UBWE/fgUDe1TrwO2lK/4
 xw3OcDtDh2A==
X-Gm-Gg: AfdE7cl7YDtJUBP6NFy/OLDwPuG54eIqPQKS3v6ncOCkESVOCL2YUb6FZX8UKV+dDNA
 8uWrlbhWQAchlPqY19D/d4Oy0mLPtOpxn0xTYIlb6q64cA3LWmdIjezBYH+Hs2liZYofZN3Lt1M
 ZkY+00sloIe9vgFcCaYU+DMgAMtGKS2OcqBdHVJiSgeOney0UBfDplmHDZVyvGfRNXzYw/CSy3V
 rUuYBOSrGhBrTOUOCmbR09UcHnnPJxk502rpFyVR2AwfMxdGfB/fcsO3RXv1BXxkX903PRfQnRk
 ziM88g6QZWl7RGSu0/xC9nbMPi4IiXHS2Dgt+X8lD4axbTQcmokWnw4MV40M+0Fe3Q9LwdJayg+
 Fnv5ExQch40yITL5Zf1SCgEb08yfKAl4prZG3wCNV9iRmNQc5rjxV9xiz77UFEQEaHHodkQAdKj
 BXiW3PVyuKqo9F39MIhX+byGMjFywti6G8/B8+TmcdYGEjCUnG73V4IPTI1ZAFbRV50jGAJFa3a
 xvZvmuu/T73d5vk5assPtJ2
X-Received: by 2002:a05:600c:1392:b0:492:488c:f630 with SMTP id
 5b1f17b1804b1-492668b6847mr91793845e9.34.1782465232698; 
 Fri, 26 Jun 2026 02:13:52 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fd9f2esm56622935e9.5.2026.06.26.02.13.52
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 02:13:52 -0700 (PDT)
Message-ID: <6a3e42d0.2cf1dda8.3b5368.08d7@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260625145722.131551-1-avinesh.kumar@suse.com>
Date: Fri, 26 Jun 2026 09:13:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] set_mempolicy: require CONFIG_NUMA
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

the patch doesn't apply on the main branch. Please send
a new patch version.

https://github.com/linux-test-project/ltp/actions/runs/28183890018

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
