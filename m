Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57062CD4F49
	for <ltp@archiver.kernel.org>; Mon, 18 May 2026 08:18:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEEEA3C59DA
	for <ltp@archiver.kernel.org>; Mon, 18 May 2026 10:18:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BC603C0926
 for <ltp@lists.linux.it>; Mon, 18 May 2026 10:17:59 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1B1156002DD
 for <ltp@lists.linux.it>; Mon, 18 May 2026 10:17:59 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso1195654eec.0
 for <ltp@lists.linux.it>; Mon, 18 May 2026 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779092277; x=1779697077; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwrgUZmQ8tRhBmpomIOC6iiGP7YayqtDtQK3Rh6IUas=;
 b=AF0Jend3//eE/671Sdv8GQoq4KkzwkoO1mWUcXyedtAO5BZ+CzdV3Hz0H7UM6f6p16
 QA1uhJfnas9mh7cOUTBwc5kFGRR+zL3/65jxqKExD7i/8qbmsB/YeypMjoseY/RltLys
 d5kpyQBGC9oQDnRzzsbwODz0vat0Nb7eJxIyC7BfLybhuDueZk0kr0fQMsYbzYosK8vp
 8oJ1TZT7YRe8hnC659kwcxkyohkvhfZJsya2ccE0WMAAl2PmRgdi8LtZs6jZ3Bzn4OHJ
 hbt/ZrvHoJQelbXhMmcNJlg0Ppepsb/V3bFZUBsi0Y2kmfyfRL/qL2hx9ucK/FJjv+jU
 ooXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779092277; x=1779697077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KwrgUZmQ8tRhBmpomIOC6iiGP7YayqtDtQK3Rh6IUas=;
 b=K+caUaCrJbkS8KKWTW1yLMf7SNXX5URzExxIpdPiSRKQScUs3pxbXSH+4rCP9POh7/
 7lXmpSTW7Ji4w0eRVoFxs1qUFrwMgF9orUfT7R/GcwyhZAtk++vK6HB/9aoRTj7HhG3U
 XqgtA8OYO5mACXg+shIK3xpPgP77fzj9J4CLsleuUvq0WYmIaMxsHlM2WBZ/IBh4bDKG
 7NBFxdbIiL4X7LVLP0hYQGgLgR7lBWd1M/J7q+LdbegKiV67JL2hlahsogIERb8iZLm2
 9u50oBL0vEmcpFNpfxnS/on7z5CJpniUCKCsIpTsIAXOk7Y9sPQMr5K+7RU2FJNQ/cpR
 BswQ==
X-Gm-Message-State: AOJu0YxiQt1+6AeWlaS+TJ7t8Z2M3VDR3LKeIVubjkRHhKdM7mcoQUmv
 bmFwyfwullQwy4hk2+0d0cLPdbqEg8Fo92+f1L36RRuf12v9w/8wMaWjjeCuif59h8s=
X-Gm-Gg: Acq92OECqF1mAqkxt4PBn9ERqXNEhOz1eXxFcIgyoRG+lka/noxLpu3SBESS+PvEjZB
 sT25+H4VKM4M7zZL6s0Tcrna1RKwUWnR9AjvpH+lEl8nPr3CjJCXd2OaOVWW3GU8xXnIhMDw9Z3
 QPJV6RD3InbmMYYqSWolYEpAamk+RpcR9v+uY+7efP0ZJzAuXUpmAQj+yGp3Yh+ZVeXHJkyfVG8
 ETSyptEHDYk5HxrQ1ga+56lN461FYgDQvjGppDN90VdDpIlI+VXJRy3xwyJ03ZF39I2QuFE/FlV
 va+F+PQvsXEKLflMg68Tc3wQj64lckO/DpCuKiTEnjeOIkYElhdyIP7PhCDLEiLvJ9T/5StoQcS
 EJt52ZvJG0SBZIOt4/ucllevqPAt6OekjkFM4zo4qijt8WxHphkeS5nGKFwyv8QaU4BkH+f6tly
 lsxc/3T/+apdda0FnNmrHv5RPy7s2hOjo1xEvQz44fc+sB3tGB2SMGJtxCIhVyKXDuPVUH5DWa0
 p3OhGTQPqg2BlC9r+OMne5lpv5hz2VmPCDKeT5VXR/yD67f4w==
X-Received: by 2002:a05:7300:a888:b0:2f0:ee2:f6c6 with SMTP id
 5a478bee46e88-30262b43a2bmr6839380eec.19.1779092277272; 
 Mon, 18 May 2026 01:17:57 -0700 (PDT)
Received: from
 runnervmrw5os.v5e4emb4g0fe1gtqiypbmk00ec.dx.internal.cloudapp.net
 ([13.83.107.134]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30297bbc9a3sm13185539eec.31.2026.05.18.01.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 01:17:57 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 18 May 2026 08:17:55 +0000
Message-ID: <20260518081755.3725-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518-fragnesia-variant-v1-1-45b9df38cc78@suse.com>
References: <20260518-fragnesia-variant-v1-1-45b9df38cc78@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sockets/xfrm03: Add skb_segment SKBFL_SHARED_FRAG
 stripping test
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

On Mon, 18 May 2026 09:27:53 +0200, Andrea Cervesato wrote:
> sockets/xfrm03: Add skb_segment SKBFL_SHARED_FRAG stripping test

> +	/* Let the espintcp strparser process buffered ESP data */
> +	usleep(30000);

Sleep-based synchronisation is not allowed (G2). Replace with a
polling loop on the accepted socket or TST_CHECKPOINT_WAIT between
the child sender and the parent receiver.

[...]

> +		/*
> +		 * Splice pipe into TCP socket. On the forwarding
> +		 * path, skb_segment() may strip SKBFL_SHARED_FRAG,
> +		 * allowing in-place ESP decrypt on page cache pages.
> +		 * May fail on patched kernels.
> +		 */
> +		splice(pipefd[0], NULL, cli_fd, NULL, DATA_SIZE, 0);

SAFE_SPLICE is available in lapi/splice.h and is already used
earlier in this file. Since failure is intentionally ignored on
patched kernels, wrap with TEST() so the result is recorded without
aborting and the SAFE_* rule is satisfied.

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
