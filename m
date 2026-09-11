Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D69C88E53
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 17:51:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7FBC3E926B
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 19:51:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B7083E9251
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 19:51:15 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8809C14002C2
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 19:51:14 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca696c4b152so236562a12.1
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789149073; x=1789753873; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YrxBv1cye/zmcEBOo7cHlxZWfDvCOcbb0qmLAjiDDk8=;
 b=Z8fQyu1bVVSiScKMP5BAcvvJKNAILBvTxn4wa+U8APnJBjtBbv7wl65UkUVrZSyTIY
 xF4bcLoHv8onIO05nFkEJtPnSp9ZdcETs99UmlppS2mXs00IMNX52kfbrYrpme9fWC0S
 2O7lTavM+E5UEx5uBtOLhtQcT/z88C45WpFP/AJuNymMTnd4llNQBh5+DAXyF5oSKY4G
 o2VBgmb1yK0F4tHfRQsDt9XcK/thmDlY1/WkUC23l/UnGcMkinXjQXJFeF+1Xcymm2YZ
 XXndshHvVWtkqXTRHjdZdufQ7apl5GdiXz2OMSkOgCt2APl78/r55HFWZuf7SBA/zyh8
 mrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789149073; x=1789753873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YrxBv1cye/zmcEBOo7cHlxZWfDvCOcbb0qmLAjiDDk8=;
 b=hKtuOKDrrfvDsLh3IzQbNNBKWrSskTphWXJtvjVXLeInhpgQNsReyF5xv7tORO83sN
 sZAk6yVZEiwKDJt6u67gvL8ETQrTHxU2bWmMQ3ccR4rvB/P/5BaN4Ayqq2ApCBfVj2D1
 SvWJrDhnqq7TxNxf1B2MaPeVJdnNXwu8LbxmHtZHw0Gt6yQr27LJhOCdOtmXmDeygZaj
 QSJW2HkHYLsvR9Ryd1H14sFMJP+HugEykYu9HuRBOIbG+LJ0cpZQzQvpYCOJSxrQR9Tl
 Q5+rCfjbrLbW/DUwEH2Ftvlhrbr5YiXiWaSXksHKNzix3MJ6OXJMsZM55vJO93pBH7ih
 ckrA==
X-Gm-Message-State: AFuF++lcWH06thZ6oPheXjq6BzO4u7ZT9weeLyGyQFxcK6Vf1ZkRBEgZ
 33XWqahKqMxLZs7jYCKSYxw6/dGyC+R44phdj92GHeW7wYMllqSeaaE+
X-Gm-Gg: AYBFou3fd8ApnRz4U6xXtvsMozqLcPoeBSfmXEgtDa+EqikxZeA6t5Bg2G/3nqW9+L4
 9n37OwUdSQUnod3VWaGDNN6//ek6npGOKrUQTAeb8pEdXr3mgYoEHhyAiMkdcqSbyCNoffNXfgy
 Ex1eiQAelzWh/37BDUaZlPPGjY13uO+F2i1vJVevbSASfmO6VJ+PWW9MklEWYu1EVgen45QhNmP
 A6XIiOco05Vz+lb/NBgH2UquZ02XD/7EtOnHrWC1cQzWy0gpuB8ggRfF/y60egcAkpK7Weq9hE5
 ULJgP5MNdIpHga/RxP68pmUvr2YkCto4K+wn5v0ee2OxfQBtSFnkn2dKcu51uVOBhZKOMiTdOul
 YxOzEKLoxubHAguxpIFzwuYKIarc7nabd5Dfa7j1ySATuL56Wd/7D5XSnzBbyWTeF6dCtu6h9RE
 ae1lpyAAqBvER+/u4TZ9uGqjeESQfqOpMnUuJkCHMAK5vqFYgOzvTkwKdT2H4csuIdY48svyAzA
 /4QcQCx1reYRSaUr8RcjStvNee3SO+CEGDPMu1ozdqpHbJn/0lCIy+utMsrB8SSXo+4lYOr9qzA
 SgxYUA6YUEAZcaUEjh8dDQ==
X-Received: by 2002:a05:6a20:7347:b0:3d1:39e9:b269 with SMTP id
 adf61e73a8af0-3daed15388dmr9271426637.4.1789149072719; 
 Fri, 11 Sep 2026 10:51:12 -0700 (PDT)
Received: from
 runnervmlun5p.2egbwc2figsurhoyketqa1qpfb.dx.internal.cloudapp.net
 ([104.209.7.217]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f739b5sm8099516eec.25.2026.09.11.10.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 10:51:12 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 17:51:11 +0000
Message-ID: <20260911175111.9972-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-cve-ghostlock-v10-1-817cfb0187eb@suse.com>
References: <20260911-cve-ghostlock-v10-1-817cfb0187eb@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched_setattr: Convert to new API
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

On Fri, 11 Sep 2026 15:14:34 +0200, Andrea Cervesato wrote:
> sched_setattr: Convert to new API

--- [PATCH 1/5] ---

> +	if (sched_getattr(0, &read_attr, sizeof(read_attr), 0) == -1) {
> +		tst_res(TFAIL | TERRNO, "sched_getattr() failed");
> +		return;
> +	}

Returning early with tst_res() skips reset_sched(), leaving the process in
SCHED_DEADLINE for subsequent iterations (-i). Use tst_brk(TBROK | TERRNO,
"sched_getattr() failed") so that cleanup is triggered on failure.

--- [PATCH 2/5] ---

> +	TST_EXP_PASS(sched_getattr(0, read_attr, sizeof(*read_attr), 0),
> +		     "sched_getattr() with valid parameters");
> +	if (!TST_PASS)
> +		return;

Returning early on failure skips reset_sched() at the end of run(),
leaving the process in SCHED_DEADLINE for subsequent iterations (-i).
Call reset_sched() before returning.

--- [PATCH 3/5] ---

> diff --git a/include/lapi/sched.h b/include/lapi/sched.h

This commit should be placed before patches 1 and 2 in the series so
that those tests can use SAFE_SCHED_SETATTR() directly upon conversion.

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
