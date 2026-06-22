Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090A6CDB46B
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 09:44:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ADE53E54ED
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 11:44:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 315193E53B0
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 11:44:38 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C152110006D5
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 11:44:37 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-139a5f4ca15so2655290c88.1
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782121476; x=1782726276; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIhP8imA/RRrxd3cJhr7Ijes/AfmnbmZHsyzKMmUzbw=;
 b=F5Nq4e2hESP+ZmMclWl/FXk6mWaEhs+gmuzk2r4mZbt45hsjk01PbVfvMSDncHQW67
 wbWAidhSSgzEcxVoWyaSjDQIMCptq7VqWxo73b3YyFXl0xIZS5J2JrSVZD65HHNLmYa1
 sfcjXcKAEFNQLLLkfrbirfmvfKp6VgAVj3XGr2h3ZAGXLMMI5vEZl8v2zOcPgX+dEST+
 pYxFcbgWoHhm1Bh5u76ls+Ggtw1GMxlz2mcjgzgnSbehKDwnKDM8sndEEK1l76iq8QiZ
 ClLnmxL5h+flMyA6i0XsaR5V76PgA0m4FuI+8Bi2aDcXJht7zOqV6IUYFd1Nbuhnx8/H
 MBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782121476; x=1782726276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LIhP8imA/RRrxd3cJhr7Ijes/AfmnbmZHsyzKMmUzbw=;
 b=d2Z3ScWfCLpvvPll42rUrIz5F6Nvr1Qg2cLFHBVGbtSk7Jy2fiXbwxjanL3vM+lpQJ
 bZqhN0nrp2UHP9qaEZN6FjLoxHf7ubNrEgdeXHBTR9YL9NnhjbZ6ko8akhDlomK8U6oo
 Nt/EMSHobHTcF5XYy40bJXKjcWwpXPzdKeB5cmpqhf5uyguQRoGD9RJuZz0qD20Cmodu
 todfvZ7Jq/XNcreeFfsEcNQXdXs1ZoloByu7QJMK1HvWAIDMlhnFE0qFN88gqbJXF7iv
 Mko37lr4+5Mqna8b3wW8IZwSLP2KPHonHgPys9+PalJEJ3eR24juNKnYq4mXfz9z4MfM
 EhZA==
X-Gm-Message-State: AOJu0Yx4Js0cBF2729SsGZZIgxb3fYmKzunf+bFVVAGBnEgyCwtKePA6
 PvrAkFnnxsgblBGGg9Tf7rwyHns+z0trNBslohJWndYaHdtx/pF/cJcA
X-Gm-Gg: AfdE7clT7TlVtnyBm+oE18beSbkiY1CnqLwmz2oQV4G+L8J8LAhnJQBillU+RzP66av
 9G33neJ/sY1yzsb80pQaxR9XCcF89nGGXS7C/84rI6b68EzCMMexWKzHj12ygmen+H1wmBcnM5Y
 DfT/TB2Umars5rN9dIRO8/7JRWIeZBVXTsVJRcOZSfkdTi2FxhqkElw0VYkZdKJ7NjS7FH4+6dD
 d3zUMNws4aG46DcDFmWCamj0PsJfNzIYndVcCjq5ZvvZe5lRx+HjVLIjYZ9xH0oilUtChf2KVjJ
 2Eccl3+aMYft2ppoA7f75oLVeu/I9OK0koYhSA0hDwqGVIpXbWyNIq3Itj8Lj5etnhA+AQzLCbB
 3eeh6IJDKckA5XUHjcQ99VUhncgIRWmY6/xMAt5xOVuQUz75K/6Q19UiQVIVX8K2ScBGZdPI1IW
 G+P0miI7RmQlSf6Q/9/tsYIcF2h1b5j6Llk3jHllkacFg2JpB7UPGo8GuYbnyylpm4R5gh68RCA
 lbzaD2wx/EQbv5s0JLniGpqO0FOiA==
X-Received: by 2002:a05:7022:2593:b0:137:4061:8cc2 with SMTP id
 a92af1059eb24-139a369143bmr6849997c88.35.1782121475996; 
 Mon, 22 Jun 2026 02:44:35 -0700 (PDT)
Received: from
 runnervm7b5n9.d1tc3kjhwwxe1ofz5cvxophb0g.dx.internal.cloudapp.net
 ([172.185.47.217]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adca1b00sm7036128c88.2.2026.06.22.02.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 02:44:35 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Mon, 22 Jun 2026 09:44:34 +0000
Message-ID: <20260622094434.4103-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621150951.66407-2-mmenashe@redhat.com>
References: <20260621150951.66407-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wake05: Add EFAULT error coverage test
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

Hi Michael,

On Sun, 21 Jun 2026 18:09:50 +0300, Michael Menasherov wrote:
> futex_wake05: Add EFAULT error coverage test

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
