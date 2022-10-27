Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28DDECAAA1
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 21:00:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0696D3CA941
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 23:00:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 324C43CA90B
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 22:59:56 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 52F97200270
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 22:59:56 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 e12-20020a62aa0c000000b0056c12c0aadeso1432052pff.21
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tAZXQDx7t2/Ffugh1y3IM7u1T4t/JnfGxi9DGgqdE0g=;
 b=NBRnlRnVOw4UjCBwbp/+MAfZDfBb9qu0O2QX3NGyPvPb3IpsxKrUeIUvUMLz4c48io
 gtJtIEkFbisPZlLdAYXxEV0tOJs43Ebiz0mut4B2vnbUx/31dI+FSLEMbRnzH1v1Aaod
 /9cNuK3UZJatExb0Zjb0PhrEbCtCFCU8s2V8gb/YsiPuB+AnV0VE3j6v/ExpZOQCcKkO
 DaYxgFNj6P3aO5/powf5q+bpUPAzfuWq74cxjvyZzPAkqoQa6J31cw6HKvQqcBnyhIxT
 fIGRaghSzOv7Sh2a0ITo1PZpuk6M7i9jokSq3f2EoY8ypc8gm89PMl67+6/hWym0bC+K
 RtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tAZXQDx7t2/Ffugh1y3IM7u1T4t/JnfGxi9DGgqdE0g=;
 b=hWj7eKVmyA1cgGOtn8Et9IEIM19QcCyTF0MXOojRa9xoLBcYt5mpJVGusOEoojUVbo
 2h6HdsJIHRMsEbCNZDrWpymp+/+Fqz9i3O779NgBzQaal/DKL0XljLEs3m0WoSf/nHJv
 1sCxt9MmEstzliXrg2G+DaExs2UXd36uMw8ebY9BvV1g0sofzC2n+eTY26f2siTPZ21V
 cLVzqVQN6HjqnJ6KmxITPmSv3WSep3K3LjJeqkQDix7yj3RxwyQNvRsGOfBTZzQvLE42
 o0VBciqQSTtJdZR8bdYBbbIDd6PtESMvS17X4vzwVOl1u0TdNFOOT6meyruz62sj77ap
 zpHQ==
X-Gm-Message-State: ACrzQf27ZJnFqLVikGNmf/iNp9QacqKjeZGFiuRFVSAw7XHZBU76LCil
 OI+PrY8kDLKIKw88PnXvb77wPrD5EI+/AmTueBQLUMF1wCK8Oanaj1V9paH4HFeLaNab/E+/vx5
 e3WQVUX3NEzfd221ex6koOw6uZh3PyzM+5Jz5rvIANcJ+vmybAIvj0FRT
X-Google-Smtp-Source: AMsMyM4FfNUfysZFP8Q4yPwb4Q8NLpE+Pk/om7HmbbL6Kc3FEPtCXleU/OBNwns/diRRQxohzKTbqHtWcjE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:3141:b0:20d:49d6:30c with SMTP id
 ip1-20020a17090b314100b0020d49d6030cmr11907812pjb.175.1666904394656; Thu, 27
 Oct 2022 13:59:54 -0700 (PDT)
Date: Thu, 27 Oct 2022 20:59:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027205948.3718466-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/1] mmapstress01: refactor to ltp framework
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

v5->v6:
* revert pidarray removal because children use the array index to
determine read/write locations
* add option to specify pattern for reproducibility
* set default nprocs to ncpus with range between 1-20
* remove more comments

v4->v5:
* reformat top level comment to docparse format
* reduce amount of verbose comments
* clean up file size bounds definitions
* make finished variable volatile for >1 retries
* remove unnecessary pidarray because offloaded to test harness
* remove unnecessary sig blocks

v3->v4:
* squash previous changes
* set defaults of nprocs=20 and max_runtime=12
* clean up comments
* return TBROK instead of TFAIL for unexpected failures

v2->v3:
* apply make check lint suggestions
* refactor cleanup
* use SAFE_FORK
* update license

v1->v2:
* clean up formatting
* remove accidental change to header comment
* use SAFE_MMAP

v0->v1:
* use tst_test framework
* use FILE_OFFSET_BITS=64 instead of LARGE_FILE
* use safe macros

Edward Liaw (1):
  mmapstress01: refactor to tst_test framework

 testcases/kernel/mem/mmapstress/Makefile      |   2 +
 .../kernel/mem/mmapstress/mmapstress01.c      | 890 ++++++------------
 2 files changed, 265 insertions(+), 627 deletions(-)

-- 
2.38.1.273.g43a17bfeac-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
