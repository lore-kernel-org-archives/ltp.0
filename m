Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684C0CD4F3C
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779215494; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=QLqdpDobad4ASOvSgcdwn1p4Z8PUJq2j8kaTADNSr+8=;
 b=aMdADioXkqwTdW7Fl1xxGU7NZeFA4fSP8KX6OMqxafgJZ5flrJkCFgIt9tkvnxBCG/aNP
 L54hTHIuPuPeMHVx77dCn505hK+9V2gAVtzqzjlixFBmnY7bcEeFwOgfb+NQ0y0bSYnpw+a
 YTahJCSis0eF89TUTo+8mHkRu65E+tc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 165983C71D0
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 20:31:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6E143C5742
 for <ltp@lists.linux.it>; Tue, 19 May 2026 20:30:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 438BF14001E9
 for <ltp@lists.linux.it>; Tue, 19 May 2026 20:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779215445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BM67CqJ2JeDzDRgLmDSm/Gw2hSnqRnqbEGt9PIyHlRk=;
 b=F+aaPxPtOl4+ynJjvFQjOU3dATvkla6MCf8uEDgklPu9sFMUQ+AwFY2eTKl/qSN47/hs+y
 9WgLX3tpkIsN7dMyJxVzelV3oeSh+PXDbiW7+gEMLkrou0pOWyJrDhlFN/zKq6gRwTTv7m
 hPptu4Kn1rH90JcXSJ4Cu5Lf1qwaCFo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-kD3LJaeqOxy2D6VwDxk56A-1; Tue, 19 May 2026 14:30:41 -0400
X-MC-Unique: kD3LJaeqOxy2D6VwDxk56A-1
X-Mimecast-MFC-AGG-ID: kD3LJaeqOxy2D6VwDxk56A_1779215440
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44f56d5523eso3855722f8f.1
 for <ltp@lists.linux.it>; Tue, 19 May 2026 11:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779215440; x=1779820240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BM67CqJ2JeDzDRgLmDSm/Gw2hSnqRnqbEGt9PIyHlRk=;
 b=avqIHqzg+wRI5Nj2hFzdDEvIbn+VB6KQQ0PH1F/qjHqMIO4UEtn9+nJLVOBpUba57K
 6vikY2UyPfPMGneQzrZS5SgNwmEKIpeB7yRW05YXOk4QNItknQ4KPVMiGVPasu/71Y7x
 ZC3TqfzKWXeWRXWKjR0gRQqUgGrAWRU1jBcYiqZsmNJ9FjJLGseUJQQoj5m6XxwaB+ge
 HB/IRmvxNzAJ7D8BATeGJoQ00kY9tdJwwibe6jTlCniiS1TAIY8HfN8aCies/cjgGISM
 eGfAqkjg/dE0Ot6PnkaV4w7KroS04eLrAInZZtJBR+c5Im+kWsEJ72KItVzvRVn9U0UY
 2aHA==
X-Gm-Message-State: AOJu0YxAFH+ABW4UAN4olGFfr3s+sTVeSZEst6Nwt8gfBeKZpl7EZygP
 c3xNCdK7C02BHsNq21DT1+s3mOnpAcSXxcrHye7mGacJRLdeFIzgtRJ/bl8RbKc8z9dDYKUGcsY
 p5ngQHrAWPX0vu0BM8PHrw5dhUeunveewGpVq+wwElmKMUJC/WNsdESzvdZAOJZNUXZpV4h5Im2
 ijKNx7glOSb+4emaV4/HGqSyiyorvB/NuUY0Ut
X-Gm-Gg: Acq92OFk7hQTJUAoCdpXdnsHiyGkD3n5xDPhUnle8inBW75CMMEl6XvQlC7sk9z7y7k
 +aFAUJjY196vOogeIg6zi/pHEsENrUDkoKUsk09GYqx8O7ctFxye7Cknb8/4sO9pAD1DkZEYx2s
 Df4joWFOtPg23Bd2+V1EhMb0oyqZZtC7ws3DI07v3Co6AUFEfSFls99i7tjUqcp9o09OSMBdEPR
 lw/jW7oiboYGUfjC+ItL/5JS0E/e/yE9ojEZIlcONE4ESXVRiMrwlRq8qhOr2Os2cpxsbvjINZz
 otnwst9gNbQr2hmGs+VvtpeJkxskZCWzd4nJ+PN8+ufi0WdZhKssoKZp7eZfrjoLJfymIoREQve
 asts8cMwW0tvejLs72KgjZ/718gk53hCCVhKWYqj8IbkHigkxjEb1cgH4Ji4FOq4kYAdZA5mLXV
 o=
X-Received: by 2002:a05:6000:1a8e:b0:43e:a70d:7622 with SMTP id
 ffacd0b85a97d-45e5c58d96amr31373162f8f.22.1779215439892; 
 Tue, 19 May 2026 11:30:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8e:b0:43e:a70d:7622 with SMTP id
 ffacd0b85a97d-45e5c58d96amr31373113f8f.22.1779215439527; 
 Tue, 19 May 2026 11:30:39 -0700 (PDT)
Received: from fedora.redhat.com (89-139-213-92.bb.netvision.net.il.
 [89.139.213.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19a0csm45128468f8f.20.2026.05.19.11.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 11:30:35 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 19 May 2026 21:30:27 +0300
Message-ID: <20260519183031.114591-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uh54nPSnq3NXSB9pHgof0-B-ZUDaX2w6EOv5oEibYR4_1779215440
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/4] futex: Add error coverage tests for wait,
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

v5:
- Use compile-time testcase arrays with double pointers instead of
  runtime initialization in setup()
- Fix sparse warnings: add (void *) cast in SAFE_MUNMAP calls
- Remove unnecessary braces in single-statement if blocks

v4:
- Use TST_EXP_FAIL instead of manual error checks
- Add kernel version check for EACCES in futex_cmp_requeue03
- Restructure testcases to use direct pointers instead of flag fields
- Replace raw mmap() with SAFE_MMAP() in futex_wait06
- Remove manual SAFE_WAITPID, let library collect child
- Remove obvious comments in futex_wait07

v3:
- Fix copyright year 2024 -> 2026
- Use /*\ comment format for test catalog
- Add Signed-off-by

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |   4 +
 testcases/kernel/syscalls/futex/.gitignore    |   4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 100 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      |  75 +++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      |  87 +++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      |  86 +++++++++++++++
 6 files changed, 356 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
