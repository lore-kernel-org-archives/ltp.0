Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB735F8D76E
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 19:16:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B3F03E9581
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 21:16:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C92143E7572
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 21:16:26 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1FE1E200104
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 21:16:26 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2e221a71e19so877040eec.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776366984; x=1776971784; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZGM8O++SPAejKFKn86Qb0ybB/jhodJjikSW4y+GqJw=;
 b=bEYstXDo9P/x45UerLMIGsMjcb2MRA7t4H9IGyJO75lDAdD0ZPzA1KZWtrYDDScHrD
 irWpfhb+nQ66p0vYis4LAufvfcRWVqYAM9xxsXU/EqeebtSRQfOVDZbxo4UMwhHbrAaP
 ofU914vCNUQ+7gfqvVHM91WPl1HY6Fv1EZ4474eXE98BUf/or4k+5xwMwu8mZkDJTQOM
 ulhoP/AjL0zsTRNhyCZq4b4tkXeSqIhGtnRH+3noIDbQeYHjs7yv9EsW5+AX55nNqhxW
 i+cli7nee0CwntnOBAw5vJw7PpllwQ4VrFFdwdi+Sg1Fwi+ihGt22tMo1R/C2Qz3yhSp
 hI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776366984; x=1776971784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SZGM8O++SPAejKFKn86Qb0ybB/jhodJjikSW4y+GqJw=;
 b=V1h8XlFy2CK8jawH34aGXL92pU7CYuM0rNaSUYDzyKxKPZ85gK5UbeC6pse5vVHHIG
 s6ShLaufCaWdPQyng+/ENcWWVKdygkWrBN1kfCbCexNFHcKha9x+Bo2lVO7Qf6up+T6P
 yPvstpByo+eol+Y4UQxyZQ5qKGN7Cna16IOdp585NUP2qXdtmONIQ2QnqQUhrvGtWpAF
 2OIWDJBh9JvXs3eBo2zs1susje4g9dAF7/LwPkhf4xUnQSZYYickbp+AUHQVb8/hJDfB
 fuZj92mhHVN6LiCS+PGJhFN1hffc2LXZPNRyUlgpuW0yS0LrkmYiBRf5IPyj+yyUTbGM
 aO+Q==
X-Gm-Message-State: AOJu0YzponKsV4I+nDyKqtg7pnLKZh79NilTroyAcYmma0V4AufEOAa2
 42j69jy0aAYlroIZIeDWelHDlMrAIjeBW2d9lGUq2AzA88/dsxFXGthQPLteO6hh9ns=
X-Gm-Gg: AeBDievH9QAdRHPwDsuFDAgwFZfmF335YE4Gj4dBkzWb79/Ps1iGqI/H0G0oI4o4oMr
 WQ97Fh24bKr1T336jeYLaF8zSblKGKmvX5Y16mV6HJwgsAK3nFzA9xB931n/gDKYsjUz+kg7kqr
 lPAi00gfZq8n7WEZ9CfChskHOER2T/8zKzEEtkjDU5MeX2+pXbL/sg6dAPtNd54eWu+9gFji1zg
 5fatOKgX6Bk00YnWBDpAULINPQ9JTgC5wzSUNsBdnhAJxLasXvWJMhYAVU9yXdccIDUXkp+5t13
 oWhmtqM0QqBLaBIxMLUw/oVUFa8UPdZD/QLUdmdPnRDZO6+chVqXUS2B0U4nEFEJp+oQZU4iSOS
 HaNLIpiMgVTPmztvwFAzSBAgN3qzuYWkGZMcaJCo6KMuMQrMNLhG/p79fXPvoW1L1o/Lz17F96W
 +Ggik4BiY0GRNkhaV6C/cf8h5+zQ/XWp8CcpsKlkNqyLgn1mc5PlBEg4F8Y+VoaFBhZevcIfhQW
 aIsc+ys4IEHI2iCqc1T3LPZ83XcazhFvll8wN8SFMJbXwerpALEKcDgNUJW3g==
X-Received: by 2002:a05:693c:2c11:b0:2de:cc07:e8b with SMTP id
 5a478bee46e88-2e2e3976919mr328493eec.1.1776366984207; 
 Thu, 16 Apr 2026 12:16:24 -0700 (PDT)
Received: from
 runnervmeorf1.3tloqxlg3smehfoiszllww4vca.dx.internal.cloudapp.net
 ([172.184.210.54]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c605851sm8686883eec.9.2026.04.16.12.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 12:16:23 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Apr 2026 19:16:22 +0000
Message-ID: <20260416191622.3814-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416183500.316638-1-pvorel@suse.cz>
References: <20260416183500.316638-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ci: doc: Remove Ubuntu bionic
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 2026-04-16, Petr Vorel wrote:
> ci: doc: Remove Ubuntu bionic

> -          - container: "ubuntu:bionic"
> -            env:
> -              CC: gcc

> -    * - Ubuntu 18.04 LTS bionic
> -      - 4.15
> -      - 2.27
> -      - 7.3.0
> -      - \-

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24529063514

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
