Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537B7FF8868
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 17:29:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4FE23E2100
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 19:29:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BA5E3C9F01
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 19:29:38 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1D6A60071C
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 19:29:37 +0200 (CEST)
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso8802021a34.0
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777310976; x=1777915776; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqpSPugwwWbZ1ppuZka6xHCPWHcJ/j2V60NBejxVsyo=;
 b=L/aWbm2/dK5n2g7jqCLHaiAOge/9CCo0tYK0Y5KN7Iup6YqAseT3IkSSKtjiRAlQEk
 NTYL/xsfpD5dcfxHeYTvmPvsw9xFjY59J/RdxwsfC0g7SitEL3wrpD4vEfzz/DhR3HM1
 6B2vZoC/o7mBe78+rvITd7lB7tV3iQQ5Za2BzajGXS4mK2KLhXywR10myxh+onG+R7UN
 GR9BopKZXMaqAlcxp7PXqz5xehTP4UF5Wp6OeTfw04hlJwO/QbEGewJLeTdeevlXItiO
 s/aZ7EB574gKK7zfi6v1kImcTNVpQe9D4kJB5PJxU+L6pj83HfhhfNGJGXU8PZ69aeU0
 2b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777310976; x=1777915776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NqpSPugwwWbZ1ppuZka6xHCPWHcJ/j2V60NBejxVsyo=;
 b=HBKu22CgEYccpYL7oSKVgZ1ogWJFoK/FWILm070qBo94qWSn+rWrUFIakY+tDn3h2D
 H2y34oanaVN/YZovne/VUOPzBMdNlLxzb0v/nrg+seKOO15cEIpHwOmlJ70ALbB8UML/
 SZ9WjvESjBZ6dqGvRHg9O3t/IJ9vchLaBwvBoFuiFp8AzGyXR73/+ub6OON8zxogesWu
 Yp0ypcvjtStGkGB895atIb3wKZfAPD5rMXSTJCI9Ie7S2Clhnz0Oion8sTYjKmWAw5Xk
 OB+V0AMbIY8PeWsp7OwGYh1EN1ZcyG3Hd6OmFCVIA7lI3rTgid0kCOnkYJM6TCWoRG+n
 rnyA==
X-Gm-Message-State: AOJu0YyIl94G1BKRAfzbhbOQ0ACD1HO2mfomfNnlc0nVYqJf9/+6PJ7O
 Slv7zc1dwhU25Kh0ljvahjdj1omIFxYGwOZCb4TFTu1Sh+ANGud9Wd38
X-Gm-Gg: AeBDievKn6keAjoNI2HDUevHvpUjZmo1xngyQjncj4XN/GHPPvP/S9Itou70stlVgSa
 wtwx1DSfYR3/RQeRhuppEkXbtxQOR3EdUXGBOmP8pbeueOtDBSto76isygjsZyH+g/wnrc6wZm8
 bGCCNNHN9TwgZTgDbqvdsPaSTi8qXXKhTskQsDrbVMpKZ9aeUv3YRQR3qbU8WGW7zTyzVHyZDZM
 N7NHVbow89QwLCdD3PflZgPgCOfdOc/bolLy7371d4YZcHVLsFErJimWxx60cBcvjfG8yVEeDr9
 EOb7bDg5MkaC6CtTaYo3HbK03TkTecFVYh9ypMabOnijyypPfkpy809mnstrTROJjkwBTYDHRAk
 iDPwakIZTVa1eShQXmSebEg3iXZZ4rkMpXKLHMfEJhz+5X3PVp6tc0ltPeLvD2mJS9N54UiRAuL
 uATe2g3a1kLZlZrPSADFGJGnEprNZrWO2dLEXQ75jdnzZdL5nksTjN7A9CbguzM+j0WOa03jdCd
 b1jGPSldcwxPhqTixXd1g/dEW5HczUT0wEJoSj47BTFUJO1sNmzZkInAQ==
X-Received: by 2002:a05:6830:2b29:b0:7dc:cba3:e8f2 with SMTP id
 46e09a7af769-7de98932736mr22612a34.19.1777310976431; 
 Mon, 27 Apr 2026 10:29:36 -0700 (PDT)
Received: from
 runnervmeorf1.0w0tfn3qdpzejc0fgepyjequzf.gx.internal.cloudapp.net
 ([20.29.29.22]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de9866b88csm34125a34.15.2026.04.27.10.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:29:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Mon, 27 Apr 2026 17:29:35 +0000
Message-ID: <20260427172935.3996-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427171734.621893-1-pavrampu@linux.ibm.com>
References: <20260427171734.621893-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcontrol04: Fix test failure by keeping pagecache
 children alive
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

On Mon, 27 Apr 2026, Pavithra wrote:
> memcontrol04: Fix test failure by keeping pagecache children alive

> Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>, Pavithra <pavrampu@linux.ibm.com>

Each contributor must have their own Signed-off-by line:

  Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
  Signed-off-by: Pavithra <pavrampu@linux.ibm.com>

This is a bug fix; please add a Fixes: tag pointing to the commit that
introduced the broken behaviour.

> +	for (i = ARRAY_SIZE(leaf_cg); i > 0; i--) {
> +		if (!leaf_cg[i - 1])
> +			continue;
> +
> +		TST_CHECKPOINT_WAKE2(TEST_DONE,
> +				     ARRAY_SIZE(leaf_cg) - 1);
> +		tst_reap_children();
> +		break;
> +	}

ARRAY_SIZE(leaf_cg) - 1 = 3 assumes all three pagecache children were
created. If cleanup() is invoked during partial setup, TST_CHECKPOINT_WAKE2
will time out waiting for missing processes and emit a spurious TBROK.
Track the number of children actually spawned and wake only that many.

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
