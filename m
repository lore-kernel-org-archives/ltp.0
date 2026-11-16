Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83B606A332
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=pYox7q6D;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aIwtBHu8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794819394; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Jsky6MuJ4C2MgvS1KPMww3b09fJsoXIDVqQXJed2OYo=;
 b=pYox7q6DOrGHlYqwAhd1PMU2y/i1xp1ZSK77HHgibzMYz0UEjQjIUkJhZziEJj8zXsaU+
 skZacACfKFQvbjX7ZGfZXSuctPKEGbVHa3pfsnprcNBBH4ozHxSurlvvQDkqdXI9stCe8D2
 BXWpU5jZ81vjc9ZTsvYG6JERGiuvPEk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 321AD3C3078
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 09:56:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD9283C3078
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 09:56:15 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1CF28140007E
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 09:56:15 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso3046255f8f.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 00:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794819374; x=1795424174; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1XeLHVFWNCOGlaJ7oD9p7tcdVEkaMDSdF/cgkvKi5zc=;
 b=aIwtBHu8Y8F/5XsEzESCAICdXlLo6Knztn7+NxyN7U2A+tw0O5dFQ+2LtNi/7Ca458
 6huY86Njhjgns8bT+PWvUF0Sy0YkqnFKHSjpNe+oOc/ei7wifK7dlaE1XWFmk/VDiFrM
 +hgZavx/a3BGPIBmUvkYREN8hIgoCCelwr6ehiAZCsLUnlNS3oWUMaW+f/nl83QKTd3n
 +BUVKVdVFf7QiwlKL7M35bj1+DEDqs8V845iviuO2AHGwr5Tr6eUs7rNvzqFELAk65ar
 4MhQOOvhzVq5etvDT5wRQle2NLpaLJ5U1+TjZig2B7HOE7a4WiDl7s/pAhPLPk9qLYO1
 ihHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794819374; x=1795424174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XeLHVFWNCOGlaJ7oD9p7tcdVEkaMDSdF/cgkvKi5zc=;
 b=X6CEMNfUhvaiMi926TtmPWmLFJkndbeS9LmmqLtBgpxs74ZuW6tiXO4MTcvIjZhKTZ
 W+/i6DLEkP1bwr2vOq0ywWlqikE0TNxWtIMZyFl97093d0DUNC79Kgtcw/tLBYHhVD8c
 SbhfHdHFXw9KnBUGqgzDWFI1fcqjRVACIPWJ8jiVWpkmHvF0GqZWBnAXFA1LNwmbUVnC
 e3yBaqthu8oesbAPtt01Z7oG9NnT6JbGeB9cnzSKUliHILv09j0PzCDme4DP1VsZ8OVl
 TaPPjD1fWp7SJP3+GbHyFCJ8+TP/MRWhDm5EmizKI18xomFDiZCaFT+DNWvi5nX1MGvY
 w3TA==
X-Gm-Message-State: APuU4Z8ES/VXFttNCXSM1gdDR0i2pebnopF6fixApTwH2H3880B0O0lt
 bokU6GH1qDT1TiaVk5AM1cDUw6/hHqC6OJIrSiUKHD36dt+N6ZzMjEzPBTc3J8kZylPa82c9YkG
 YwqH1Jv5B
X-Gm-Gg: AZFdTZe8U+U0KwgMd8kckoOnfJL62o8rxcADk+hHnV9om/mHoNdeybr2C3Ij5ucb5DH
 i2HhbXGfnJJt4UBUTxxxiSoFVxXXBWf7aXIoQlFikzOBpp6n4tVTCkd4BTXUdDmoiTnGRkWgq3j
 QrcJRW+HzSHHPnZKGdtmEMaJQEsJ+PHHtAkKJNXwDpjdeyQ8ZbjFKRfwT6jm5TUSXZqmdXGWlvd
 lzvIyteFJnfbfBX3jxA20jW/b7VK9eMK7EoU1btqxnQ+Tfdvexl8BIKdOrV+k/vv88B22IZTFuq
 sSVhEFZA+XltDd9D3n0Lxj8Bxtsq3wtb1Mzv10wfDla0eefAVZBiIajOaSfIILoQjQ64v+G+9lI
 BQhKK9XFYaGqfTHXmxiZ/DHM9iNHp/zVGvxiyHM4vnlpjbuOzMyKYTYa1oRW2CxDvOOF03lYss7
 j5LoOTClNZ62+Td5k5hUz3vgvYlsvp1tuWC3C0exigKotDVT2BnL3+B+0c84gdz9OjnMH//8IIS
 QoDXtzb+e46iJbmR1YzOzV2Nr8AmzOz/LDGNakSfGntPIuVfpLYrSMuXOShmqfVeyqhwqBOQ8eH
 ZHxFaUf2SHt37cBylvdbUSRn7JXP6K3Q6dqwzKWHST07RZxPUJtfxvAE5x6KGQ+kcBxF9ojAqWR
 /Ej3tzAxtoBgCbKEvgH+BsAxFQ/8/loZdtw==
X-Received: by 2002:a05:6000:188c:b0:48e:2448:ea23 with SMTP id
 ffacd0b85a97d-49c720279f1mr20209425f8f.55.1794819374485; 
 Mon, 16 Nov 2026 00:56:14 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-49c605e4a2asm20452836f8f.39.2026.11.16.00.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:56:14 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 16 Nov 2026 08:56:03 +0000
Message-ID: <20261116085612.20171-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v19 0/3] fsconfig04: Check FSCONFIG_SET_PATH
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v18->v19:
- Update tst_attach_loopdev take the file name as ONLY parameter and return newly
  allocated string with the path to the device it was attached to.

Wei Gao (3):
  lib: Add tst_attach_loopdev()
  newlib_tests: Add tst_attach_loopdev test
  fsconfig04: Check FSCONFIG_SET_PATH

 include/tst_device.h                          |  26 +++
 lib/newlib_tests/.gitignore                   |   1 +
 lib/newlib_tests/runtest.sh                   |   1 +
 lib/newlib_tests/tst_attach_loopdev.c         | 145 +++++++++++++++
 lib/tst_device.c                              |  82 ++++++++-
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 167 ++++++++++++++++++
 8 files changed, 417 insertions(+), 7 deletions(-)
 create mode 100644 lib/newlib_tests/tst_attach_loopdev.c
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
