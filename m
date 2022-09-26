Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC786C07E9D
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 18:26:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AAEE3CAE03
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 20:26:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E73E3C278D
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:26:41 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F18F1A00719
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:26:40 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 pf10-20020a17090b1d8a00b002037c2aad2bso8164762pjb.0
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date; bh=l6YHfZ9MHuX9l3R3Aoh93GAYWPlXZX1VXnRAwoArBwU=;
 b=FdUlMoev0jvr19bw3goCOg2crklts9nYbJe49SUv9dqhpVIiIdEYM/gBZWqYl84O99
 0+60XX959uzTQ8rDtSVEQX3P+LRPAlR9FpjoFsLSbWvxGRHEDbTwuzyGkkltxiojYV80
 LWj94OIbnsyLHV2XgrN5FssEzy2qi3NlwCfj6f4rtpGpffpxbdJD7lroUcUeS7PfE6qA
 TqROGr+pEL11TofZ2F2zp9NlgD+SVMtYuvFZwWJKeqKk1nHiE5GTBQ4FkQjQgfIQx3DR
 TglnuFp95UupBVn/fDQ94FajOpn4YpsnzjzT1SBgx+oGf0BF8GYEplGPu30SU2+VSBgX
 /vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date;
 bh=l6YHfZ9MHuX9l3R3Aoh93GAYWPlXZX1VXnRAwoArBwU=;
 b=iR7SqNg02RJ8b+Kcwi2xu0amveZgGuyg5Y2GOMQHMcVs6jlRUv/IvUr3KhssmBW+tR
 DdEH4T3lvvGQpTPS1ySh8qm1r8u2pcjqi/bYQfxBviiuBW+K55twWn48vcRXXf64K0Gy
 cvZGt/HIpp09f6FCmLSG0Fbw+66kTXXNdtHp4PzLxeVHdDGiOwOugZrzxKECfII+QARs
 Rw6J27Gj8ypXp08X0vPIYWyt8MDMLdGcDdtPhiZTDqK9wDqTI68cQorDGTM1wFS9eGr3
 ZPdvbx0wd94tAk0Z73TJN/UMpvOeWMCjIbtKXsyLv8mUVRG0fP4v7wKklQx7m2OZ7/Kn
 kttQ==
X-Gm-Message-State: ACrzQf2Er9VqbDwCHN2U6vuWdmYhBQh+OdOyECjvuUkLSDeChPqhAGYM
 DNmwevwxz4YPTkaPfQZ7Qp+5KOlfskFN/jZraJEr0npPdfJzCAMneKfrU6IaOPQ3lVSdlvgKKAr
 z4L4s9Wytpsnqz7vla4/mpequOy1XGA4UZn6+nWp+g7OPiyRE8E5ycqJU
X-Google-Smtp-Source: AMsMyM7HBDNZfAo4Na1x/Rpp7qZh3ZmBYfsde547i2FcpaHH+EtT3NnlB3mc85puI01wscA1lI8zX2Es9ns=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ab5c:b0:178:37f7:6a55 with SMTP id
 ij28-20020a170902ab5c00b0017837f76a55mr22774572plb.45.1664216798059; Mon, 26
 Sep 2022 11:26:38 -0700 (PDT)
Date: Mon, 26 Sep 2022 18:26:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926182625.103275-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/4] mmapstress01: refactor to ltp framework
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
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Attempt to refactor mmapstress01 to use the ltp framework.

It was using LARGE_FILE to switch between 32 and 64 bit sized off_t. Is
it correct to use FILE_OFFSET_BITS instead?

Edward Liaw (4):
  mmapstress01: refactor to tst_test framework
  mmapstress01: refactor options
  mmapstress01: use FILE_OFFSET_BITS=64
  mmapstress01: use safe macros

 testcases/kernel/mem/mmapstress/Makefile      |   2 +
 .../kernel/mem/mmapstress/mmapstress01.c      | 624 ++++++------------
 2 files changed, 212 insertions(+), 414 deletions(-)

-- 
2.37.3.998.g577e59143f-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
