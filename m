Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB72C433F5
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 18:00:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 677AB3CAC01
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 20:00:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9713CA765
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 20:00:05 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5B0CE14004FD
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 20:00:05 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 r7-20020a632047000000b00439d0709849so3255934pgm.22
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date; bh=n0u4FG9H8YOe+nCIvtD9gmb6UIlib/jsKeEGDGG8KmU=;
 b=oUCkuyxFOg2ebLltXoGcAqFWrqZn7tuNIaWtNDCw7edH9ML6idgFDCLHNbxP80ebqH
 Ez0pTrb/PztLH/LQ6xHr0JOJwtzoKipXMJ5VhCuFRbNAb2LATkRjIiplfjvTfB2zQ7Zc
 9I4KU5zj6SCMPS3mpvhFXDO8b+zgNWLClNKX6Pg4ROTALTYpJxC/CeKmpQAj6G9iuy2L
 jqgBhLnc/p//qM1XpORBykxbas5eUYns2eQMVxX3eY1JbmAkEoZlVXx4sW2MaxNIV25z
 jP7HFabAWgp4pwck1JtQCCnR7m6DUFwzGdx82gW+HTuvnMzBtSf9NQXipVq0tmBYJH8f
 LbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date;
 bh=n0u4FG9H8YOe+nCIvtD9gmb6UIlib/jsKeEGDGG8KmU=;
 b=c5crGkOVOJT5rEa6xhv9kr8etYxQUzfrDE0gGb1vbDVM5WmTVHbhMiBZ9bbyRpMqBJ
 HpVipPKNfHQayyBzp2N5gD5IHqfJtuJxOnGGhccqJAnMLd5ujM0E26NnJ1KBcDknxMjy
 qpx9734doTn3yvC5A5TUAyiLUtcbhSur6b7CcdwjguXLFT5k4A5zhWWjYmSn/hDzrO8n
 6oCLtKKXJdvmCEYZpz/uUrSQfuPz6M996ivDuZnAA2HJv4C8L23ZwlPXbCVJk19dUd9B
 IAHJIdRCN6NEZ3hXhcgHfDMdFqZUTrZM3GG4FO42Vv9id3tAo1ta5U7cJv3XNE+Tw2hd
 CMVg==
X-Gm-Message-State: ACrzQf1eHkeNLan3mA09yqSFxmj4hvyeIjBJWiaEcD2w9qOTzKM4X5NA
 7ZixMYo34vpmi8Gq6LjA+n8oHbGjKvIKgNGtfjQi6v+/TyM3eDXQVin2ZkANK+olN0jHZ01ApCK
 6m/a+83c5cmFbjYl9DjAubbrcUB9if5oF+daC3ecYzBjGxYZpkN6XquKo
X-Google-Smtp-Source: AMsMyM4NbPwnJ7+8/8BXw/sroNYgPau/Hi5XQJMcShhA5uPd4szOdVSsSCPszc3TF1OqAG1ybnMIwOf3SH4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:808:b0:54c:40da:74f3 with SMTP id
 m8-20020a056a00080800b0054c40da74f3mr10381233pfk.62.1664560803441; Fri, 30
 Sep 2022 11:00:03 -0700 (PDT)
Date: Fri, 30 Sep 2022 17:59:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930175959.3955586-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] mmapstress01: refactor to ltp framework
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

v1->v2:
* clean up formatting
* remove accidental change to header comment
* use SAFE_MMAP

Edward Liaw (4):
  mmapstress01: refactor to tst_test framework
  mmapstress01: refactor options
  mmapstress01: use FILE_OFFSET_BITS=64
  mmapstress01: use safe macros

 testcases/kernel/mem/mmapstress/Makefile      |   2 +
 .../kernel/mem/mmapstress/mmapstress01.c      | 647 ++++++------------
 2 files changed, 226 insertions(+), 423 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
