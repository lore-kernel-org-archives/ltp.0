Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A57C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 14:32:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 047793E4AB3
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 16:32:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AE1C3E2C6F
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 16:32:39 +0200 (CEST)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 040DA1A006E8
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 16:32:39 +0200 (CEST)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-91d4455ff18so17510785a.0
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783348358; x=1783953158; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q1lsdntUkZ00kDHq3+7Olh/QS6E+Ntl16WxwCgyxwpg=;
 b=AfH95umuVAwhQ0y6WX0ruOkE99YqpTINctnV39XM+oyB2HmrIzXufaGCBqLuopydKD
 ISVXrWL1b92mYgW5xWZkJv8hQ3Xg3zV0zaAydAdpzErxJd7g3NqY4EliZiNBTYLHHjkV
 SCzo42GeHZQx9f24eBty/cJ7Vo4cb7fkvVIagpD7RHchbcyw/f17Uc1jV13noKl7XCOo
 iJGyQJzjgHSBkBiise9PUUQ3NI61YNYsiQm5dbfD8/GgP1NVUYrmH5A5NUtKr2VgcdEl
 J9Z4ipIYnVmkhsnrIHgIWQgIy4wVaiYDLcaUeLX1YsfMhyYLmwYmwoFXdN76TT6NJr2C
 CC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783348358; x=1783953158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q1lsdntUkZ00kDHq3+7Olh/QS6E+Ntl16WxwCgyxwpg=;
 b=BZcNXUNYtXJp8AU5uehA3fYOijgGuUbmDVWu/ZHyQCu1Od/y7WzD+qpv9Ew06Ib6bs
 P9F33PyYoMlMBN6rIFpkYb5z4PBBIlC/lyJoOSGp9Tn+6jj45n8GephpQWSAlbOUiAcW
 YabyDC17TZVUIRL+884LML85Q7P3dB8yxVR0UbwUhE5BfsBL6aWD5hwQMsTcafssVRW8
 WPnGlLL/4Lf8ZPR/aM8eU1W1dH4Zf1JojRpc0H75+MT9BvE6F8yKDMnHAZkdWN2sN6Ft
 qzkTAZXD/VmkpOcr4HgObnSRd1r7lcD2kUF3aLlScEHaQGASIm47INC/fB3ht1RlFbfF
 JijA==
X-Gm-Message-State: AOJu0YxYXn8SyGRI71NFt7v8rQfXY8e1J52sBCylxPFFBR11hfqZVPEd
 coD2GFNxmh8/tlAiB2UpT+R0HRqwf/+n+EC1lAPVoqi/1+/W4DTu2mf0
X-Gm-Gg: AfdE7clr4hyqyPh9blKq5wdEwHohhh0brWtlZ/+Y9iAHO8A3LTHE7BffRZuSBjsALZK
 B30U/m3GOapt/rH70f1xDzLDNqcxrVRuqWpQ+Qzt7fIBhMkoLuAnl2Cw5BaBAhGzDRGe5BuOAJU
 aVuuMyiBBkVDLS2DACsyVL2MNvf7mq30LOZKHXdWwgfiD/2Mclc3CV3R8SOYnWs1LBqhORflwtR
 iPVmI22SqhTGM1+W1xo71xKgv1xxV6saBhzCBvk+b2MKRXTx98F8eVPFxMhG2syIRg/xTP9haSm
 /XRU1RopMVSdkDp6IlqlbGTSKXBL6U+r5etrLNPAB3ftfPsbqNNxEeVVLtoLgXRy5KRGTL+faxV
 iz/dnIVNFZlsudaqrsyWT2ZjC1jVAqGPkHHhhMCcmazv4apwiOuh2t/arNwZmsQhAfkSbY1lmAh
 E0Uwb05RbJF1e65xi3IYajPsFtzpv1wlP3QO+bW4J8WItf7dGJiAr1j0OvB2+PzxkMwsrpX5e2t
 EvfFbv4JOXPk+NnzKugOq93qVI=
X-Received: by 2002:a05:620a:6607:b0:92e:5c57:1f1e with SMTP id
 af79cd13be357-92ebb5b7a6bmr109554685a.73.1783348357491; 
 Mon, 06 Jul 2026 07:32:37 -0700 (PDT)
Received: from
 runnervmkkn4f.twwycwkaznxeznykkqsgfknjya.cx.internal.cloudapp.net
 ([9.234.149.83]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ba41fesm967288285a.17.2026.07.06.07.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 07:32:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  6 Jul 2026 14:32:36 +0000
Message-ID: <20260706143236.4092-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706-cve-2026-46331-v1-1-c55d45f022d1@suse.com>
References: <20260706-cve-2026-46331-v1-1-c55d45f022d1@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add pkt_sched.h and pkt_cls.h fallbacks
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

On Mon, 7 Jul 2026 14:56:11 +0200, Andrea Cervesato wrote:
> lapi: Add pkt_sched.h and pkt_cls.h fallbacks

--- [PATCH 2/2] ---

> cve: Add act_pedit page-cache corruption test

> +	if (sendfile(cli_fd, file_fd, &off, DATA_SIZE) < 0)
> +		tst_brk(TBROK | TERRNO, "sendfile() failed");
> +
> +	/*
> +	 * Allow the loopback egress path to finish processing.
> +	 * The pedit action fires synchronously on lo, but give
> +	 * the stack a moment to drain any queued segments.
> +	 */
> +	usleep(100000);
> +
> +	SAFE_CLOSE(cli_fd);
> +	SAFE_CLOSE(acc_fd);

usleep() for synchronization is not allowed (ground rule 2).

The comment itself says the pedit action fires synchronously on lo.
If that is the case, all egress processing is complete by the time
sendfile() returns, and the sleep buys nothing.

If TCP produces multiple segments and there is a concern that not all
of them have passed through the egress filter by the time the readback
runs, the deterministic fix is to drain acc_fd before closing the
sockets:

    char sink[DATA_SIZE];
    SAFE_READ(1, acc_fd, sink, sizeof(sink));

That read blocks until all DATA_SIZE bytes have been received,
guaranteeing the full egress path -- including every pedit action --
has completed before the page-cache comparison.

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
