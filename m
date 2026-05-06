Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B86CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778088758; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ROwSrjpn3LR/o5rcvC7KEeMEcu8gFgs772GFH92Qz/I=;
 b=JKf9u60HWL13JuUzQyxupXToAhssVFXkBA2hYrIKtZ2yVMhsk361yIC+jLxF+fSpIs9Rz
 61QozlcK2mMejTWt7eF7AheRpINoAcBLzLPHoGfkZpA8+KNWzE+ZmUz3Gkl3WW1qc15ephf
 tBroJUefLCKX3bpqkRGLrn2S41CbqSM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CDC43E6A96
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 19:32:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68B763E28A2
 for <ltp@lists.linux.it>; Wed,  6 May 2026 19:32:15 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E792B1A0098E
 for <ltp@lists.linux.it>; Wed,  6 May 2026 19:32:14 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso60216905e9.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778088734; x=1778693534; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SmGKPF3XDG1C/Skz6XYgECE0uLNeTI2Nsn+5ODhqBdI=;
 b=QiXaZQX2XJdOQHZUz/ULacMzkiDWZd3eWgQx0vQ/ijUWAePV6KUhFbG+urjdlwscAU
 D6g5fbvfPTacs/NbPqf5e6d0ljhrBDZeSpvxeCGd/5If323GMfdcAuuDokAQ9z6YIzAp
 rRmIhdN6PJZsqr7sDC/S7l6RMSFq6NXZraev2AjFMGNEpYkOLuwKUhmgf6+ai5MyXnh0
 EGdgpIhD8/wefFJRxl2s2tLWLaglqRWBVeEJxZY3yn3N8o79CPyoFmDFuzKUR5Xvbz/u
 BUzaGiH03hXkVNR3Z8kocefWvyEiVOY0+OKwg0QF7PgyfStAAsZCS6fD93qG0qGu+0N1
 dZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778088734; x=1778693534;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SmGKPF3XDG1C/Skz6XYgECE0uLNeTI2Nsn+5ODhqBdI=;
 b=D0yJIgQxbS/L+wUxQymimXZa/4i3pzP4dMQr5OYTk6Hr3J1K1DcRoPOAGPbFncJcMc
 U96Fc867fvkmMpEfWoDNdxGtxzQO18LdzqNu3kXImIah2DM3HJiZJklHURdb4PlYS7IL
 poSWXcayxgjVSnbfM9mBIDWrf8ntcrS9vX7uBsqNG+jBDxbaATo4k1x4cKcy2tPMfWf6
 k2xA4bBIszkKXx5oivkyALUbw7Sjh9RIB6tQsAixssKQ4hz9q8/VvIzUatHoNRftfmvX
 kV3MJK0pZdDROm9EuG7LLlrfTM52N9IRdMxgL7D1UBaCtfMPZdMIfuiIgHam78cwZ1TU
 i1dQ==
X-Gm-Message-State: AOJu0Yyb9aN6J6NljP/JTDtB7iqsxFPAJQHmvCSH7zSRGfhkO9Xghqz0
 Y7u+1g9Za+tZltppbonJIcuuu51c5VEtUejxGHZnVAMM77n87AKr4NCUWDkO9Pfxyq0=
X-Gm-Gg: AeBDiety8j3QuN+hGS3NCXzoSZNA6O1ieZCg0wKdbXD4vFSsJtlQQ7ytXdd0UoRa448
 bBwgfbG2dyl4bgPO3H1+n8rcv4pCKiLp9gXFHRJwdTHoD96IwMnjbK6oifUnRiwYUwlGYLYSoNz
 qwUoWE5D33johmF8h0C6Hytv26oJUSVkzRVVfWcGzWLWtHybXjPUWTuN+Vywpv1PPM3Sq5IqGiX
 v65vLAsq0TTu/ZWxfNzKUsctzem0dEqMrB/pVuQnKPOypyDI4YrIFhVbp395demIPlo07TeevoP
 L0z2yoeZqXR50pAMRw54e6iD8+gfgwWqavN1iADfr6Wcyy/ie0egBUQ7g3YU2/oLFKQhLbWxWsR
 KiDb0mUNZ+CzbMpfz8GFFCADWZbalGg1oJv0LFa2KWHAILFMu/8st7BYmLA2pA5FCPI9XDaFrf0
 jMQ1QjRBYVO+LW20usZN/85JVrrWfUcuYHPl3hWw5MV8X+spuowFmFAf4SJST7TVjSFz1N11TMC
 XH5+48n/mqCCV1xpxmOeNcvKBjtQLtfyOXj2qbfyQyFKA==
X-Received: by 2002:a05:600d:6:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-48e51f1d04bmr55901255e9.12.1778088734296; 
 Wed, 06 May 2026 10:32:14 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53891d62sm101966805e9.1.2026.05.06.10.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:32:14 -0700 (PDT)
Message-ID: <69fb7b1e.050a0220.3c60d8.cac3@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260329113252.204926-1-pavrampu@linux.ibm.com>
Date: Wed, 06 May 2026 17:32:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix memcontrol02 test failure on powerpc.
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

> memcontrol02 test is failing on PowerPC with 50MB allocation. Increase to
> 100MB for both anonymous and page cache tests, and bump minimum
> device size from 300MB to 400MB accordingly.

can you please explain better what's the real issue? We need
a technical explaination of why this test is failing in PPC.

> 
> Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
> ---
>  testcases/kernel/controllers/memcg/memcontrol02.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
> index 0b79403c9..fcce82d68 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol02.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol02.c
> @@ -32,9 +32,9 @@ static struct tst_cg_group *cg_child;
>  static int fd;
>  static int file_to_all_error = 10;
>  
> -static void alloc_anon_50M_check(void)
> +static void alloc_anon_100M_check(void)

Also this function name is quite wrong. We are exposing internal
function implementation in the name itself. This needs to be
fixed with a name that is not exposing the quantity of MB we are
actually allocating, since it may change in the future.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
