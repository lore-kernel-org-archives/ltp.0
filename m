Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7328CD6E57
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 10:17:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 031C73E5A94
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 12:17:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCD2C3E165C
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 12:17:07 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 27FA51A00706
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 12:17:07 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-304f0039c02so905487eec.1
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 03:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780568225; x=1781173025; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHlfByxYlbm64EHXdKG7loZHd3KpV6KvXMCznA8gs24=;
 b=MRe+2xCmNFvPQCD+lSM8Y3QKC8Z58q9bYWfzvfyVZWsFa+FKC0oyY3IZboe9IO2jZS
 ryD7p2OaoaVRCDViGNOKDfGcCerq/RALaAdWuahr0zCq0MwHwm0U6Wx1bQiW8F9ngllX
 x6kBlvOkcruXr2ItIMLLdCjK8BO9O7yod+8Hy/+Tl8gUD2i+dGuQh58lx5kdoyL1V8zs
 vmS1hYhNtafuRwEuhzVxQk/OsERDQj0ZPmm7miNbROqmv0S55zCBK/hhxcDaq+4umQUr
 5ztauyfLXIc+LCB+KNrWlD2JyCUFStfgzxyKPlX75Uny0nq2RNp/2fJnWgs/VRU7AyQ1
 HFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780568225; x=1781173025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HHlfByxYlbm64EHXdKG7loZHd3KpV6KvXMCznA8gs24=;
 b=l2xDJPXu8wFMYFnlb49UDvWUYWK76tM/06xpJC584sKEum9Tj80pNTN5JMAniTV6CL
 5/xsfgdtoxf5k5KwsBg+cF63lFzhNi65gQgTXBTu4kBm3JIgPCdHkgYndcQaWxy3ZvL7
 KfEhhIgboFl8lqAW8BvcJTFH+n2V+hJ+CDxIyw7QtjClSPNoEcO0vXt1BwoDS8bhbFmY
 dQ3pJLmPEjvsfy8RFS/i31sw6RE9sNJu+MdaFpk8whkUCr5amGIZPi8fw6LgJlu5zXmy
 Cz8Z+F3uV6wsY5Y9gTQS1PW4cbckaOk7TmnfT6pOvcqtAZZX1enlpxNPYUQoHfG1SebP
 B1KQ==
X-Gm-Message-State: AOJu0YycrAYrMf5bcv6c1rl1vqEqwc9UmL2+N5rs6jG2R76jBjD67Jg1
 K7BjGn0mgxIxrebbot8nz0l4pKYUeUJHGRJuCTVXvJZhYChNzKvOqFLj7vT1TelN
X-Gm-Gg: Acq92OGSP9VKM5HW9aaHOUPwpLy7nHTUi0pxKouAUfa9Oxj+Kq/g4UiJbSBBeZ1e0l+
 MXapJBoL1KaOJy55jW6a/hjLGutQtaPza9dQteJ60L1++HmzaaaCSL+zreD2wMmNx0mU6FVXdKz
 AFpx0MA2OM2FVikHdQzx4L277RaKxlKrc7EPGVw3+qHsKz2nG8OIVqZlYldVzl7C/t8UYwCTQb1
 GavhxfAUoKG4W/ix3V8N2yVmHaIyOqJPnqe7G3w7xN+dGH2O4iMzOtGXtokb3YonfVximsDJ3GH
 2AZ4/37w7QEEasX/PKKuIms+LfRPoprWtJdJ3FfNO95DuFz0aEzAz/j2orb9W67g3za9CPBNYtH
 XEXxmdC5b8aZZzQZQ4o7uBNh0nPCGg5Tbo3c7J9yjmFu45XOgyj1bYIQDmlzqPyTPS+emQlEsGR
 teVjtVwQBKqvOYcksAgoZElP/NBcX4HyL/tZKx+c8GwJ8kZ4qxIuPrm4aXG2sGMFhdgD6ry81V4
 18YJOfGmaseAzX09MgzyXrE7VNT/m0IbGKlGvJ67YNn29AXXA==
X-Received: by 2002:a05:7300:3254:b0:304:e6f8:7ccf with SMTP id
 5a478bee46e88-3074fbebfdfmr3847597eec.27.1780568225352; 
 Thu, 04 Jun 2026 03:17:05 -0700 (PDT)
Received: from
 runnervm3jyl0.wuolxekxhwgeff4ufomx33wcof.dx.internal.cloudapp.net
 ([20.168.157.83]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm6558274eec.8.2026.06.04.03.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 03:17:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  4 Jun 2026 10:17:02 +0000
Message-ID: <20260604101702.3939-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604-doc_add_missing_headers-v5-1-2e0adc082d5a@suse.com>
References: <20260604-doc_add_missing_headers-v5-1-2e0adc082d5a@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Add missing API references to api_c_tests.rst
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

On Thu, 4 Jun 2026 10:45:08 +0200, Andrea Cervesato wrote:
> doc: Add missing API references to api_c_tests.rst

--- [PATCH 1/3] ---

> Fixes: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")

The hash eef750db28 is not present in this repository:

  git cat-file -t eef750db28
  fatal: Not a valid object name eef750db28

Is this the correct commit hash?

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
