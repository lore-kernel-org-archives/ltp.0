Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FDF8D759
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:35:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9F323E71DF
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 17:34:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F20563E1BDF
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 17:34:41 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 120FC60046A
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 17:34:41 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2d891442388so8410070eec.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776353679; x=1776958479; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UY2Prq3r54qJWFQNr36iLLX09R9j4zJWV56xIeOfnvo=;
 b=h7AkOoYLgJOJaiTeJnUFdIGXM36j0/tsi4KX74QPzEHo7J5y/GW9S2oB3faEAYRKCf
 yZ6UJ/gtjmzfJM3VDQ0JiZrqxQDnil+DTaNEYyY4fh/pnNVALmYnaOLy8WzllH+qtnB7
 u3IDAJSoqiMuRBgtJr47WV5dE5TvosGS8+LjHsgw1EG3LHpjDBM4MujX0soGT868BSiy
 HY6VE/8pB5VCSsScevEYAWJq3OupZ1YELOQYQGzvPf0wkE/mgOMfQs2H6SumtZrM6wNK
 W9CBgaUrI9Jz8WE0MAveKUWRto/XAKsbxOLUC/avdmSiwWA/6I1rtr7arQwTZ8v/tvUr
 S/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776353679; x=1776958479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UY2Prq3r54qJWFQNr36iLLX09R9j4zJWV56xIeOfnvo=;
 b=UjxTfdUh4XP+ey5fcom1l6gY9wGwC2VJ4LF8gS9LoY1RArijZhbh+8uFEBgA6c/sky
 uMYDapPUOfdDfy88+oIkBIVPYqcWv2FpaY4fEXXZe2NbhrL7kfn92LPNg1GTlMtJUSBh
 oW1JQTA75FOxZZ6VkECsvHcrKiUZqyilC5fgrghnS0+/Ln/lOSFnIgOVziL5Z1ZuJgUx
 qGPTC4MilLHfA//ZYLbwwUvX7vxG0gdJSpsAgZq7vWPNkQFULQ/SLIg7Y+fioFBm/f6U
 5TgSVcq68Mrfpl1asvLwW4nN8t0W/msFOTMm6fN10Mc1w+fepTBDkdt8FdsZQcxRBdjk
 eL/A==
X-Gm-Message-State: AOJu0YxHpYbGxyEL7IPf84FgaQbRfgrU8n5qIqDnzaJOVHW2tiMBRI6e
 gYqJ5CdIUIWdZfXYtMHStYssS4iy6mcDUZxJ+FCvl6SauUjh+fFzSWg+7M80DN3Dr5Q=
X-Gm-Gg: AeBDievHl/OZC2Q6atrk86wU1v5FByf1kOSD37mDIUh+LRvX23BAlpm/hjbl7pRcRxd
 dWvxXb+idr7ZLIAUKYex5aNIFOg9nE7VgxxNhJXlpLU0/N3CmuELLB8lsMdYUvwVG2ebn6EAQoL
 x1+Wu14NjPBmOPmc1RLYW0jx1Pd+Cao5V0BaXacIf3AuMlOMMEzrHsZKhpu98MluIpmAcf7nPxA
 9WGS1XQZwBOoy9SV02vkGYZCGc7exL8l0aoD+HMj1PTN4XJSVbYp9d6rfT6rLXaiArj4lZXVHP6
 0+K7rAKPYmoXoPtIGG6YfYkv5BMTXfc3hNRlZJEiMl0V03LozWg/MctQuaN8BJlkcMELufqU4Zi
 pNL8Ia4DD0K9Edn3dcbzKUZ5uZbq4tPKlAeS2YE7WuPJcxPRqMn1AJXxvygyo09Y9XFMydEiqic
 eiPPXVUs8NWIg2cvFZ9paMigSJUy9K0EIfgnnUl5sJwB334AfTM9qt7u3nWL2jaUAeNchLpiGgY
 R1XbrA1DivjnSGAQTa3Fzz2n1x1la+v0UDU7LwR+uw=
X-Received: by 2002:a05:693c:2c85:b0:2be:6f30:f2f9 with SMTP id
 5a478bee46e88-2d58a39d35dmr17037088eec.26.1776353679253; 
 Thu, 16 Apr 2026 08:34:39 -0700 (PDT)
Received: from
 runnervm35a4x.c41v2zfaraieda3n4uxiuojluc.phxx.internal.cloudapp.net
 ([20.168.108.231]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8fa5f221sm7758497eec.27.2026.04.16.08.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:34:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 15:34:37 +0000
Message-ID: <20260416153437.4144-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416-stream_refactoring-v2-1-8321b1ec6f68@suse.com>
References: <20260416-stream_refactoring-v2-1-8321b1ec6f68@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: add safe macros for stream testing suite
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

Hi Andrea,

--- [PATCH 3/7] ---

On Thu, 16 Apr 2026 16:33:37 +0200, Andrea Cervesato wrote:
> lib: add TST_EXP_PASS_PTR_NULL() macro

This lib commit is sandwiched between stream01 and stream02 test commits.
All library helper additions should come before the test rewrites that
depend on them.

--- [PATCH 5/7] ---

On Thu, 16 Apr 2026 16:33:39 +0200, Andrea Cervesato wrote:
> fs: rewrite stream03 test using new API

> +	rewind(stream);
> +	TST_EXP_EQ_LI(SAFE_FTELL(stream), SEEK_SET);

SEEK_SET is a whence-direction constant (== 0), not a byte offset.
Use 0 here instead.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=500172

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
