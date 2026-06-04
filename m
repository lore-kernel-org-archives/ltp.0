Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AEACD6E77
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 17:57:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 871343E6199
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 19:57:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47D743CD56E
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 19:57:18 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2805A2009B6
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 19:57:16 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-91550f68089so108835485a.2
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780595835; x=1781200635; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bctekbIWoOjTquUj4m0dfE+lIwqM5e1loeRTVK4ORpE=;
 b=AFLXv6DoZpA2/ZioTTa+wMoemjJfApNCnu89Xzs/Reu+dDM8AnjS+Z3IjGxf/09RGG
 X5JdTVhifV05sW5xg0EPMM/pD5jVBvTx47i4B2GpSX1iMHPeX5CQFVTwr28G+KHz1aJn
 qrLA/+IB0o5lly6TFgIoj8ZlzMIipP3fGf8JKDjGhpCs3g3PrrRTr/BcejRieKRgK2Yx
 aSztMF1s6QE2yi8+KV06Q/J7o3m2G3Od8jF6FF5325+fJvnAQT5ORrSuTUYrb4KFdJTS
 mbUrdVpgFHlDC3ehV95x93cEFAk6yrE2kif+WW/XQkNS2FDaxx3Bnl1cYiqrCjifaqEJ
 bXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780595835; x=1781200635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bctekbIWoOjTquUj4m0dfE+lIwqM5e1loeRTVK4ORpE=;
 b=bkQj8y65n0QGrdRRbB7calhrUNIX0E2IgMbSsWke51LLW+/Erj0cHrr4f+OfyCDfDd
 1UzmuzWGgOLH0D9vtGf9WqHYqBVFsMjdUg88/fhGQA0fOVcuZfVny8097PLGsBDDmRCL
 wbkL19nNRd9ECfpykSyFe5z006n/NOLack5YYDlcuK2YqfmvrrK9EU7pOd0acCySzXbn
 AQqTmSgaY3QjGCp49XYbuFiHDrm5slDsxa1PHu+6xA8fMnyiTwplDN0cfGq4lBHM4m3K
 N6lOud9T4KQE2vXG5BujKr+TtSDWh9DqSDyxH0DawNB2+JxI92nAxWp4gpK3lSCVmsAH
 W4Ng==
X-Gm-Message-State: AOJu0YzzF4z9DSERt/Zak+3YaVW1TkGS3gFSV1jTEwh4RpGN0b9P4g5s
 yKAzaopQaY+FfhAhYw/7CxbSLJbHEnw9v+DWYD34pqT7UGiaBc9DO1rC
X-Gm-Gg: Acq92OHOJWwCiGRiALeXU4enXXCMImeMOClwqLUNU7rUrOkeQa18rMKiOdvOIa1CqUb
 AXKmVNxXBlg2jkgyvUTNnIXw2EOH3yCKibWE9uNRSDQwSujX0qQibiHQpWLSg/o0QRVd3b1DDf0
 HUgIdh6g0nqpLoWN/2qY783evmaYkt+OXiLZ1uroDGmb2AfkTwtqjQTYyfl7yaaOxb1mx1i7b7J
 YpcLDPj46uPNbu1HLvzHG6zR7YAdx5zll2Vpu26jtaDZFtZ/Sk3a2FhpG57tNKbRKyagNFlw2Nf
 2seomwgMbgas+HjzXlK9yJE+C7h7JpQ3+jpfmleUe41SkJE0Q2FgNwe+rfgI5/cciO1HqlkfZCl
 kjDfvU1s6klZ7iqnIlHmge43VM+qtu2zXiYgMbC47DHkBTeLZfJiLiaRRmSmSrp9Kk1CUlaQ5Qa
 5eJuinHhL6HZi/E3OMnqH1IDT/kR1TlQb47U1lVT/b6HFpysXwCCDp9R2BRD66VBmfuWqA1BcYL
 8i0F1txx27Shup6V2ce1i2aZOmWb6avtRXUal8nqX33Qss2/tc=
X-Received: by 2002:a05:620a:460b:b0:915:7f4d:8642 with SMTP id
 af79cd13be357-915a9a4761fmr46114085a.0.1780595834900; 
 Thu, 04 Jun 2026 10:57:14 -0700 (PDT)
Received: from
 runnervm3jyl0.s1jfbgqwn2qebkyxgm3fhys44b.ex.internal.cloudapp.net
 ([64.236.142.151]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9159cd628f8sm303684985a.4.2026.06.04.10.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 10:57:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Thu,  4 Jun 2026 17:57:13 +0000
Message-ID: <20260604175713.3951-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604150643.3433-1-always.starving0@gmail.com>
References: <20260604150643.3433-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fstat02: Verify st_ino field
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

On Fri, 5 Jun 2026 00:06:41 +0900, Jinseok Kim wrote:
> fstat02: Verify st_ino field

> fstat01 does not currently verify the st_ino field.

The patch modifies fstat02.c, not fstat01.c -- and fstat01 does not
exist in this directory. Should this say "fstat02"?

Verdict: Needs revision

Pre-existing issues:

  static int fildes;

File descriptors should be initialized to -1, not 0 (stdin). The
cleanup guard should use `fildes != -1` instead of `fildes > 0` to
match.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
