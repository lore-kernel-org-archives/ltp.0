Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC4606A31A
	for <ltp@archiver.kernel.org>; Sat, 24 Oct 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HmsDijG4
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CFA53E2024
	for <ltp@archiver.kernel.org>; Sat, 24 Oct 2026 19:56:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F17B03CFD68
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 19:55:58 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 71664200217
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 19:55:58 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-93a40a9a01aso341304585a.0
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792864557; x=1793469357; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LRG5EEW6rZ5FAyisbTb3cg1Rv8P1m6OaxZvrFyqk/7k=;
 b=HmsDijG4TVxSrcFdn7VMxXE9YFvTP+VmKMOFFFZghNmBqvdHsQIp/Htmy4SAizh6cA
 y6EvORYM+g9EF0n44qmH77x8fornD4NQj8G93rdvju10pzhv6YML+Y7lE7+FpmX9B2q/
 jf3OR+rKN8STqVCPDE1pKPjpZLndGO+U3xCMW2s7A2CGEE5dcEC+87OQuR+yZOue4qe/
 GzuYGqnTAukHKVSNSdg7/7Bc9Wj/Z60TiDTg5HQz43FO53cj1TqJRIFva/5tT4+dlXVm
 5ub6Yoh8HJznA2tIEyh1gOlv9m01EQvY2WzKU1gS5xNBPeuhJb324FbHHJnHxR9HO8l+
 WKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792864557; x=1793469357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LRG5EEW6rZ5FAyisbTb3cg1Rv8P1m6OaxZvrFyqk/7k=;
 b=p/neWPoI6WBU9NaylU7XCHJc11+jHJO6C/I0XtmZzUhy8Ws39KV5cPHz0WpDQbajz5
 iRCim3Mtw0R8S1jV0QasrIClWNlCbv8Gckr7+2TvoLLA0l20yqeK50szctOVDBXkuRwj
 sQjQcZANuJyHYIVBs4+Uslb7RKXjnjqKgQEcMliAh3Q4SFpkSqRnFvJPbrHTALbvh93Z
 gX8r5tOMQYXhA2M5rC5IO/dA+4vp01xUzfePefzWNYpM+QJt86n4ngosEB9qihubwFo+
 2NRngJYNs/m8YljPQYDZIJsayzP1nglX0fPt8GDtZgqqo7pvbkRfJ8euZ6wjowmJ4IB7
 XWzg==
X-Gm-Message-State: AFq9FYIVSDuys2r/My7BFNZVZEigi9Kl4x1rChcvy5EqkLeRawNgw2of
 grqr3W1Pted84YzfSiSwosls2z9UVUizsommozYWZzrssUJUlzrX03Jj
X-Gm-Gg: AYBFou0hnS4TneXa6oorZ+dEU8WMrevYUs7obXLR++xgwW7Qoyxilyn0CPeNNzb33q5
 HBruLIH4Rm6I9irGv7uALOdAYMqP4aAE+JkK7XPWwYMgUwEf9YRA9ow2VbyJse2kp4weSijdZQm
 DAXYefjV3HGVP+W0RGj75AuvGoKprbCj8pTL0X9VU5XTwZCwHBEwO2aoimLK+0n/plxwzAu8aBd
 aQAgP2Jg8jKayQjx3v/KvhgkyscHztAWtefwpgbw02AiiwFWfOjLRz/x7fFU6+HB1JjVscccNrr
 GyxNK6VBWWpvfRrzNUgFJfNIsrLIajt2xICe7QAdnvmFOECkq8svR+b0ksvOdFZHZ+MTPyOCMb1
 vPA69mB3h8MgPWPbWKxFfzb0oJCAoo9dGTfq0RVwtL9HRa5JzTifWsH5lzveTfkKdqH3RQbj8+M
 diYON7aT6wooOMqO0kljmUzsH/8ib06h/4o5q7Ke0kY27lcXppUcCQq2oljl/sbTHb9frtlxOCC
 alvMtkdsOpzQg5UUwy2an7Y6hHt7njRz0HoHKaG48KMalstYNGcrVSfnp/8WQOuxwNFIQKx13Pp
 PPAUZPDoWZwP4naEroyAiRNzxOyutw4nYwDHIxJ5qkiMrZ14ElJqt3rBp5G/CCOEFJ8tFn0=
X-Received: by 2002:a05:620a:1a0c:b0:93c:65e3:df81 with SMTP id
 af79cd13be357-940ef91b187mr316325485a.13.1792864557196; 
 Sat, 24 Oct 2026 10:55:57 -0700 (PDT)
Received: from
 runnervmtai0g.h3kajnb5sjwe3pjjo5i2acy55g.cx.internal.cloudapp.net
 ([135.119.238.196]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f067f330sm232100485a.24.2026.10.24.10.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:55:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Sat, 24 Oct 2026 17:55:56 +0000
Message-ID: <20261024175556.9398-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024162146.609312-1-rbranco@suse.de>
References: <20261024162146.609312-1-rbranco@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add tests for UFFDIO_RWPROTECT and
 UFFDIO_SET_MODE
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

On Sat, 24 Oct 2026 18:21:45 +0200, Ricardo Branco wrote:
> userfaultfd: Add tests for UFFDIO_RWPROTECT and UFFDIO_SET_MODE

> diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
> -	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);

Medium: On Linux 5.2-5.10, without CAP_SYS_PTRACE and with
vm.unprivileged_userfaultfd=0, the retry adds the unsupported
UFFD_USER_MODE_ONLY flag and returns EINVAL, producing TBROK instead of
TCONF. This also regresses existing callers such as userfaultfd05 on
Linux 5.10. Handle EINVAL from the unsupported retry flag as TCONF while
retaining the fallback for kernels that support it.

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
