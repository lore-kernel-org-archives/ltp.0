Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EBDF531C0
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 18:05:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED1AC3E5E24
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 20:05:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C66133DCBE9
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 20:04:58 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 132571A00165
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 20:04:57 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8dfb9139008so156406085a.1
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776103496; x=1776708296; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Bxnx1YR1xU6t2aXVQg7wa3aVQ3VNRjEQsXKpE6v2nM=;
 b=QAnilP/DoorH12WXj103asOIQMAS4bix2wc/hDlQOwDB2H6EnpRZH788yGs1eX5jZw
 F2cvYHC0oUHG3lvfiNZSYT1Dew9oXzu/8xElKD8C3cCjcNFc7JYCkQKY7VDWsZML19Sx
 LguAhhqumJDxGzSwtRBFwfNqSbZUOR0Gxgsms07GIlzSNrebjY69GW9t5lzrhaJAgGvB
 fJnOjdJyBgC8pEFN5UplQaGNOjuWveED/z0ur/gUMg0ENsBLHSQaacxk7vAMu06O7Mvo
 3VdV8LD6IJcce0U+f36Bv3iBZr76zUiZv8YzfzswIpxL5NlyzrksE+HlIhbjpKYqTb3l
 3MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776103496; x=1776708296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Bxnx1YR1xU6t2aXVQg7wa3aVQ3VNRjEQsXKpE6v2nM=;
 b=JoD/+mtKbx+Rzq6sBFmbhIsoDbPQzATTiItHjgJrKdEjj3PNk6VaSCuT5EjsdEKOTJ
 4iEfDTZ342MJJns7cJWA486wyA0kg7tgf3ttpZ6mRK0ANwyViQvfXTrVCVS2PjsXIJ65
 WGL0+hZSczFgWqj78Uy/47V1D//R66ktab2zqeKqWNzB4aH3bQ8djmvKN+b2tfVqw2v0
 GCBeMtZ3pozhEGygAx651Hq8sGJuXVMi0n4zahNmPT0xw6vY5xUfQcosTUxatYmB6bZT
 pgpZ+T9NnT4ut2ZvQpNbdsbai8fHd9VXzJRy+lQXXzEnqNeekJfwt+QvOems70JkGmn8
 xDxw==
X-Gm-Message-State: AOJu0YzYP7+oxrh9QdiwavM4j0AfXZso9qHbPyKvLtm31QjLIg40Eb52
 itRjksOlyig/rPixVcHTMFLe56fDJJkqebmwfFzmtQP7ZgOezWPPEYST
X-Gm-Gg: AeBDieu971RAc2g+ct9PKqZTz3s9cjx/l07A5jy0V0M8bOycAqhB57bR41RRjX1RLpx
 SZPmLaHnbcdyyq/WxIlyJizp6eqocyxZFv39pm8VQyjNa6KHZN/Lv8wxQkvKWL+6C+yNZ+EroPg
 XJ5xADfyA1RqHY+74hI01bRKFh9rjZ/9OjETv0O1ECTjFNgBeAM//JQkB80BbZjIeYQN9frN6Bg
 XaGDrbC7d58u6wQaoKWiPP0x//fx/WIgoRXKpnDctw30alKEtl7Gq7sFYf1CKBdZQtqGWVwn6wH
 w17AtETdSSwjwDG8EqW8GFmyEOPEEbL3TU9ZFBdmh6RPtQuPrWZPrk15HDQPcn+7ufDu/DMHpC3
 r9lwqLrKzJMRg0uTNRvI0L8hwPe/3h95gDoqyaHcbsEia1OEFSJh+OTozKRIVBXUalBeea6DvNa
 szGzlYIWVy4qIx+cAV0mjUKEftqo+BA4bssJi0DMI11W7q+QTHsgD0r4CoSCYD8hoC5FMtn/74q
 PgOUMHj5L2DVY1h5EW43iimbFoxRk4RJg==
X-Received: by 2002:a05:620a:4606:b0:8cf:dceb:827e with SMTP id
 af79cd13be357-8ddd02a2067mr1962672185a.52.1776103495535; 
 Mon, 13 Apr 2026 11:04:55 -0700 (PDT)
Received: from
 runnervm35a4x.ifytnyyjtqiufk1iw4ikp3oyca.bx.internal.cloudapp.net
 ([52.150.28.33]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8acb508807fsm20981246d6.48.2026.04.13.11.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:04:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Mon, 13 Apr 2026 18:04:54 +0000
Message-ID: <20260413180454.3850-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413165457.1349-1-always.starving0@gmail.com>
References: <20260413165457.1349-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] close: add test for double close EBADF
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

Hi Jinseok,

our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

On Tue, 14 Apr 2026, Jinseok Kim wrote:
> close: add test for double close EBADF

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
