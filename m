Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCADC61DB9
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787665984; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Q+8PSE7wTjFbxEZebEQN6zqRoJBCF3lNxOjyb6r4qN4=;
 b=Gg/7/G5a7BovD9qT1JFuVBPMnIT1Qc9v22m9G5QuEVJOZ38dIWdwJeelpVdwaUYgJuftf
 Vi0INg8Edc/jjsvqQXrHbNjKME/gBSNETCLT8XjntTEBqpJBJZVp2MBbb1Ev0so4vHj3JSz
 bm6FK701nMQeByyZAfhfrWU5MFQmfd4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F4143C5A12
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 15:53:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B9C83C062E
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:52:43 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F227E60012C
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:52:42 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c16794450aeso709333566b.2
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787665962; x=1788270762; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Apu6RSh4qqDQ9HKfJdG+CHhvYlAJ8Hy31j/mZyDd6bc=;
 b=XdwYc69L1/OjUgwwFP0SMwqBWTpIVufbQ9DbtvDt4PX1jxuQmO3BJetnsk13Utf8aP
 3J4qLxAaQqgLFVapMuT2FbuKm1OwXFd9Yk5eiP6/8EFiShAdvDISw7T/lW87E09fJjMJ
 kpTnitn7Ryq6JGIWlZNdCA1pFEtfP4PxGmeE/uIfmqALEMsJrPQYHUv97pKtpj5tcH3x
 HvsCjwH8Xi7YXxLG1yXwAuQSEvScJ6OsC/s7fQb11vLDZ0Klx4aqXtqV0xu+jLLonDiE
 OMbriQzpZUj6NawR/OSxoLMIRSplKyE5gbtJ6LLJIVQMZcmhwXFh1Q47hLTRp3w2gq/q
 k7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787665962; x=1788270762;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Apu6RSh4qqDQ9HKfJdG+CHhvYlAJ8Hy31j/mZyDd6bc=;
 b=oZYKYusA1Bb3P4gsuqrAF70VpmeDmHCQUzjq07ik2GKLWY0Hhuh1+yhYhRsl7jaGiL
 2M/b65wYmfgJWzCFf9A2T9Av387W7UOGJwM9R1IZB7rlUc0cyBaUvMvLJrPXPKHekQl0
 X6NHbQaAtoMUDJOiDjyDcf18ojauIzFGJWuv9uE9AohcT1+YKWDPsxmDCXVLslvpt+Tr
 B72K1KwEVjuiKKA9iQKTPHSosj+y/XrKZXMD89kH5mobV2FcoGzTMKSvOS/IFy2htkIs
 F1oJGbe9r3jgLE9ZUN00IPEDrPdrC1DeIYY7EJEuEWnSwVZFYf0L5n3bLfxwMeFdEyCn
 o4ZA==
X-Gm-Message-State: AFuF++kPCYjL+IoGKKV+9OHh2rYGvu0gEl8YL1hXf3K1nUleVEG9fLjE
 oOx9VpDxp3Cv8qDJEaO976SgS6M1gTh6aNY+qUpsXF9AdYrocrhmUFzO7bHEI09+ics4Uori6Qv
 CZgobeJ0=
X-Gm-Gg: AR+sD10tEGhGsEZ3kN8AeV0FpNSZBDLn8fMrqVAvXv6AlycreooeG+jtzOG4QgUEoCy
 qjUrAt7toLqILGMNKlkmY7tHPRscRjmW3ZkKNbtSDguRG5jb1XAMwlgMBXgSJMCwAdyyoLKo7IH
 oypcAouGcvqatbuuxHdOy4kvP9aPSkFgyx/bmQbuMxVk6q0kVlqYlgdp6U0W9VDainlMINhQh9t
 T068ej8S+2tlDTZ7IsOgrSRgnjAHS7j5n3NLWnzsIsIfVPRFHTOb9JHyt6xSnb5C1Tj3rjt2k4N
 9AIoIw3f/HW6THsu/jKg9BCAA6vr5Roh1unGSoP6C99y9r5us5cqaT0C/JlgMBVYBflWoNVx1wk
 MfRZKIGTqaUEytPHu/8nulyaePI8X5KvOFOM0SHN1ki6gwZIMHLSkEEp9yIjM8+MGLIttGUucD3
 DhCWiNpKsr9SzM7zmmtUI35v9maJZ3HeNZmVY7xKaYe9PfVuqAsens3Z8yZLsUjfl4RwgbiNe+o
 ufBAQaMjT2imWbDT07nBHANQ7O9Iin5tiQx
X-Received: by 2002:a17:907:e1d0:20b0:c20:f864:d480 with SMTP id
 a640c23a62f3a-c246a6559aemr2885304866b.13.1787665962211; 
 Tue, 25 Aug 2026 06:52:42 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496297189sm1734898166b.22.2026.08.25.06.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 06:52:41 -0700 (PDT)
Message-ID: <6a8d9e29.215ab133.223754.df6f@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260821013917.28499-1-wegao@suse.com>
Date: Tue, 25 Aug 2026 13:52:41 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] shmctl03: Fix 32-bit compat mode failure by
 adjusting comparisons for compat mode truncation
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

title is too long, it needs to be shorten.

> On 64-bit kernels, the default shmmax and shmall values often exceed
> the range of a 32-bit unsigned long or are clipped differently by the
> kernel's compat syscall layer than they appear in /proc.

Also here we are above 85 lines.

> +/**
> + * TST_ASSERT_BITWISE - Keep only the lower 32 bits of the read value.
> + *
> + * If this flag is set, only the low 32 bits of the value read from the
> + * sysfs/procfs file are compared.
> + */
> +#define TST_ASSERT_BITWISE         0x02

I was thinking that this should be probably TST_ASSERT_TRUNC_32BIT, since
bitwise is misleading.

needs to be fixed before merge.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
