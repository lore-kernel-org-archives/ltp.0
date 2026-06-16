Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9AFCD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 08:35:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F4B63C96A5
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:35:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F32EF3C54DA
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:35:28 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C2332200C7A
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:35:27 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-36da8439078so3621634a91.2
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781598926; x=1782203726; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTawyeypQiG0yErSrsHkmQVQFuvjR472U9Kag9t6Vbk=;
 b=BEkI0D9XxcNmRkcJA4PO83ZamDCjivCU45tHCMnRunK1sKMBkHB5NIJq4tbDq+N4XL
 YB4N2byXUyYedErQtAeulGoPF0ii/wSXY+DfQyXFml5NCw9m0wYwIJQJkHPySDsnMlyB
 o97wFeXUKq1vEMZqqagpmUnKrwWLnurASkJXZdyKJbUD1vn4ebMtABfpZCfBS+GnjL/O
 YRCeaMpyaIrMqUqTl22ke+/35Iux+hIS9c5Mi6WMYwnZhk5BFMP98MWqwUCho3cWZ4GK
 u3oNnCMDEXvJyQKMOZNfDubkie2l4nFm5/QF+MgfX1FgMU7kYzeXKYIpywre+tAYE7GK
 JMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781598926; x=1782203726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jTawyeypQiG0yErSrsHkmQVQFuvjR472U9Kag9t6Vbk=;
 b=sYDYZm7WlORuRKPTWTgFj4/kkjGfCDipWrunmXNcvY9nq16kaO4ucFriZQNBPN0thJ
 q8Q90huip2ume+v4yvrM1dD9Xtwm97h5fkWoTGtXohqPI9vs3I3TEWRGnEgH757ngCsl
 hDEPvIGIervR+NgZnGqKVKRagc3a0GVUtYq0NuenfymdNqWbcqk9lj7s217n2QKOItli
 Rz6mhuS1agRsfBWUDKGtLH+9ArgLEGySzawuzs/wrWtGRKqiu72d080eZtEecnqeYFBF
 oH8DphrdQFtPHIl5EtnwnQ3XyQH19pErvmgrOThNksFhil/uDzPXLR8jE86odwoSUzO+
 9iAg==
X-Gm-Message-State: AOJu0YwylZNj6NJW6lzWdKmjkgBK28dDZ2SAhrpCLhOZwBHmkA1EI1lN
 fV87xAVKYcfLAZERRb9RrIzaaMvbBugvozpCcwUDP2fbbKiWtIL4gkqVNd2awDqy
X-Gm-Gg: Acq92OFjQ76iJ7J5rDkWqwGvcG1mdvv6EFg7H4CvN6mIQJ5SEu1ydBL8EirsdGxnFPX
 ir1Ye95UVaFE7OT8nOs3HuCFQusSq5fEp15F2raD9uqTnq3DqZ38Fnaw/88iJFnNFsp51XPszcf
 V3ioHvAVum7Yd5m9t9X9ReXSjQwFFtFB7iAfosJDmGBrqK3B/H+cVq0VltwbYc5ZXZ8LCj8oou8
 lC1N6vVTkVj+hpQAX8jdd+8y11urTIW4GxKi2HZRLKCkbS87L4K+8Kfd+iFEHrNm9QqtLsugmz0
 SwHFDkaIBn6nB4bQgggK0V+70/aBWgm9DWJP4WX/N7F/h+sXAbQ61KFjxHv9Mb6RiJf1lQ+BZ+8
 g6bGVWavw5u+vOtgw88biFRXbiOOuNFXG0x2SPtMEdoYFe1WyCj8VCGswwGHyG5mXYiOK9Lncud
 n94kaAQNk+YfjNe/pb1RsUWn8jwB0XEsvhV5CUbgMHYMwD3Rf6GQGnRaMSUmE2FhvWbrqp7GeO5
 LTdVcpwLFScy4j1QisULlLGQkew+sKfUizyB1lh5mgM8J4=
X-Received: by 2002:a05:6a20:7fa2:b0:3aa:f9cb:d43a with SMTP id
 adf61e73a8af0-3b7e44b4598mr3309689637.5.1781598926200; 
 Tue, 16 Jun 2026 01:35:26 -0700 (PDT)
Received: from
 runnervm1li68.atih1j5idlnuzf0a0ifstqup0a.xx.internal.cloudapp.net
 ([4.155.99.35]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8665187d3fsm10517999a12.17.2026.06.16.01.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:35:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue, 16 Jun 2026 08:35:24 +0000
Message-ID: <20260616083524.4087-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616052452.8353-2-wegao@suse.com>
References: <20260616052452.8353-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] connect01: Convert to new API
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

Hi Wei,

On Tue, Jun 16, 2026, Wei Gao wrote:
> connect01: Convert to new API

--- [PATCH 2/2] ---

> +	.needs_root = 1,

Ground Rule 4 requires the doc comment to explain why root is
needed. The EACCES case drops to nobody via SAFE_SETUID, which
requires starting as root. Could the doc block mention this?

For example:

  /*\
   * Verify that :manpage:`connect(2)` returns the proper errno
   * for various failure cases.
   *
   * Requires root to test EACCES by dropping privileges to an
   * unprivileged user.
   */

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
