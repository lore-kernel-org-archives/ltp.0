Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F6AC5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 10:04:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8374D3C0EC7
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:04:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F19203C0EC7
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 12:04:02 +0200 (CEST)
Received: from mail-yx2-x00.google.com (mail-yx2-x00.google.com
 [IPv6:2607:f8b0:4864:41::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E860F140075B
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 12:04:01 +0200 (CEST)
Received: by mail-yx2-x00.google.com with SMTP id
 00721157ae682-81e93f3e6b5so20899147b3.1
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786097040; x=1786701840; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=boOUwHtWVj76ju6UZc8Gd0iDpuBBy3Rqv92gvBbZQXI=;
 b=oQhultMz62MbfRmkJBhkRfh9iZeJV0/d1rIPQCUR10GN4ZGjIOENJfHYlDHmdrcSTT
 nsOqAkM0G5/4iVX1tHIWwjzInLnPb+MCbNvGcoC7uWfLOjiYXfjJxaEA0RUOEZgYisR0
 KPObzzt48QjGpZTtorxi7+7gYH6YOX470NomMSabvUjPct878yuXJSYgzxNZNS4tOy19
 WCJKfryiV/3voOTGPnxOKYEymeciPCz+LfdUJXMmJCCXqhRuqJIbeFU7UXTWeT3WiX6/
 7/NYf0Lr0U56MEb5VbkPKg2zbZ8WkeFZ0+64JtQY18fdJg8YIm0tAOsrK9ZMtN7AG8Ql
 nekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097040; x=1786701840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=boOUwHtWVj76ju6UZc8Gd0iDpuBBy3Rqv92gvBbZQXI=;
 b=WuQmBgCbagEI1fCIjhKGRgMQPSG9VwbsjMZPEKmqj1hMtnhAgWs77AIFy1xWCk0Bqn
 ryd89fXqNfrhXnnp3CmeYPuLEfdDApWDwfqm4q129Oz01nNEXFJvbLL5OGCj7AvPWMyd
 cjlcziGoe/qNoRXVUHf0YzQ149Ys/tLiEeTM2DVblMRPjC8fCB2QUSBdPxSzfkzpa0+s
 TF5ymGjPVETYD3on8XVkoN/LHrWL9nvlbrgwOHCitab08T0lEBZE3mzeq2FsulXHruA/
 wnh1KxlLA3shd+ZClheTkpQn+7ThB+9nKO8meVugNhSDZy2joCs/JOt6zWoNXCE3jjkN
 jmLg==
X-Gm-Message-State: AOJu0Ywe0DMkkxKEzkYCdMyYXpne5uYzIW6xb22fPqLTgZZ26+XI7GaF
 yygxp3NHMArj46b2rx156OHWHXenopkdBd8Z1cNN2y8sXqc9q33Cl6RV
X-Gm-Gg: AR+sD12se9IWqepBAdnqz0p4mz0/Xb98nidmTgREe1sgEGmJTby0WWIF+SV0izk7oWv
 FNY50Lxwd4s25RWTZFRjPqutkYPkT6zH82QQKtdqxwapf3pgs4F4c5/hNitpcH0YvXXZYAe1NsQ
 +QgSsBa+5icdzQDXuUrpf/4DdG8W71qLVWJG3Wjg3DcUnwZcxZg3bxKzGBs7I2dJ0OCLWfxJyaU
 mT472zDEpctNdWDZuE3URvKquwhM73H0So4SxpojrKaL0OumZ4Q3bgqSM19rwb1wl47Ck9kUReP
 qDqujZ8oNnS4WRMs5J8OFrV1CYIYVxRt3/n8PoHo9eAhlsuo8p1Sl51w5sh3NUZO8vE8Mtc32MJ
 5fpH4wjb/jLmplj+Ml6mvxvbduj+rRsWrELLLAw9Bs8MCWn4RfAJPulhK8BptTrwCGK2VU2Mwzv
 5l/J1XsRD+aaWljSmyaGM4zn/xtwK0Cw2mgH2z9knc/OGql3Bf8VcMsaiuDfDmrQ0boE6RhZe9v
 KVOs5SAc9MsxhsGL3aBuY10g6dozTCABbDc3RdXk7VqAbklLqyrUos0PFM7UqBu9jMVcv//7h+s
 m+g=
X-Received: by 2002:a05:690c:6890:b0:81c:b834:47de with SMTP id
 00721157ae682-820224ac603mr147582537b3.18.1786097040496; 
 Fri, 07 Aug 2026 03:04:00 -0700 (PDT)
Received: from
 runnervmvrwv9.cbgmrnujydzeffxv33pdlcfdwg.ex.internal.cloudapp.net
 ([135.232.224.101]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-823f03c85fdsm7121677b3.11.2026.08.07.03.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:04:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  7 Aug 2026 10:03:58 +0000
Message-ID: <20260807100358.4121-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807-convert_fallocate_suite-v2-1-3761f7b74b1f@suse.com>
References: <20260807-convert_fallocate_suite-v2-1-3761f7b74b1f@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fallocate01: Convert to new API
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

Hi Andrea,

On Fri, 7 Aug 2026, Andrea Cervesato wrote:
> fallocate01: Convert to new API

--- [PATCH 1/2] ---

> Convert the fallocate01 test case from the legacy LTP API (test.h) to the
> new tst_test API using a table-driven struct tcase[] and TST_EXP_* macros.

Could the commit body explain why this nontrivial API conversion is needed?
It currently only restates what was converted and how.

--- [PATCH 2/2] ---

> 	TEST(fallocate(fdw, FALLOC_FL_KEEP_SIZE, 0, BLOCK_SIZE));
> 	if (TST_RET == -1 && (TST_ERR == EOPNOTSUPP || TST_ERR == ENOSYS))
> 		tst_brk(TCONF, "fallocate() not supported");

Could the filesystem support probe be removed, or availability handling be
restricted to ENOSYS?

Linux 7.2 validates the read-only descriptor, invalid offset and length, and
offset-plus-length overflow before consulting file->f_op->fallocate. These
error cases therefore remain valid when the backing filesystem returns
EOPNOTSUPP for a valid allocation. The new probe skips that coverage, unlike
the legacy test.

> Convert the fallocate02 test case from the legacy LTP API (test.h) to the
> new tst_test API using a table-driven struct tcase[] and TST_EXP_FAIL for
> each error-path oracle.

Could the commit body explain why this nontrivial API conversion is needed?
It currently only restates what was converted and how.

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
