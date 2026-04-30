Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95213CD13DA
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 19:29:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38ECF3E6CA4
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 21:29:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 840703C537D
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 21:29:19 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 367B5140127D
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 21:29:19 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso1948187eec.0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777577357; x=1778182157; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocu8P8dL/RVKV7bZmQBonFuxH0GYeTg0qnGstwYfWlA=;
 b=VKz4UZTFbAKrEH31Pvz/sNCeKuomgZKwYNN+LOjlCAXnI2WXCEWeOX6ekzCchivx8d
 FkzlCB+SjIPV7XYhzgeTYdXXPIpIbKlOn4jo2NVY7PLg0Uk6/DRmlvPw6N5XoTZ50hx1
 1ofEAGhLaA2KzUYkbOQ9wzrE7V6ylwnMmZSNcFu0hEfRQOvxiLJZzSjk0wWhuwiz3U2a
 nKQRIh5ulJusvvxFoaz426KQIiIVdelK5p70OCJsUke2AXolNiYcL9HPtiQ2DAz3xiMM
 NvUvdDNtmqWtRSwU+JB1ZURbQ8laTOagbgsyNDxKJhnQ4cLYWc7JIgeFZ62DL0De5kYt
 oTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777577357; x=1778182157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ocu8P8dL/RVKV7bZmQBonFuxH0GYeTg0qnGstwYfWlA=;
 b=AgAVhmDrvdUSNQMUTTnYi6GH3vlQJrqx6gH1Bfp+FEYuIEEKlti1aTnKHuXZ/p+loG
 1UOC7hf3hhPGwy8bsf1KhoLksOMDlYQl1X8vRbALhFHYKZ2Q4L/P9JG96NGoxyj5k7E1
 XI4hdNUrWHggx6kR0pklFNAgYBpBlfalE1P18gW/uRmZD2+G/01u1nw5YHO0CCPSbsFX
 7jXJbqdJxnORENS/mxh644lLkq8/1ke3l+HT6EqnLfU3mf8E2I/j1bOujrD2/cEhHK06
 b9OlVYVIjHFmuuORuhroK534cEz5e2A++Z/KmFZqaBlU3HWEPGcPbVSEgl98THkFTGpl
 JeOQ==
X-Gm-Message-State: AOJu0Yyuo+gLy+ESy2iwHGI/XTRikI+hTWu8rsUSN5PZRlXoE9c64zt3
 7tRYf9h6vtQaUSDUrt6ec9LfU4VGHlbw4GjA9sMGYpjvdwOCDMqRIYK8shzKlxPtVzk=
X-Gm-Gg: AeBDiesbhUG3n+AY2gCjgg19KlGlXkbeQICfeiH78DzL2ypATLh1DPYllJj+8eLwyXM
 XlyuDTOo3Z5FTJOSpKC0H0wntlBO22vPTljiKLomI+OkffW9pK2xW6d7uPUT8dfX8HpfuQ8MRwk
 oIM+0B/utOIxRXl8j0qyighzriB2rHecYev1rud39Ip4SiG4HmJkba9Fw5wJq2K/w5k1jp4ngEh
 C5Fbb5RVWOKN2PUteHw1YjJQFjbvBKxC12ICp1aUKUE/8Zw0mvrr1ZcGRrvKMwRXHgGompwHX8n
 a8OzRMEXyobaBJNutXkTE8wLwvGmQcr7pStAq/cYFhPtm4RHuEVSUpNExNPNKbqEjWQb035XOvN
 YxLHIgUwZoSL8QkovIFue1RxmkQo15GF0sOx7fYovDnxf9AoFys/r5cQElV1bDr/Srkz1XtY9PE
 /vXayZgmlA1eSYpaGnoCoy73XjaSQnV98gYfEFQmJ9NViLzlvcZ6wpiVv/ghBm7aby7YAWgoLvI
 yJimgP4VxNLGHBfp1BipHFW/KAXx7KOTC+8bJmJ62qIUv9Oz+oML0VfrtzOaw==
X-Received: by 2002:a05:7301:1902:b0:2ed:935:aa33 with SMTP id
 5a478bee46e88-2ed3ced0c14mr2187934eec.5.1777577357529; 
 Thu, 30 Apr 2026 12:29:17 -0700 (PDT)
Received: from
 runnervmeorf1.ija3qfjodr3uxooaf1kcwah5nc.dx.internal.cloudapp.net
 ([172.185.46.215]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d657sm1261791eec.4.2026.04.30.12.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:29:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Apr 2026 19:29:15 +0000
Message-ID: <20260430192915.3858-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-safe_splice-v1-1-d1d919ff2a3a@suse.com>
References: <20260430-safe_splice-v1-1-d1d919ff2a3a@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add SAFE_SPLICE() macro
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

Hi Andrea,

On Thu, 30 Apr 2026, Andrea Cervesato wrote:
> lib: Add SAFE_SPLICE() macro
> tee01, vmsplice01, af_alg08: Use SAFE_SPLICE()

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

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
