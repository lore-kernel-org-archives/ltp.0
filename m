Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19775CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779822325; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=nf3u3NcZ4w8ZyAuAJnLrw/CtmInioMpWwNhsuIIh278=;
 b=H5LWbmtyGqE/XgMC5u2KRdmclUaytcpTs8u0qdEOYzQ3kBXyS8bG2S0r7BGkODsMpA+bK
 6YIYkofqROi/SiBeRFLIRooQ9CItPgUywv6n94QENaPowRbTUtxZ6yW2T18rX/Qe0WQGRtO
 Y1p699eZ1hZXgC0RUZjrQzFkH6cnHk8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC9703C701F
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:05:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BAAD3C1E1C
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E2AB51400BEC
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779822275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LDIc7burzV+z7MQTWG2g1gHNwt8KNnI8SQvihMVAuzc=;
 b=ZttWpM4KXOZ8jxymwVJkYF58Rkw5yAjPPyLqFaKl2xcrN2xQhkYdSPJim7kxgM8jMkiSj1
 /gS3Cz3s6qSa06y5XXxCLqQvwflhEYdO0uBq//MAIpmDJ0mdUyWgYCMkYcaxJQ2ySNA+U5
 UR1YN6+RDNb85m9fKsvPxyD8/9iO3J0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-kFOJqnl7On2OUgRDAaVReg-1; Tue, 26 May 2026 15:04:34 -0400
X-MC-Unique: kFOJqnl7On2OUgRDAaVReg-1
X-Mimecast-MFC-AGG-ID: kFOJqnl7On2OUgRDAaVReg_1779822273
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ea19f2564so5657956f8f.2
 for <ltp@lists.linux.it>; Tue, 26 May 2026 12:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779822273; x=1780427073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDIc7burzV+z7MQTWG2g1gHNwt8KNnI8SQvihMVAuzc=;
 b=iewT/qreeJ4f44I1tKKsP5fYKFR1Bc1Ee0ZyWDGlcQ/8mmcrxlr3W52uOXbWCcC9OH
 864hvsJUGasrfCo09160D1NsjxBcn2jRLyJnuOEkk2SfhxPxBcgzOSYcC5YtDihv3mH0
 lt3bTUfmC4uq8zm+x3Y/qDJMfLWmj/ARUKj4SK1tWFs2/ceonA0HGCwHjJEsPrq+aJXc
 EOcGy0a+h5Vv4Cw3oGMvkyQEBkimShVnKZ4opFdsMCiCfq5E4GthrIRHOa0024eLL/P4
 5QC3yC8I0W7erWDoYj/xqpyEdoYB+bCim8NFbfYuHaoMJPn9YKmRqXDGPh8G48Byx4VL
 BRmg==
X-Gm-Message-State: AOJu0YzASZHAD2duMTcRc2PfciapH9BvLCw4PvREKhoCo8xQf+/Ds1E6
 NDL4VjZTAp44chBc8k9q4UgI1BWu2rbUFPMn1ttLXwdFVT7CRWaAGUgUXcj+VcD3v14ErTMVXqJ
 pSkrxTuhL7jt77b6k3Kf4JYbmKUCIrAmTugOwMcL5gw0KdS7jv5vMfF2t9j9fa8asdeUqX2/s5X
 uB5L9+HYPRGaT6eXVyvH34gYX+4rvE9Oh0na7Q
X-Gm-Gg: Acq92OGFPiAqA4NZ+d1ocDmzBrTBjmYAiVK/xYgY5y1y3eZ+/XoWHh+UWqrr76Twu76
 sV/7jmAd0utn+3u3XQJ9PT3hmrr9YluaL8Q7kpPAEfJGAa1KR++VBgmsIMSEbX9mzt0Wcum8Xc4
 EJ1oKhagstB64JXkldlgbV45GFlyIkb9mLPH0Ni9zryz1WZsfEfAtuGLtcw/u/WPt0tXyryVBIi
 3J5+iaPFFgn0sc0+FixE5Pnyr/7GoqesaiSbcb+in7Py5iX7xV1wk/1jKnNlsSe9DVxN+uP4DeK
 kWeqcle/GfWCbKa9osaxDp88rik9xNW5nc+pUpcmKPli/SbUaj8evqaYqHzY9cel/FIscrkZcVm
 6YnaOr7/GqASElIZ1wTT8aR1Kuss7Mk6eBAdyl2nVvvwxgx92yjnwfxuxT9QaCg==
X-Received: by 2002:a05:6000:18ad:b0:452:a293:4d91 with SMTP id
 ffacd0b85a97d-45eb33551bemr33733000f8f.0.1779822272787; 
 Tue, 26 May 2026 12:04:32 -0700 (PDT)
X-Received: by 2002:a05:6000:18ad:b0:452:a293:4d91 with SMTP id
 ffacd0b85a97d-45eb33551bemr33732957f8f.0.1779822272312; 
 Tue, 26 May 2026 12:04:32 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1a28sm204398f8f.26.2026.05.26.12.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:04:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 22:04:26 +0300
Message-ID: <20260526190430.129798-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2HjzHgjhdtASxa1yeKOW3RZy6j56okFVZQ6bOmkurj4_1779822273
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 0/4] futex: Add error coverage tests for wait,
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

v12:
 - Fix copyright format in all four files: split company and author
   onto separate Copyright lines
 - futex_wait07: add SAFE_WAITPID(child, NULL, 0) after SAFE_KILL
   to ensure child has exited before cleanup runs

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 99 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 75 ++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 89 +++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 88 +++++++++++++++++
 6 files changed, 359 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
