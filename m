Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABA7C19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 15:25:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7AB83C953D
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 17:25:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13F3B3C0211
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 17:24:58 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 537B81400DC8
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 17:24:57 +0200 (CEST)
Received: by mail-vs1-xe35.google.com with SMTP id s129so18571652vsb.11
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=QCyHCQqJjXQZIQNjHGqLv+v0Q64M8Rr/d4gsNXrFgRM=;
 b=ZJKsvv/h8RdSCfIvlO9SX3kGhLlDEnLE/aWCd7Jy7bYkvvnBtXQB4CmWbUXM/pFxlr
 5liHFh9P2E9ahaOuwu1qquI9aifoxdz2DVIkx03MJbYbHiZ8bQOWdtRZ3M5LQEOQ0LMp
 GhD0VUqEzceyXNJhmfTIoGR7XXuji21XhwQK9xcZqrF+k73M/up0jHVCrOCUcP79tP8t
 52kDzQmLcmZjEpohOHIeuk0OmsuJQxqJHMDN7T6fNDx2GI1zGzBTwLK+VG3LVKlbu6Lt
 Tsz3icZYE8O+H4HFyOQThlUeosqAX9uFzpA5HOEM4/w3ui1gUXqzDvY8jmMcXK3dolgZ
 0BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=QCyHCQqJjXQZIQNjHGqLv+v0Q64M8Rr/d4gsNXrFgRM=;
 b=kDuOeR9gZsYr/7gTcOYUxP6ukXAfqDbLBxCzIBYzYSemvHx31BMpn7a4EQ43+8hWgF
 ZIBWLHzskXo7zXTLGpguu+ffnfYDBK8oPpPa9I/aBQaz7jCm8Dw3hHBz5OrL+fvVfkOR
 t8Qe5rcd73TZMxkijX1CEZHjPRSvEW3ASBA+oVFDPJwyky7ysLKkMkOYVAwbMpY5rSgp
 DDCRSv/PEAS+mKeKJjrgHRhpf4MFJ+jfSacjntS2nYpc/JXjMT0xgLj0XCn1t7Xa6RZ4
 +bbMJ6wCsbmwTnqeIeWAvVXruFh7ZsY0Gg67MVrk2ik+kV6J3kORSHQg6usc0rnlaNZf
 3qtw==
X-Gm-Message-State: ACgBeo0eV5tRzx7BVs8lEcRLQv+401sX98Hqga3nT1WM6bPgcL/n6cDk
 X+AqjyQf4xJXt8/UQYR3wj1vqzWPG6sOCBwejjDJsQ==
X-Google-Smtp-Source: AA6agR6K/OQ36tEu6ZvmLUqiR7x2s8+kEjYJQx81MHVTPXTUzxp0mQGdX4A28etwEhC2nYNpdDn6PsvIEaAdeQCnwxg=
X-Received: by 2002:a05:6102:212e:b0:388:90da:601e with SMTP id
 f14-20020a056102212e00b0038890da601emr12008486vsg.24.1660231496113; Thu, 11
 Aug 2022 08:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220712173921.2623135-1-edliaw@google.com> <YtaFddMFjVPMTpme@rei>
 <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
In-Reply-To: <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
Date: Thu, 11 Aug 2022 08:24:45 -0700
Message-ID: <CAG4es9XhZ7ksvLxwRNO73FC4DQc7KteUQAUPwipbks6kGsvFmw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > It looks to me like the compiler actually forgets about the volatility
> > of D for some reason and then assumes that the loop does LOOPS
> > iterations.

Hey Cyril,
I think I finally understand what you mean by this now; it is rather
strange that the volatility of D does not protect loop from being
optimized away by the compiler.  I don't have a good explanation as to
why it's happening but I'm not sure how to evaluate what's going on
either.  Should I do anything to move this patch forward?

Thanks,
Edward

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
