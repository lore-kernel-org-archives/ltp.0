Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5827CC5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 08:20:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A323E3E2649
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 10:20:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 004A53C0F03
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 10:19:56 +0200 (CEST)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 571FB1400BDF
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 10:19:56 +0200 (CEST)
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-3810f0aba07so1560951a91.1
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786090795; x=1786695595; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FLyt+21DeZvjB9ImyI2LPsEgxznqDJQvSWwLqEMnMVE=;
 b=Sz7c09gjWIj0AIhUMZTKVf/d0FsHIrITCThyvJ7ppPu1U5lwjKuKZVyv3T96Pi5utb
 4eStUkNuoy1A4kZh1Egpi/FHBTo4bH4dT36cSgAdkO1JsNrfsUnjwUTM7SUqlWYibwM7
 GXobUEbtaz7ewh+64/6lL4qiab7jQPJ3gtqAdemXYTkxHixN785vNnWGaGW4i3Z6SAug
 2siO00P1l7fQ95iBsw7flCadVpje7h4OsIMwW0Qo0JQcQRQRD1pDkpTSj/lbffjpYIKR
 eF+f+PrCiw3kR1SisMltb111zBMiKvVKB/7Dpio0eYl0wt7nB4PyXHQDjue0jYQo4T1N
 zmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786090795; x=1786695595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FLyt+21DeZvjB9ImyI2LPsEgxznqDJQvSWwLqEMnMVE=;
 b=dhMemGqyZ89JLfhCaMekfVC0Ol6AuP7llcDa9s7mcjqEoNOXLA6YVwTdmSNggSnU1d
 JAMxAK1PUKc9kIR+NRRhgYFe9TRkBboK9iSqm2/ERF3kuC/vzP6ruQrLzymyR5kRt/7S
 LuC5rEIaJ3l2e4a7TwHtcfLuraDRcmw0D22xVMTrXqZq1+fZwjb7Yz0a8oEIyzKthGCm
 qrGCDUn/yjdcepMNgUufobKOsEoR0WRByPZkU1OKf5ztyPVNsGL4cKA3mOJArbJ0juQp
 1WUHf60X/ERH3ySwG95XfcoIM/WMitHQ7rxMGBl2k0TYBqAzGFA1niYxhai9P9QP7zK4
 2Bjg==
X-Gm-Message-State: AOJu0Yw8cOL0aOFgqaUo0f6cizq3EwpnXFRj1gGDp/TBBGlrhiC6dSZY
 0Yqb9Obc8YHN9UtVxike52rFtyT6cvQI/+t7xNIj30YcuEbYalElV/vF
X-Gm-Gg: AR+sD109g1XoIq/c4QpnCTqb2L3z/d0Qc6qUy/t8lAOoClRL3qG1dnqjDRWcRnRAP8T
 vht9iZvngQ95Z38Hl4g5j0bsMsIyWq2jNW4XnDMHciBf/c6svZ/cK5bdG2M57QZ+82AtvlMLj46
 emi894GhgQgwTT9bHjLw5pDPRX9T00BdjKmy2xNYu1DFrn/7vCSX0e6QFpA8LG9L0B5G5yM+Vnw
 yTgKvwlY+8u70kTjFivWKRAerVudt9RngbwrVj8snPaLhv1coNiuQUjzohFFvrQNvnER9tAvegJ
 YBAaTdHZwxN+hoVIBJfRuCFgM1rQUowzK2S4YZfpObcF3k+vqYmeLFvBhReIAXhBvajFbqBkmrf
 dDSFDECoKYHzqY00/h/tNvYQVkET4T+1gNjT5H1GL+d8Jmh5hMyWDTiTiTn2Lext/02eXcaT4sI
 EL6gd4Hf/kzk0ORJVOeQLOwe432Eidt6/OdpZmbGMR71QYxKQbNyhnaymWXQjmaV42DXU8eku5a
 vV0f6qyreO20S6JvmTkigD2brPYSGGWiG+tquNFDraFiGercph1tjD13bAwujjdKj6c7rbQ7NoQ
X-Received: by 2002:a05:6a21:600f:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3cb85e2b72fmr25151646637.10.1786090794654; 
 Fri, 07 Aug 2026 01:19:54 -0700 (PDT)
Received: from
 runnervmvrwv9.zp1jdlg1lluuxdof1vfzjm5fwc.dx.internal.cloudapp.net
 ([13.83.160.135]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141019b4244sm4718688c88.4.2026.08.07.01.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 01:19:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  7 Aug 2026 08:19:52 +0000
Message-ID: <20260807081952.9062-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v2-1-1760ae8e3b8b@suse.com>
References: <20260807-rewrite_mremap_testing_suite-v2-1-1760ae8e3b8b@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mremap01: Convert to new API
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
> mremap01: Convert to new API

--- [PATCH 1/6] ---

> 	if (verify_file())
> 		tst_res(TFAIL, "mremap()'d region did not sync to the file");
> 	else
> 		tst_res(TPASS, "Functionality of mremap() is correct");

Could verify_file() report the final result directly instead of returning
test status to run()? It already emits TFAIL for a mismatched byte, so the
current failure path reports a second TFAIL at the call site.

--- [PATCH 3/6] ---

>  * - Obtain an unmapped address via ``tst_get_bad_addr()``.
> 	bad_addr = tst_get_bad_addr(NULL);

Could this create and unmap a memsize-sized range instead?
tst_get_bad_addr() maps one PROT_NONE page and returns that still-mapped
page. Thus old_address itself is mapped, and EFAULT depends on old_size
extending beyond it, contrary to the description and commit message.

--- [PATCH 4/6] ---

> -LTPLIBS = ipc
> +LTPLIBS = newipc
> -mremap04: LTPLDLIBS  = -lltpipc
> +mremap04: LTPLDLIBS  = -lltpnewipc

Could both IPC library assignments be removed? The rewritten test removes
all SysV IPC usage, does not include tst_newipc.h or call GETIPCKEY(), and no
other test in this directory uses either IPC library.

The commit message also says that the new test uses SysV shared memory and
GETIPCKEY(). Could it describe the actual anonymous mmap rewrite instead?

--- [PATCH 5/6] ---

> Convert the mremap05 test case from the legacy LTP API to the new
> tst_test API.

Could the body explain why this rewrite removes the two successful
MREMAP_FIXED cases from mremap05 and splits them into a separate test? The
current text only restates the subject and leaves the coverage change
unexplained.

--- [PATCH 6/6] ---

> 	if (ret != new_address)
> 		tst_res(TFAIL, "%s: ret %p, expected %p", tc->msg, ret, new_address);
> 	else if (check_pattern(tc->msg, ret, tc->new_pages) == 0)
> 		tst_res(TPASS, "%s", tc->msg);

Could check_pattern() report the final TPASS or TFAIL itself, or could the
content check remain in run()? It currently emits TFAIL and propagates a
status back to run() to decide whether to emit TPASS.

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
