Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA70CD5BB1
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 17:03:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D4DA3D9EA0
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 19:03:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 383883C58CC
 for <ltp@lists.linux.it>; Sun, 24 May 2026 19:03:20 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9BEB5140005A
 for <ltp@lists.linux.it>; Sun, 24 May 2026 19:03:19 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-5102582e23eso70138351cf.1
 for <ltp@lists.linux.it>; Sun, 24 May 2026 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779642198; x=1780246998; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZILPUvq0+El+U8C0oGkBh6ETgFECy5qGVgeY+lCFAU=;
 b=FJGSBTd5wAORUNSwbp3GjjXVHh++f53cZQ9jXTEdxlP9xee5pcuJK/VYX/1aZXRlpU
 Y4w8VOBDeWKoTdSwfLfwVLhKtNKfE9XKv2N9+HlCW4r5mXT6xF9rAJuJBCnx7/BVGmdg
 qVo9aEwY66FzhY6ctBxVkhXFFksSc0aqtmBBFjOg6jCPFgNocuY1hlgGL/tn3chksQHS
 vLZdH5rCsb9SwgbJ9litIA5BYfMH9PE4Lzc5qZfSRH1aIZz33T4nMZhu0h/+Z+FXU+Zx
 flx0BmvLUlgRL+ejXaXr6Hjs9Z8J1l98XwiSTFIeEYBGHD+DLaG5b7rQHs4VO8nzx0pN
 8nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779642198; x=1780246998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vZILPUvq0+El+U8C0oGkBh6ETgFECy5qGVgeY+lCFAU=;
 b=PAo2OWEHC8zE/XEMpoXuUbkn2grkAY95mZD5mXAEdOepd25obgZSCZuvdpoaAnmLBO
 PTnC93stQYNTiz4Fih5Ezq8Y08tKlw8pvCWwnm05NjK2THrQXq6rN7hmNnxnTULJ2Ksx
 T8YHSkuOeGrEqZAQNOxmmLYD8F+x+BxJ+I/JiaA4845LicmTbjN38hl5upAq0dLsotHR
 rA1cOpebUJ3iUFuPbBMYIBpMqUT5JFcr1/O9gUG/V8z55cfwAaiaz2P6KR/nBQdBIUsH
 grjmkjPpWviyTUNs2nOP4Hke/rNIZD5H7q8XxiThX5k0JWdJId27+Xm7eLVK/jG0iAJo
 plwA==
X-Gm-Message-State: AOJu0YyKfs2NfRUuVTAcndYPv0LFWchcc4wE/o+jhqSJdL2mZNWE65Xh
 6FVkJJRpq8nqCXj48FFjW4rBanjFV6GujxljCiPNKoyCQz5xUady9PmW
X-Gm-Gg: Acq92OH7nNwlKh30TMQ7nCjQw+5FF23fIycvO8QRkaMoNQY/hdnyBTqxIaeKSRLVmJ7
 BXmMZrizcZQb+i3ehMKy+Xsj9/p6vK3YmNHc7UCWoUcBZDx9tGD5Y7KnTRGKrTNNXEp3EyRbTRI
 1EJ8Uuprkk3zl5r+rPv2ivkMqgEksi23/sGQtXPk+YHk+m/2iJn6ndNLbgOhNAU0VZxQ63lsaP4
 7En/ITGnMQ5PM1jOYmbj9D3Vjd6Ke4OyqVuivC4LVdy5dugQwYtUXrDw05vNzH0lbYYlTYqiNoC
 9A3gHkPMyJiazJne/xYhD0mTsAVosA2z1hGO+J9E+7Xpp9g0GUuDNEW4fT8ozTAcwXd7VT4J4m9
 nYDg9vm799orCxpAkWB/d8Xf5fmYpToiw/QralPPuX6uYzXAIMeG4qSra/A1IdMCnoJlYEP0SEZ
 sEGonWLhAKMAogfJqN+3VP18PkxoClx1vmrqoUFPvvOzI+FJn9pL/gC/EfdBHGe0XPFX/efQ+12
 xk0bZEW2wBomrKrEV1qVwEq32UTgFK79vPeMA==
X-Received: by 2002:a05:622a:985:b0:516:dcbd:aab7 with SMTP id
 d75a77b69052e-516dcbe03d2mr133198501cf.28.1779642198295; 
 Sun, 24 May 2026 10:03:18 -0700 (PDT)
Received: from
 runnervmg397c.waqj2igf0bnehavxy3b4j2vbqa.ex.internal.cloudapp.net
 ([64.236.135.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d895ed9esm74946751cf.0.2026.05.24.10.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 10:03:18 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Sun, 24 May 2026 17:03:16 +0000
Message-ID: <20260524170316.3846-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524161706.3510-1-always.starving0@gmail.com>
References: <20260524161706.3510-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] getpid: Link manpage in docparse comments
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

On Mon May 25 01:17:03 2026, Jinseok Kim wrote:
> getpid: Link manpage in docparse comments

> -#include <errno.h>
> -
>  #include "tst_test.h"

Both patches look good. The `:manpage:` directives are correct Sphinx
docparse syntax, the unused `<errno.h>` removal is clean, and the
SAFE_MMAP continuation line is now properly tab-indented.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/26367328648

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
