Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FAACD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779874010; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=AG6hIhgBLb5jIX3Z3Zowpc0FiJZPHxOwFPQZJW49w4o=;
 b=Els8C+IIEONMSnTbUD6rwKs3rW4SYQRAn+G141ERLnhL4vjQkUegjNZtFarcUHQIXu6eU
 qOBP46oVKIj3p1McGsK4MLys8/HJnVRFJjhIveQNjyz5iApRTqeBjfoNbtd3Z5+sRDjWz5u
 Oay87VCaeD7+AtW1LH5S50W3tHgbBCE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33EC63C9EB3
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 11:26:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 588B03C985D
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:26:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 88285100048F
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779873984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JeKaepqL8yJ9qefRI93i6aqQrzIkMHuB+8ALLH03kbE=;
 b=PE+Yt1kylqJAGN+zqJAcz7kfCOvEHvmWQPsmhoo013K8I/cdCBVbSgwRQIZN8BjODjHrtG
 s3DoqE3KIdhYdPkJQB9Oi9Yg0pxv7pC3kqtKAQzh8rpKnAWEBa/0J9/n3Xf+/GXKC7+ilD
 jTVi1tZz+/hKq3P+bcJ2PtfX8xiElHU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-DEQIadydOLmWAorIMOzDGg-1; Wed, 27 May 2026 05:26:23 -0400
X-MC-Unique: DEQIadydOLmWAorIMOzDGg-1
X-Mimecast-MFC-AGG-ID: DEQIadydOLmWAorIMOzDGg_1779873982
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49041d39887so39205935e9.2
 for <ltp@lists.linux.it>; Wed, 27 May 2026 02:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779873982; x=1780478782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeKaepqL8yJ9qefRI93i6aqQrzIkMHuB+8ALLH03kbE=;
 b=irb2r/314BHd3H0cIHM8oo4V2Fz+A7gE8K5NSAiOGVgIpBHlsIrQM1M5w61Hq1+V9t
 tm7BUU4bRZMn9H8pjmvXUrTZ0bdqdoKRQPmbKu6+XCk/HVvL3R2PQVqZViENI0HFWlDx
 xi1Foc0m5ciU3O5FK2S40oFxUhkkPISeMpS7flfva7z1FcfFTit064qTQPeXcPHtLJFH
 qanNx0KmRZagppZVNh1K1HebL/8rPlEc9O33CXdvMjWXFY7kJSUkfCaxHtQK6erf+n85
 UF/bx9I4O106PTMMwi4D0yPvtJwkBgntF2Qur+zh8+zs+1il3OtgUgUrHSDI0cbmlkAh
 98tA==
X-Gm-Message-State: AOJu0YwoaqXWdAxLCNA68xr6gcZNN35cWmFI3ekXqVBgfQl6BQgiiaLz
 462Rj1LU7B6rhjAS4CfvPo/T0AUUV7u2nhyDayu4YCxmVR/CQbiOqEZ1p4odZLaX5eMtD89gRHD
 kKq9XMEGh+dw1x+fnudQwSq4s6vsAeu0TuP7L2rX4f7NED8g9/CpJHGekEEnFA4K5fvJZpynLY4
 2PWNsxDruyOcJCQcyP1/1MBU3a4lT6yjz8T4MU
X-Gm-Gg: Acq92OGZ1Pd1Gcd524V3e8jJEsIe7Ve5xXcOms/TEb1pqKtLuPgcZVaf5RXFPdshjTy
 nnJoHmtJMhSNqsYpwCLPKNjvHBnCCUf/DlCdd3qSua44Rn9UrY2eohDeJjym1DFPoX1s41YvbBO
 9vc26ja8SRMwCSFQPcYAWHgS6i6K2ld8XsTXF1r0qgX0CfuJfrSBMFed93BsxKwo9jM+2JNagPj
 XzMekpv2wdUP0v/yVB3Vmox1wXYIHHSEWqi/yAB8ULgSWr+QuxqrnxFsSQ2mznivTxKDg35ctjl
 iL2SAFH5fcpI7fv3b94l5wxkcTXK2vUaB32t4ZzeZhQRRKN9vnypch9acXfQsp49yMpZNJXU+SR
 I4b8dGljcva5L+dz7IZ6fCjRLJlZXEXwdYREf6N2yaRl2jq7OPqNHI088rpL/mA==
X-Received: by 2002:a05:600c:35d6:b0:490:4973:91a0 with SMTP id
 5b1f17b1804b1-4904973932amr344514345e9.10.1779873981809; 
 Wed, 27 May 2026 02:26:21 -0700 (PDT)
X-Received: by 2002:a05:600c:35d6:b0:490:4973:91a0 with SMTP id
 5b1f17b1804b1-4904973932amr344513855e9.10.1779873981285; 
 Wed, 27 May 2026 02:26:21 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a281dsm4552653f8f.24.2026.05.27.02.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:26:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 12:26:14 +0300
Message-ID: <20260527092618.14824-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h2p9Ty9Xpr29OXWueNdBo3H8Fw0Zj6CgU_or8K5zrTY_1779873982
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14 0/4] futex: Add error coverage tests for wait,
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

v14:
 - futex_cmp_requeue03: add note explaining why opflags=0
   (no FUTEX_PRIVATE_FLAG) is required for EFAULT to be returned

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |   4 +
 testcases/kernel/syscalls/futex/.gitignore    |   4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 102 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      |  75 +++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      |  89 +++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      |  89 +++++++++++++++
 6 files changed, 363 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
