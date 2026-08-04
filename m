Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3594C55172
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 10:42:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A14D3E716E
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 12:42:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB6FE3E4982
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 12:42:01 +0200 (CEST)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 719AA10009D0
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 12:42:01 +0200 (CEST)
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-497e6956acfso558240b6e.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785840120; x=1786444920; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LuySy+m8b+Z6+vHuifNi3a6qxCSQX2g6TbUZDE4TIPQ=;
 b=GYV2r2kw/5J7H9ylbiYCbcIPmnjKjo7VFVO8ZlitQ9kqvdK3kzRW+A7+6A3LrXoxa2
 Ig5qZuScVdCQLpl3UEMHI9Qcg5Orw58gDaoUk2/o9TcAyEDjDw+LtAML1gyvxW4sgrR2
 O1TkFBLJCZDdsCsB1rMdsSNVL6xIq+9wGYssn1IjLQUu0LI13Ohl6EEsypoDNbC/KAaS
 cHfZr1Cxb5ubHUqINZ1CKLCuC0uH4c5RSiD6oMgSEgZpA1N1PNdAE2cOmjPkYQrxqqMy
 kRDDZ3QJmXP7wprSxVJckQMlYBim55nkqWaFsRn06BIZV6F/Gp8VQum25euJpafRAfNl
 D5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785840120; x=1786444920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LuySy+m8b+Z6+vHuifNi3a6qxCSQX2g6TbUZDE4TIPQ=;
 b=Ql+Px2V5vatOKWOp0YwM5vshATcfBWVNN+fiwKnnJyojRHdcysksZV0VbhZPGsGOpz
 UmomcNoOj7AG1+OZZdscIDRn3tkuUsFY0OmhbZ9CaG7xR938JpWM8DF2W1FWVcxn4COU
 hfQByrmLr12opfE3KcSpX/TtA+hGxm2PBatA4GAzlCw/48afgUivRWmS72soPDQza1Nt
 mKrT6nC7VOuva0sEIRSczGfH/qf29qyYkZIZsA8SAS74egHbVNqzmxIhvpr0U9APZavV
 7VfVO1cDbd4lsACWWJjGPtc2wiK5tvAu3tZ60ovC3lT+aQoicpofue4mS1J6DuEpkIsp
 +gDg==
X-Gm-Message-State: AOJu0Yy63uBF0VoXjoWBRkwUbjtNVHdifgrJXBSAxjlUznYTDHzh5SH1
 uQIkjvF62o+IZiLU/y+5hzoljefTFRe4UPjRLLEz9NOe7Iayti1Y2gxf
X-Gm-Gg: AR+sD12fH6NT51QtlLcI693rRQ7lfGMK+ahNCjdfq8gMWMFHdj26fV4/Wv7eJ+ZrF10
 YX6aKchM8uH7iKW2wtB1fI2WOaThRJ86GfEQaYpS/cd0unQOJIJ4HfzeJconopXcIsqgYgsEaHY
 UXADt8ati1wY3ZJgU6gOR4WO4AC6140KJEpJw+1jakNH7bfnYn+SHOGW6mYYnW2VCEs9qwtrfo+
 NnxYZgJOlneLJYCDT4dCrz8XBv370SFKHxutcJTYgkji+ESqpuaRBkWoeyDS3DOoe7U+5CqvyyD
 PVN/ysAj/87gupBUEOcXrM141568yk59DSOKrothhe5ykLuvAnmGEBsjV/s7Vn+YiYy3q9V4KZg
 MzWH++1zyGsQd8xyppnXOhzsJ4T4Do/dW4OV+35sIn42PdfYZ1XrzuQ/OQOvcj1CR6+V6HOJxVS
 fCaj71mOG3OjzKj0aXSMYygWdh39E3nQ+r0barohrJMJF/FajVLcqMsfpzVoXshFJSaRroAaR8u
 KPxjzQ8dkO9kOds/xRAMmmFOb6D6Ud9ChTwZrb0J4PnUomFuKWAfdbR7D6E5tssCGzVuUP8osIl
 TKlv2E6Qn4s=
X-Received: by 2002:a05:6808:3020:b0:492:7abc:422e with SMTP id
 5614622812f47-4af98a34efemr3451511b6e.13.1785840120045; 
 Tue, 04 Aug 2026 03:42:00 -0700 (PDT)
Received: from
 runnervmvrwv9.xplmaoejahduziehhbpepjkxga.gx.internal.cloudapp.net
 ([52.173.181.22]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f1df566e2asm428829a34.13.2026.08.04.03.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 03:41:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Tue,  4 Aug 2026 10:41:58 +0000
Message-ID: <20260804104158.9052-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804095925.495813-1-pavrampu@linux.ibm.com>
References: <20260804095925.495813-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol05: add cgroup v2 task migration charge
 accounting test
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

Hi Pavithra,

On Aug 4, 2026, Pavithra wrote:
> memcg/memcontrol05: add cgroup v2 task migration charge accounting test

> 	buf1 = SAFE_MMAP(NULL, ALLOC_SIZE, PROT_READ | PROT_WRITE,
> 			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
>
> 	TST_CHECKPOINT_WAKE(WORKER_ALLOC_DONE);
> [...]
> 	buf2 = SAFE_MMAP(NULL, ALLOC_SIZE2, PROT_READ | PROT_WRITE,
> 			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
>
> 	TST_CHECKPOINT_WAKE(WORKER_ALLOC2_DONE);

Could these mappings be populated by explicitly writing one byte per page,
and could the test declare an appropriate .min_mem_avail requirement?

mmap(2) states that mmap() does not fail when MAP_POPULATE cannot populate
the whole mapping. Linux 7.2 also discards mm_populate() errors. Under memory
pressure, the parent can therefore report TFAIL for an incomplete allocation
even though cgroup migration accounting is correct. The test needs 80 MB, but
currently has no memory prerequisite to turn that condition into TCONF.

> 	pid_t pid;
> 	long baseline_b, after_migrate, after_alloc2, current_a;
> 	worker_resumed = false;

Could a blank line be added after the declarations? check-memcontrol05
reports:

  memcontrol05.c:80: WARNING: Missing a blank line after declarations

>  * Two child cgroups (group_a, group_b) are created under the test cgroup.
>  * A worker process is placed in group_a and allocates a known amount of
> [...]
>  *   group_b/cgroup.procs. In cgroup v2 memory charges are never
> [...]
>  *   that allocated them. group_b/memory.current must not increase

Could identifiers and file names in this exported RST block use double
backticks as required for inline literals?

> 	.needs_root	= 1,

Could the description also state why root is required? Root-only tests must
document the reason; here it is needed to create cgroups and move the worker
through cgroup.procs.

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
