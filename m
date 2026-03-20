Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A1F1093190
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773997087; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=7ofJ1wvh6Akl62cR2ybH4eZwBQQDehjzOr7yUhEWEbU=;
 b=cgZGqaqCsmpw0lXzqHNGxrPMnTPwOxOB6c385mp69Vm2KIZGY2fi7aPTxZT/q5IFHSaR+
 PX3YgH5cnRWfQO/sZg95O/kvYbXER8iW2bpswTTC6hJbrDL5OB3wA1zCtNpArQWrSWHKXKj
 WSroYokwifFqq+o5saitUjXfPqR9b1o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FDF43E233C
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 09:58:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47C7C3E1FFC
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 09:57:43 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D74DD2009EF
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 09:57:42 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso9215425e9.3
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773997062; x=1774601862; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=IBBLF/vv85IFtwNaYKjFC0FoqTF5QbnW6GXAAtKR/SU=;
 b=AOXHzXrPo6PIiG2dtkWbbFvPaCy74O3laTZLO/+W97H9SOIboFoZddGo0PEW2TrwJq
 C2ETk7XA5y30Q3CAlZ2vDCAjecjCuuJ7OFYM0Ncs4X9BoMI/2crLnfebWJkSREXpMyKd
 t8CaTTNXKBn9bJuaQ/DLZ5TUJMh2Lf3C82esQWoUouZJfd6WHAsbgfxNy5XrdBzUVHB/
 SY0yTO1dPYivDkT4cBScSPc8E+POqp8+JHV7nlMQ/SV2HOkF+Ie6GFL57omjusromXEN
 r72YKhouT4D96H0TYEERtQLoeh6fmStLif9vEpAhS3Dp9EzO/NyQJLA2H4pYfG7T1ben
 AwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773997062; x=1774601862;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBBLF/vv85IFtwNaYKjFC0FoqTF5QbnW6GXAAtKR/SU=;
 b=TNcAOBRLysuJN2YOQ1tpZD5OtU7pys1Mq0YG9fOyGzXG5FKd2QTjq95QVj8ILkw6mG
 8VAVPNxRlG59JS863Lwb2m+38XbWhKLCCoqSKARmjZoI+NWj91pUJFYJySzOkPIGX4b6
 QvrsYTj8yVKb1IaNsMWjfwgY9p+cK8plmoN5jXyHYzeZpCtfUmL7LC6ejO67yR6tu0sn
 P+ogoUjW08WE/hCVwioAm35eORZdq2tNSBGVE0NBp95Hve3cbNAbXt+fNcv4STxPfgPq
 XI0rhyJczgz/7P++rKDU4sGbGUvyr0khTxmizJvsiRr8Pj/kmbyqSNSkj0yISN4vGnlL
 zATg==
X-Gm-Message-State: AOJu0Ywp3xZz61BqCbLzgjrMyhdu7NmeSxkvHzF0i5PYq+SPaFu+hz/3
 tqlsHBmQONGyoCATprG6o+QNJjL4tv8+PUC8gQu8984BP402TgY7bYcHRlD+5cix9J+u3W6KQnp
 0FQoPTMIYPQ==
X-Gm-Gg: ATEYQzz3hebiA5l6hEEnJimU7CKdOxhDfzuunXn+0qNzd1pCODvLazXIin5qz+PxAlq
 Adb1kiITJ9Y5VXRUo6owDWe9rYjGIeM6yeDwt2V/DiqCkZkfhN9H7qSW219e4YEDNLmCSWPjWIY
 NIQ6xO0vUW/w9gSFRWQrV4/ZDg78NqqSujFCWOp92yKN0xTGyk6kpHkhsKT+5+WEEkXHArhJzFd
 1y3IzpelqdyFC8DdXCpM4tjREquZo0Oom6oPNDCDAXDrtmQS/G1odb+mfsdKaJbvr8HMuxC9NSx
 mUGJn7X1Ks/1+GDFMy6nauMHnU4jwoQx8yCd7Cdu+cMjWnQ/ZFj2vOo8M5EgiKDcL3ECkrOEshH
 xHeGMWllRFA9/auWv9+XwY2I7523iAhK+8tgTEYV+DxwmqzeaxnO+rmbsz4Jwk4S9ZxHen0GG5o
 U6//AbMptrkeooWSdoY58PTzjYKFjSkBUobnZac+mAyEyX+z8=
X-Received: by 2002:a05:600c:530f:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-486fee0f92dmr31007745e9.20.1773997061663; 
 Fri, 20 Mar 2026 01:57:41 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe7e3a94sm54410545e9.7.2026.03.20.01.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 01:57:41 -0700 (PDT)
Message-ID: <69bd0c05.050a0220.271ac6.1276@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260320075733.936817-1-wakel@google.com>
Date: Fri, 20 Mar 2026 08:57:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/file_attr01: Allow EOPNOTSUPP when
 attributes is NULL
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

> The syscalls file_getattr and file_setattr may return EOPNOTSUPP
> instead of EFAULT when the ufattr argument is NULL, specifically on
> filesystems that do not support extended attributes (e.g., tmpfs when
> CONFIG_TMPFS_XATTR is disabled).

Patch is technically correct but EOPNOTSUPP should not be tested int this way,
since we are not checking the underlying kernel configuration. For instance,
we might have xattr support, but getting EOPNOTSUPP and have a TPASS. This
would be a kernel bug hidden by the test structure.

In other circumstances (if xattr was our testing goal) we might have used
.needs_kconfig, but in this case we should use a different approach:

- we verify at runtime that our kernel supports xattr via tst_kconfig_check()
- if kernel doesn't support xattr, we expect EOPNOTSUPP. Otherwise, EFAULT

In this way we make sure that syscalls are raising the proper error according
to the kernel configuration.

WDYT?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
