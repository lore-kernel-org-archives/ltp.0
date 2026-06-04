Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D46FCD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 15:09:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D56563E71BD
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 17:09:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 566EF3C4C09
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 17:09:34 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ECA4C200936
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 17:09:33 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-304df7ff4c2so1295054eec.0
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780585772; x=1781190572; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9feSIGp1T+/D1VzwV8f2IDHFG92ASysFU0jV0AxRQo=;
 b=IzL4BKY2e78yAIrms7Xq6RZsIiiHfUO16V4vjQgnNc5+mY+gJgG8rDOkv44VwpTdOx
 heQ3AQ+rM0h+d6i/GfRJa4JsNrdG51bAKOFJmdr2GOesTIDhbDSLysbgFBOj+/7w63st
 Ce4BjrJ5iGwfd4GlzilVJNJ6zgYqiv7bJP2Eqf2I6iTCdB8uKO1CvhRNPGab7MwEm9bn
 5TMZpD3v+gKiJrLIJ+p5tdm0mT4tySKDMkFNqSdZH4osvuyZiVDfM4tNNB734xgY/RaY
 zH6eeI1K6ZOZHoOmIIY5hh/YIvkKj7lyOUWz3qo2lOdK7DdqcEFT24HIPClF6eECFDPZ
 mwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780585772; x=1781190572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g9feSIGp1T+/D1VzwV8f2IDHFG92ASysFU0jV0AxRQo=;
 b=fAUJ/fO20WQodSlslAKeZffSt+e1c3GI1R4PULvotBcuWLFFzD1a3mIBx1uOhjqG9D
 z3u1qcJplgkFBDnfcdQ+cXTRX7rTfMCvc5KHkAzEqqh4YX00FFERQ337GGG8qImvDFjr
 yY4Ore8CuHSYV41doEojpYXJBFcFEDNAH3JAcIxCk6AzMKV5ITqNkqcBYgVLLH/mBHbg
 ZAH9FEq6iwZqghx9G+v3OK6QY6UEWFW6CVCzzlmocGzvrxrb5mtelvmqtYsAbDRqohjk
 MoLLEXzO8lOxDYenKAurscVU2Y9zQvT5R4OT4KRradzPCSNtl5MHV+WZ3979iB2eLpuR
 ZLxg==
X-Gm-Message-State: AOJu0YxhOKUj8mk5rJz5V2IXmG6+gEehvR+IgoznEFxJ2Y8Qv4BYTDx9
 OuxFTaCJW0T85zYzwk1vYdoFz7uaNadiiSM9GJUR9+/CkScdEMoSOjzx
X-Gm-Gg: Acq92OH3q9SCyZRGo8BcEhJ9x/S0ierODTm3f+pxDVD7HsxDU4MPBMANHJrkpTj0hPt
 QbTid6uuJGlHDLRuUkVO8870/5Wl3H15F97NturxCnRcmk0I4Dr0NSVenRpoMDPph9sZ+ye6E9j
 CovBqAGibYHsRB0accSTPuxYasct2AuH0V/EV8/qXmYCztxdxLNELHbnxggfCcr29eX3OM520JG
 UvVmUoI1lD8ewOEUtr/ijCf6qsxS9K/4aBS1f0egM4uaUDmBxJlCdaXzdnVxomzsJN/lWFIXuHl
 g33HWAAslOR5bnBP0e2sPCzmjjwOuKqtW+Ey0pqFT0ogyIS777UAF3LX78xktMGMiMtu6UVR6uS
 lduwSvtq/myekW/3qxWrPvU7Nb3mrYwM+kvmVDnbe1IOEF1oR21tUCkRtk/06YwQ6rvnKQ6WPGN
 CcxTr2WwIRZION8u+N5nOxrKGld5OIObAXNHmba7t72zNeIxJrW1u3/LYdfqDsYqndp1C+6lrPa
 hdgHBpWobXohRyEHeQw9OEi/upE0z4vnFpXL1sCbGk38hkCTg==
X-Received: by 2002:a05:7300:6413:b0:2d9:db50:c6ce with SMTP id
 5a478bee46e88-30761eaa447mr1991289eec.3.1780585772131; 
 Thu, 04 Jun 2026 08:09:32 -0700 (PDT)
Received: from
 runnervm3jyl0.qtkme5kclwxuvgk1gfqfrwzr2h.dx.internal.cloudapp.net
 ([68.220.56.243]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df75ff6sm5391086eec.26.2026.06.04.08.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:09:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Thu,  4 Jun 2026 15:09:29 +0000
Message-ID: <20260604150929.4232-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604142029.2077-1-always.starving0@gmail.com>
References: <20260604142029.2077-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] open: remove O_DIRECTORY case (move to fstat test)
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

Hi Jinseok,

On Thu, 04 Jun 2026, Jinseok Kim wrote:
> open: remove O_DIRECTORY case (move to fstat test)

--- [PATCH 2/2] ---

> +/*\
> + * Verify that :manpage:`fstat(2)` correctly identifies various
> + * file types.
> + */

> +	.needs_root = 1,

Ground Rule 4 requires that the reason for needing root is documented in
the test's doc comment. The test calls SAFE_MKNOD() to create block and
character device nodes, which requires CAP_MKNOD. Please add a note in
the /*\ ... */ block, e.g.:

  "Requires root to create block and character device nodes with mknod(2)."

> +	int flags = O_RDONLY | O_NONBLOCK;
> +
> +	if (tc->exp_type == S_IFDIR)
> +		flags |= O_DIRECTORY;
> +
> +	int fd = SAFE_OPEN(tc->path, flags);

For the block device case (BLK_DEV, makedev(7, 3) = loop3) this will
attempt to open the underlying block device via its driver. If the loop
module is not loaded -- which can happen in containers or minimal
environments -- SAFE_OPEN aborts with TBROK rather than skipping cleanly.

The test only needs the fd to call fstat(), not to perform I/O. Using
O_PATH avoids instantiating the driver entirely and is more appropriate
for a test focused on fstat() metadata. With O_PATH the branching on
S_IFDIR also becomes unnecessary since directories can be opened without
O_DIRECTORY through an O_PATH descriptor:

  int fd = SAFE_OPEN(tc->path, O_PATH | O_NOFOLLOW);

O_PATH + fstat() has been supported since Linux 3.6.

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
