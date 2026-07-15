Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBE5C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 14:57:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A5903E9336
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 16:57:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3ACF3E5698
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 16:57:33 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9547660092B
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 16:57:33 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8ee27aa897fso26781736d6.1
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784127452; x=1784732252; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nn5r7AeNk4cWuqHl5SVfa1nBNDl6OHL27ndYTuwuqkc=;
 b=gutUDwOLXVeprn2Ab9PkvwJZoApW3YBjeTn0ClRKZ7B/XH91Udj7xcjuUcBWqU97+i
 2I4qj5MDEuzBCjlwDjInOuW7favYUWlPuggqD6eRrDc9fuRnaWNcepxf3SEY+H2+xhb9
 MmHUeMGoc6ncNKOh0YdiKJ030Scp3Az9KI9+0FWTZKCpzOQ8AX2bUKy9RUyqA4cK0I1s
 SQ2jYxVM2gRCCBPc6f/T+1VtHmv0e4immtKFxGZWqWFmIPUAZ8G/OCjYtgo0lwYVDHRE
 61dSV8PWnHKuItbKG9oAj/TQFGCceOidr4wNwsaOAO5SeVLHhz3CB/M5cV+JxYut1UmW
 41Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784127452; x=1784732252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nn5r7AeNk4cWuqHl5SVfa1nBNDl6OHL27ndYTuwuqkc=;
 b=e2xt+Gqdcf9TX+NfAnt4AOYHVM0kidj6CHRcPjrBjQNFIFJgAb41eac1UlD3yXl5rv
 RXye/IaMzMI6HTkRNu51gtxYdXVN4c2QbxxX9oX4oU4lXoJoFmaFPm9C+VJnGa26sDGr
 jQURYfvnT2mipAINO0Xw7ZXzW4U36dI91E6zQ+1EE3bVfwIWG4PvBjL/Y8SivtcSNeHq
 UyXTjlX+mRhAykMrw7EJJ/AzbPxaF2kOMUiX18AzvtAXgpRbXYseiCAQiR6ASGv5/hp5
 BZehKwSAIl8ILjZYiah+6p/d45549pfcYiHqlX+JQZSYWVrqjnB/ZBTGvURG9iBJDxO7
 ZJfQ==
X-Gm-Message-State: AOJu0Yy/oi/jq0QYZ4jMRjqawfqIbv5ehd+txSYalJpdVVcrLnFSJLA2
 vEPhqwhIcnnafYOHAnS8omJDpocDL2LG0gI3+BXQ+AoVmMANl7ixLOqQ
X-Gm-Gg: AfdE7cmJc4LaQX3S9X3WDfFkM3L8+odDbWnUF4TbPg51iSFXKxwhFzrXYsFChOZWuUm
 TB5sro8GN4Qh5Yl9Bpudf/ftz6TbmvXN5FMZI8EbRlOHnLBDX0TBv9+LuR9ExiH6GxFsZjr7eLE
 6CO+RJO/HcmNCHwlYlLbaZ/gHroYYiSkx4+ORsJ2h1sLBA0D2hxYH2j9+d6hX2IAKvt2DcG863S
 /pgqjYoa6/9HqUZYoSh3z90cvZWC4Zs0XeteSs9GI0V5ysT6Zr1SUkFIyBIZt2hDNW26l3A0BML
 SAiHT0NJSnuFuljbnW0QQAcNoNE4ZuN1AO9NrPYCYsGoIONHDK1Wkf2/S2xvc7sxPfcfW7BZTRR
 +UNh76v1uCLQEe7HQDFRYl/0SLBlzFchzrusw25aPnrzwF5yjq1V4ps9AT9CuuJD6nYm4Mdyxj6
 vCfCrMrhXXulS8kf/35EQmLxV0UQwJR2dLm+yYXUPRvlEkSZlrIHk04myTgV+ZFrq9tuzz1fTVq
 OfNTAvuEQFLOZmdoQi+fi40ZwopX0vBZCBl/JjP
X-Received: by 2002:a05:6214:2386:b0:8dd:3b3d:c2d3 with SMTP id
 6a1803df08f44-90747c53a25mr88548886d6.20.1784127452133; 
 Wed, 15 Jul 2026 07:57:32 -0700 (PDT)
Received: from
 runnervm5mmn9.vvnp1qkq2urulfryuruztoqxpd.bx.internal.cloudapp.net
 ([74.235.133.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56bf455sm193802676d6.13.2026.07.15.07.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:57:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Tomas Dzik <tdzik@redhat.com>
Date: Wed, 15 Jul 2026 14:57:30 +0000
Message-ID: <20260715145730.4076-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <c2a4d3fb4e65c526dc207aadf2e3f70fec46cc0d.1784119861.git.tdzik@redhat.com>
References: <c2a4d3fb4e65c526dc207aadf2e3f70fec46cc0d.1784119861.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP/Lite test float_trigo core dumps due to free():
 invalid pointer
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

Hi Tomas,

On Wed, 15 Jul 2026 15:04:46 +0200, Tomas Dzik wrote:
> LTP/Lite test float_trigo core dumps due to free(): invalid pointer

--- [PATCH 2/3] ---

> Add some checks for malloc() returning NULL

The subject does not name the affected component (the float gen* data
generator tools under testcases/misc/math/float/). Without that, a
reader browsing the git log cannot tell which tree the change belongs
to without opening the diff.

"some" also implies the coverage is partial. Inspection shows there is
exactly one malloc() call per changed file and all of them receive a
NULL check. Consider something like:

  float: add malloc() NULL check in gen* data generator tools

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
