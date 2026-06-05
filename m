Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7BFCD6E74
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 05:20:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC7C33E274C
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 07:20:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A7523CE442
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 07:20:24 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8505C2009E9
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 07:20:24 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-5177b9a02bdso23669831cf.1
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 22:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780636823; x=1781241623; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQsAYQXUissR7NNXe6h5t/2blmj8g5ziJCo2YPOHwsc=;
 b=KICuqqp4LR6q0jOw3E58mu3VJFW+w4WvGc/8HQk6VW+1V8QMSaJoFAsX4fWdwQquqP
 rBFuqZoAEaE45CmiFx/EEZf6MIYRlaBPzp5uWPcRqOY8ENQtbA7b6ygRsrQ1R4fnSSVq
 qg8/lneaTw3iaqJ9BKJNoim5cMj9oC1prw9+axY2xRLqI7i/SrUNM23u0LyBkDS1NH1x
 gK9IqS7D3m6MyGv93p8wW254SstCRN5Y1wcrUGD9l8R08vMcdvVIczX39191NDHIk8kh
 vS7oVoDXhEGM56R+4idzbblpkpH4g3w83tWFpy63Op7TeP2lDaqU92pPx7eQM2eCBIwu
 h6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780636823; x=1781241623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IQsAYQXUissR7NNXe6h5t/2blmj8g5ziJCo2YPOHwsc=;
 b=cw02YaxniOUi+oBOvydNlh66g5gG3x8GAOp3bq6OUq4hSa22G2g55nWnqoEWB0oBY7
 Q4uzOiGSz839kOK7BuxXS5hpvhIv7OQesx1YcJoLlcR5MqlibmRQaCOmEnAL3nxlu0nr
 741oO3GNWCeYDJdK16aepSjT97OPIiApyI5iXwLOD3CwfH6ypMm9tt83vrd5xkSRT1PI
 JwXD/sGgCuF6B8ucoNGqvS9SVvHlWMByi+rtlMpG/oNPJVIaLZpFoLPPIrWw/za3uZG7
 haE0c+yXrfh5RrNHwGWeUUMLdOAhZobHyRnibpC1V6qBWe2MNRTtsDsbajPngC9CxrdA
 fvKA==
X-Gm-Message-State: AOJu0Yzn6TPX2dC3BeabX32tS1ngDv03I38c+qtMIOIIhcJWN/aJjaSj
 OrexDjya5eTfTEwVEx0991UQZHRQF6af/n6LAwqprvUxDnxUffBICBzk
X-Gm-Gg: Acq92OHLHnxi9rfxNdFuz7DD31QEoZgkndfBfJIfjaFiXAj5r8FztpeLfhalBuLLw/v
 kXkj9Pz451tW+GqtOCdnDhf43YpcGVv3E/xjKn+Zm2Z0SZe/cK7gaKJPJIWl7PqIdHA7+QK7/3l
 Wl2SJPheluB6bt9l6CNGJf01wm2ELTmgt8jzgTtDYFK7GOgy3a0VCMYcjiRS/Fogtclll84sX/r
 xkOk/bFZ+ZOdPKcSNh7udSJlx7VXzeXiv7qFO0YcyfDMaoVXEOibpMr5+6rXzRP9n/uzlT7LOU1
 WBqTFMFSpckZ9QfU0wGeWykVOWaA8fB+F85t7cmyuRKFv/bLvjCswEtmQqxPLKTkpCaNrbvKL/H
 AsImDMBwEB1oUKUPKW+Sx6ekVTnHqZe1L2WMkDmhTY8L+9yaA1HGWGeHmrnReQi1hfclsQ3ixBw
 6sb7y5nTzVV+BVWytQJHUHuZRXaVWBnQSurgfGZtXHKvYhLJz7Aqt8yxW2kQoaS9LFiAIcdxZ/F
 PAT3L1KELzqtpCryzvZGpirLFfEscQhKdxXaPSgiZ9/S8YV
X-Received: by 2002:a05:622a:1e9a:b0:516:d4b1:48e8 with SMTP id
 d75a77b69052e-51795b4ebb0mr30680951cf.4.1780636823206; 
 Thu, 04 Jun 2026 22:20:23 -0700 (PDT)
Received: from
 runnervm3jyl0.5h22ydpj3h3ejlrfk43sdsvwae.cx.internal.cloudapp.net
 ([20.55.222.83]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c07f0dsm70708951cf.3.2026.06.04.22.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 22:20:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: yeziwen1989@yeah.net
Date: Fri,  5 Jun 2026 05:20:22 +0000
Message-ID: <20260605052022.3971-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605031919.5946-1-yeziwen1989@yeah.net>
References: <20260605031919.5946-1-yeziwen1989@yeah.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] execve05: add exit call when execve failed
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

Hi Yeguojin,

On Fri, 5 Jun 2026 11:19:19 +0800, Yeguojin wrote:
> execve05: add exit call when execve failed

> +	exit(EXIT_FAILURE);

After tst_res(TFAIL | TTERRNO, ...) the result is already recorded by
the framework. The child's exit code is used only to detect crashes or
unexpected termination.

Once verify_execve() returns, the framework calls tst_reap_children(),
which invokes check_child_status(). That function does:

  if (WEXITSTATUS(status))
      tst_brk(TBROK, "Invalid child (%i) exit value %i", ...);

So exit(EXIT_FAILURE) will produce a spurious TBROK on top of the
already-reported TFAIL. The convention in LTP is to call exit(0) after
reporting a result through tst_res() in a child process.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
