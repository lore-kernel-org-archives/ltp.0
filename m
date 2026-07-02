Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4002BC43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 07:34:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5872B3E49E2
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 09:34:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AC0A3C5583
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 09:34:30 +0200 (CEST)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 937612009B7
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 09:34:30 +0200 (CEST)
Received: by mail-pj2-x03.google.com with SMTP id
 d9443c01a7336-2c9b43d55a0so9495175ad.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782977669; x=1783582469; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9uINrWsBHU6NaIr6S+qAmwzfPhIOU4RrJLae1YeX/U=;
 b=E0HmwKO2NYNEYbEy8BydYuPYk6VQBbnTe7rir8c85yIGJhOmYJm1VuHxqqUKlRPQvA
 knJVh+qQT378wq3CiFJZ1OyKhghL1a3jo595Tx1kdsFGSri9Y3F0rbaF4ZIHPpkwOaA+
 TLehjt6+AmNjD0DYFtpX4mWMa/H/LGorrNG9CoYK9oYGAp6XD4aJagMk5U/rBOTqFY06
 gHPYqYEOJzbcWf2ho9cYGqFsnKZriIjYbLbG5y6E65kstkpf0ADBb3u66RMU/P3Q9nhT
 C1pMNV46xsvBdidxdmQDrEvORUQ9/ozQaCU7sSFYqS6LX/dzENOP1Cs59DYCuMGxA7kV
 Q0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782977669; x=1783582469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l9uINrWsBHU6NaIr6S+qAmwzfPhIOU4RrJLae1YeX/U=;
 b=OnNNFZfB0Y+jSnvIyfpzpyoS93ZJS/VWTUrL8xB+Dgfz26QUzXPULfDVM1XrpHTZIs
 SFXZX0tiqMitv2pHPBJQxVwOqB744AZea8/IcpfTM0K98ymMjdUUsU+IFgpAze4xZl4L
 SM6YOopXACXIDHG0U3Qfn4+ZHwgdnGdpz70/HiYVr3jwoMcYIxjhSoHJRHBL0lvA36sh
 cMH1bls2rucjof1/DU93WE17j32m3LjSfmXnZWSeHCKyYRkc/W8mOdI4SnI241ASQPFL
 5nHNTZ6KUNkAckbBHpd7QbJwObgS8F290/lOgVNSOIYobcFEtiLdn44P3tUAqc4Q7dfs
 ZBzA==
X-Gm-Message-State: AOJu0Yyin7t9zD2DK80Y/GJISSncJx5pb7Ud47k7DsK98sFvohRZcn/o
 4TQmAeE/t9SFMTOlNjDp4c1w6taIBFoKpWm+pBlYSxRbgRo4JsDyh6Xfaojo/3By
X-Gm-Gg: AfdE7ckKAMqt2yGx7hdSyf3w9FFlbeu51nkI30IPbfgBN4inoyi7dkUhmKU3WjQ/eFa
 CLEjQaLAmtdspqVGMAgt+HQ8e60FpHU+amVi3en9TtbtIcntP5W6bIlQzZA6A7Njs9wI40tknwT
 rdzOkKrg243YZtU4IHPYGpAx9gZaVZ4SlKBD5wvrAGg57CISpg8DphEdQd8pwwlTQCRH5sMoaVy
 2/za68A91+eI0jL3pH11PcZ09vQHvBnkvb/0JUpnwWFPw37ntAbycS1GKGl3+MTKtXaShbyudux
 VimYBmPbfwvsokT5jWIguSsr9pITmQBrFEZSTEwkrEYMQuez6cFe/4CU1nLTIJUKY9Qlc1rHAfN
 /z4+d0KNweQkDaS2cHq/LZIAFw1zBThPEP/mQaQE4vfkT30o9HdktvBkZxNne3dLbBZKrf7om8q
 z5pTyMQG/I8osFJlDUYNwSO53ZvoDoQ4IuwWIqxrT/xsIyANFoMJVI5rXsqHQbjxyilk48JqOJ7
 hcZTQydjiE5cNFeoLRVPhxJ+83fKA==
X-Received: by 2002:a05:6a20:d81a:b0:3b4:6f7e:d0f9 with SMTP id
 adf61e73a8af0-3bfed122dfbmr5870005637.3.1782977668253; 
 Thu, 02 Jul 2026 00:34:28 -0700 (PDT)
Received: from
 runnervmmklqx.ne02jlwbml0ehokqdifvkp3bbf.yx.internal.cloudapp.net
 ([57.151.136.176]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85b345sm9080510c88.10.2026.07.02.00.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 00:34:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Thu,  2 Jul 2026 07:34:26 +0000
Message-ID: <20260702073426.3990-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702042505.389515-1-wakel@google.com>
References: <20260702042505.389515-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/lsm_list_modules02: Log unrecognized LSM IDs
 with TINFO instead of TBROK
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

Hi Wake,

On Thu, 2 Jul 2026 04:25:05 +0000, Wake Liu wrote:
> syscalls/lsm_list_modules02: Log unrecognized LSM IDs with TINFO instead of TBROK

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
