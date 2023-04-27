Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2C5C77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 17:43:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C87313CE94A
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 19:43:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A1113CB1F5
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:43:17 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 53B0414001E9
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:43:16 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-63b656aacc6so9716800b3a.3
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1682617394; x=1685209394;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=twHJrueOSSysmLEpViSediyTN+BsUqj4XGnG4PuBmg4=;
 b=Y4u3GXpDoNzDb3vxbTV0xbyuPvqSYCh5bW/b+zx5wSriDBmtwVW8vBbkxLiU/WEZfP
 euUq5nZAtw+nT+uGxAIfQhccAJVmYsnVZMAby1Ah7s6/X/YMuL3hJ/iqoKOuPDNiLvcH
 EM7GuecoumxVvY3hepqI8ydGMU5y2glRWkZGVhOvNk7MN1JRX4hlsZJxrnyHL5erxHhJ
 1Fy83HLIgPIzSIHYMvkheWkhs49UjtIrAJjix7NNZLOznHLHrfCAmxn2+x2JMJlpChl7
 Ic8cWwlUc5feQfZl3KLs9GdOA2/r0ocgoZKdylHXPO34TA6qzwtuZUfFpOIwa3YvKSup
 AuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682617394; x=1685209394;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=twHJrueOSSysmLEpViSediyTN+BsUqj4XGnG4PuBmg4=;
 b=LqsmNAIYg1SHJlgkertcqPbygbGA+gc+AS2Dx/gO1HcOdMm8WyGxTpyvmjskuuRA4y
 sryaxDFHqhj+gWQR30gOGXXGYAN3r6KRJ/5Zy749RHZWEdhP3f22HnAW46cHBGrwdRd4
 bOLMqQS8KCQc1xR8B56u3EwWctScYbQnrTI9MvrMX5YfTebGO6dEoDa8emCepwCQxtqY
 jrfnrDY+crAtbHkTPp7FDORSohH/h0qK3TgrWPI9DY/B1bNtN3IH4qNcVmwIfPTCW+pP
 PxxAfy4VMV4n1IBbbix4myXtZf5nK377LSYtrF0CdlP11SKZAryyqJxptzMmurMQAC+W
 u8Bw==
X-Gm-Message-State: AC+VfDxWQxAMf6FvqNuYf3+wOp7z9Ka839k2Z1+ldhGJ79yXhC/3Vw8K
 6Ewt+YQlcNX3bryB/vaJx0eZbtfWOcAWeBkx5gAgallGUkF3kQ+6O/18w1E0lXkJKLXtRFmk00E
 jgivKbXGOx3WOBR0us+SLyTmQNawrp123dwqPb+hzjWzjyuzs5iL8sPGp
X-Google-Smtp-Source: ACHHUZ5/Urw9glm8Xu8nr3MQ1G4rotwmBMI3E0wWXOdDckASA0uWGQ/usDNXUGo1hecVx1Giq2lyQlocjm8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:d53:b0:629:f9a2:64e6 with SMTP id
 n19-20020a056a000d5300b00629f9a264e6mr652040pfv.4.1682617394595; Thu, 27 Apr
 2023 10:43:14 -0700 (PDT)
Date: Thu, 27 Apr 2023 17:43:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427174309.1479093-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] fcntl{34,36}: Fixes for Android arm64
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: 7643115aaacb ("fcntl{34,36}: Always use 64-bit flock struct to avoid EINVAL")

In Richard's commit I think that he had meant to write that the flock64
type (not fcntl64 type) had been removed from some libcs.  I believe
that was the reason why he added the my_flock64 type.

On Android arm64, this test was breaking for two reasons:

1. The my_flock64 type definition did not match the expected type when
compiled for 64 bits.
2. The test was mixing fcntl and the flock64 struct when compiled for 32
bits.

Both seem to be ok on x86_64 but not on arm64.  To fix it, I gated the
compat function on TST_ABI64 instead of tst_kernel_bits.

v1->v2:
Updated commit description and cleaned up error message.

Edward Liaw (2):
  fcntl{34,36}: Only use fcntl64 with 32bit abi
  fcntl{34,36}: Use arch dependent types for my_flock64

 .../kernel/syscalls/fcntl/fcntl_common.h      | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

--
2.40.1.495.gc816e09b53d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
