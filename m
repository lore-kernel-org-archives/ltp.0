Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3C4C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 06:53:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A09513E292D
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 08:53:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B92073C56DA
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 08:52:46 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28CF22005F7
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 08:52:46 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2ccc2e84048so4133245ad.1
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 23:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783579964; x=1784184764; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H0tH8JtjneqcowRpVSmA416kqoOfwi9VyqRB3JtAzEk=;
 b=hOt9UJzusZSNMrPEAksCoyBxlnxXQdWnI4k7EnPHhPfdYm+DhlNUTZhHTEV2FqeUtI
 Jf8vO8/I1NFzGcm+uwoHDoo+82q2XSiAW9VtN9eAOF/MaCGKYyLQhzgdOGrWALlhlWHZ
 MZhjZe6ZwRR8PTC4DiChUfWwCQWw6mvJQ3fgUDM2HZeCcwefGMVdzAWjyzNVP9Steq6G
 3BzNXjErOoKEHe0p13SdrEM6TQJuL/iYAwdu1888AuqVya6zGC6TKuAnvvf5JejNbYcA
 8cHl4nT9kylztYpEgYDFtL+OcllP+q5joiEGf1UTyP/XYpEB4mZ7Y9Xav3m1uBx2jGm+
 EkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783579964; x=1784184764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H0tH8JtjneqcowRpVSmA416kqoOfwi9VyqRB3JtAzEk=;
 b=jOJfKvd4JfYuvonisNRyOkgOZceOwiCUsn41bCYSkLrwmxk0D/OCpDCDgmOVBD8Wtj
 gpFzP+vtUQDj+0DvimaU3WoqnWqbWo7auyY4ZGrvox5CgsqFVWlUAI3N/0cz5Mum/aNS
 wCooZP+ONG4q5uqca8hdJVNpZ7o2RZJrFFg6nFtkXqEaRyiYJVrlXmwFN2ny/w9oG2lm
 mLh9pbAms2N4mt7CBoy6Ple3Vbqg78BCnAGzPRCfnW/Mbs1fWkOG91PCYPjEKItYPRyU
 Onbz4Gcwi07UV7i0Zgduc7cMeuAp7C/crBzbi92TpmhcgckFlz+LD7LZDRZM5isuSv44
 gMeQ==
X-Gm-Message-State: AOJu0YydL40VaMzMWwXlkNq1tumTBO3VnlMlzUGu4yr0Z0WPbLuWD/t6
 yJJ2Q/CvhL4u17C3OXgdd3wB+TRX2hMJgx8vTAslgIsOcA4nNIfmpoDKaydxaT5GPLc=
X-Gm-Gg: AfdE7cmgYAc4x7lC+hjz0oAkv2qBFoOgb2nF4Wq+hON2DSjYHhKG7Lp/QmGta80Bbyi
 OC4095qX/qj2ZmcKGyWVq/Z8mIxR9I7vA9VBNasYTg4Yh0Oisat6lGl087LYhWD+J9unEBVk9c/
 DWRGT6XO8V1GNOQ0Xz7u7MFLONyXyIy0Q9d/TV1LLVAPqpwyRp0Vbyv4y2z9JH0g+/84WwpSpS3
 3IPipq+MPnQvjIQuqQknByZCwFm4btHLkDAA1m4jc+UaM4kGWhLB1N5A9DHtKno0HxzRnB/oAF/
 z3m2goyuQhxaLUATs7sezRRsFd8kqQcCDFF8e/MUiOwTcNQuf7jKdi3nHJFuIEmJrI8kaDbdwEu
 3CiplwDwxxmDn5YYcw0cYbiqD7xwDuG8A4vsZxjiPTxtYmVjanBQ+XmsqzwZ0CgSZ1kHXrEg3V+
 bbQ6UkpdCHwQpr8Nz7LYupqVxRbgVB0KIqLZ3TwOk8fMU4003cfRl1ns34NE6i7Qa+uwvTV3LUU
 YncwSSNnmlyYDdNEK36Q5mcaLA9
X-Received: by 2002:a05:6a20:3c8e:b0:3c0:9c18:d5ab with SMTP id
 adf61e73a8af0-3c0bd231db0mr8022531637.72.1783579963670; 
 Wed, 08 Jul 2026 23:52:43 -0700 (PDT)
Received: from
 runnervm5mmn9.2egbwc2figsurhoyketqa1qpfb.dx.internal.cloudapp.net
 ([104.209.7.208]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm43514009c88.14.2026.07.08.23.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 23:52:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Thu,  9 Jul 2026 06:52:41 +0000
Message-ID: <20260709065241.3960-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709041323.107-1-sachinp@linux.ibm.com>
References: <20260709041323.107-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mem/min_free_kbytes: Fix incorrect pass/fail accounting
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

Hi Sachin,

On Thu Jul 9 09:43:23 2026 +0530, Sachin Sant wrote:
> mem/min_free_kbytes: Fix incorrect pass/fail accounting

Verdict - Reviewed

---
Pre-existing issues:

In check_monitor(), the flag variable used for signal-handler
communication is declared as:

  volatile int end;

Strict C (C99 and later) requires volatile sig_atomic_t for variables
read/written by a signal handler.  This is pre-existing and harmless on
common architectures, but worth fixing in a follow-up.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
