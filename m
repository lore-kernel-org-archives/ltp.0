Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACE9CD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779720290; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=SzydgkHyDovH0vnfCWh53WPpGtlprj7EmhHdiFAb+bY=;
 b=h6rLWKXsR6csBoDcI7aqMQIfYpTub55mvJGK7QNj6wb0734NxWDdGYb5kc5+k52rV3dwg
 DnwcgwZHrCCLRMAymyQCiziRMzFLfpchgy3nkJeiShomUnpSEwq9LS/MaITwGuGuHMc1l/0
 HDTPrQiNdDPMLiHoISthfYbJsF3c25s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CB0C3E62DE
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 16:44:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EEA53C02F8
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:44:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B8FC51000772
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:44:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779720265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DdO6ivWh1UbBuYEAE90JM8+2yCiENSBpEBPlI+8SG6g=;
 b=Kqn5VDTFXKR+NvWhvBJh5Rdyu1ts67UL4k/HhJ3HMc75A3j+KFJu0AWxG+CfikRjQ59PRL
 mFctT+lLY+MpvTJlRoRk7gzWgsXwXtvj5avo2cbvvm0i5mxte8qGAnLmzx2xIwI/1K3NGR
 cGIFLc8YGvomJ9mOfvVYtAIpGhOQNHs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-K926fKc7Nv2kIdFn3d8mqg-1; Mon, 25 May 2026 10:44:23 -0400
X-MC-Unique: K926fKc7Nv2kIdFn3d8mqg-1
X-Mimecast-MFC-AGG-ID: K926fKc7Nv2kIdFn3d8mqg_1779720262
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44cc3c9b2feso8531315f8f.1
 for <ltp@lists.linux.it>; Mon, 25 May 2026 07:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779720262; x=1780325062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdO6ivWh1UbBuYEAE90JM8+2yCiENSBpEBPlI+8SG6g=;
 b=OYl7z8UWT4HoKIQAUUw4BaKqvD10/DVjM6B/2XR4YRoAFPKrzb4htd2/j+2CXgqn4a
 J5ZIs7R9csbbTz9dGqFPcCmmDrZFNxHRsP+HT/Bj8fnyuCzw3IpH6Ce8wgeHFJHa3fxt
 eA2YgOrHJfnZa/9mBEGMQRtohGMSTPlfuCWUTyqyMmNJdvgbNuygsDB2c2nUe5ioYXik
 oDH5Y7FuO9svLrLHztqOlqzBH5WNnxucrCXh+B2XWV/tCRXEY4jAozwqdCqSUKkSUhr3
 6WiYtTTuinIYz1ZuiZgRDWngKCotJnXJOcy2AIYmX6Rf29z4rhki/oQ7XWB9+5xphSOg
 jKJA==
X-Gm-Message-State: AOJu0Yylx6Z+Aj/3bo3BfiVLqRIOyjNg5knVQFnCzTvxzrpIeG50dFla
 3X4SnewOcszg8O5jRbBVSDhwEJrFqSVMudsPPD75GhGqoacSjaQz+pGULCqIpW6xxstCtQWRlKO
 hutLDJb0nO4KkzVjLYITFlTH61C0Om0z+kOGX/CuV9TIupcvodr7iMjZRcCuHMoNbVhZ00FgH2S
 fj8nvkeZt4wZ8IuyPfn/GDT62vfjJZLwBcgmZr
X-Gm-Gg: Acq92OGwFORyTpi2bbBjWym2TsRsPG8/taoQkFK1/87OnNHIy6CeGlJU3E/oBlMXnES
 x7lIXcQWgmqAP0WvRr9WUrHuxiuiCKhV4vw5ElmQwREfa25dM8FrsHeC1RaVY7judeC+vW9Ta94
 owCzk7pQNJZ1eEZDFaFUeAJFpS3B5LToOlcG3OAV0m5rW7y7p4eulb574GHu1bGiNPmmHcR5SsB
 M5d35JjcwA0I9aS5xDaevYoDOb07aqlymQZKBSL7C9dNsKjDFhKwLXNBE/7mVZhrX3oBcRwKLhJ
 n5+YtMJ5g50vF+FjMsPeQ+5ta23gCdSj7VuGs9dZX9aCHvMH6Ng2dI3YoPzxXlLEWSuioyPSr48
 pfwapxLG/e+pvUrCT6DCLIcUh26qeid5Nx3Bm2cschJMy4l10tKpoduA3s+mzj/PUMCkRfUbh
X-Received: by 2002:a05:600c:4e4b:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-49069da61admr38907275e9.15.1779720262310; 
 Mon, 25 May 2026 07:44:22 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4b:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-49069da61admr38906735e9.15.1779720261755; 
 Mon, 25 May 2026 07:44:21 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6ccd211sm35116518f8f.10.2026.05.25.07.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:44:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 17:44:13 +0300
Message-ID: <20260525144417.23327-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: drGzLTNpRG0m1mM_Gzq-gkfZWlbgz5SRiZoYVhYOEG8_1779720262
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Improve error handling coverage for futex syscalls by adding tests
for missing error conditions that were previously untested.

futex_wait06 verifies EFAULT is returned when uaddr or timeout
points to unmapped memory.

futex_wait07 verifies EINTR is returned when futex_wait() is
interrupted by a signal.

futex_wake05 verifies EFAULT is returned when uaddr points to
unmapped or PROT_NONE memory.

futex_cmp_requeue03 verifies EFAULT is returned when uaddr or
uaddr2 points to unmapped or inaccessible (PROT_NONE) memory.

v8:
 - Move runtest/syscalls entries to alongside existing futex tests
   (after futex_wait_bitset01), not under the kernel memory leak comment
 - Expand futex_wake05 comment to explain why PROT_NONE triggers EFAULT
   despite futex_wake() never reading *uaddr (shared-futex path requires
   physical page resolution via get_futex_key())
 - Remove trailing blank line in futex_cmp_requeue03 setup()

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 95 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 75 +++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 87 +++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 87 +++++++++++++++++
 6 files changed, 352 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
