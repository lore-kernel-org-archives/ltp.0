Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38F3CD5BD1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 09:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779786506; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=lAMZEhGKv4o37b0PqRExdHnIzT5JLKFRU9GXEt/FvKc=;
 b=fQbZY0bgM0RUrQtXru712lG8gXOwQwoKICbAai/03JQQ3WlICWQEzNzDlWWcSaW3wWpBE
 iisndhHdGxg2BOdhXezngIGS2gbwjcA4oUF/2P9Gbl2Du60Th+QcL11R2VQQx5Zy5B/Kmoc
 RQeq/b4AMVEA73CwcTI8o/RZ5/2lu38=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03CFA3E5241
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 11:08:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10FAE3E5240
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3842B1000499
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779786457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wl1Op59WiqFmh3FG/a5n03BJ9jD6sXaQjNgDSRulcaQ=;
 b=NVVX+SnCNXYqN5DV/BzA2koXjN+/Cofs1kisRqZhcn9AvDaMI1TmlLmWbGD30UB3ms0mjQ
 sAPgoLsYoIHx8OlAwMOMlVOCzZge+mO4CWDeR2ZTdImYZLhVHsPsVNqofICIUAFZ18u0A0
 y2PAEC7knBKxVi3m8CbjtuIsRqxYZpk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-itil2Zg_MMeTO044UV1IUg-1; Tue, 26 May 2026 05:07:35 -0400
X-MC-Unique: itil2Zg_MMeTO044UV1IUg-1
X-Mimecast-MFC-AGG-ID: itil2Zg_MMeTO044UV1IUg_1779786454
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-449b2a183d3so6610120f8f.0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 02:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786454; x=1780391254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wl1Op59WiqFmh3FG/a5n03BJ9jD6sXaQjNgDSRulcaQ=;
 b=aLHzRT9W+6cIVj1Bex3SuC5BylwkG91w0pg6WKLyWeewvf5DQ3CznSd328MEbE8P2S
 QV6colfw0xpz+crJ56uGI3SmsqmlNpW7sHvWiwT7C3jBP+X98tXH0wuPUruqkEjgFYNe
 6KxtoahEdt/FuZxizLvCN+AM1of1lAIEtsakJGjVVrGcqEaUdNP2qnHH0xN1bSyWxhz0
 J1qZpqxcVIrSZ4C2QcbId2ZQ5j4nTAWbUMUgL7UstkTj2tRj9UDhc75x0sorTIVzM9EF
 aCAp6uScE/XdZDSdj5OHz7d4TZXbilnSlZ4tH0hNJ9eVG4G5kEnUaFT86c2hg+efUiut
 2hhA==
X-Gm-Message-State: AOJu0YyP3YTyyx8SYhLUzPBzJBJeU9HYg9JRy2KpuKXEPHtfPYwb+hKL
 6VRBbTz14v3h1Res2O9vKvUl9kgbFLXJ64gqh9LU4+Te5zbAOaeHI9MMGmnI5m7TWFOCYwV4Pfn
 Njc5HoDiVLAGBi9tkkJQgPPbad9tzbzcCfofYhfL5SxC7BaEFA5NdM/RC9RpSGz1Vz5SNqfu+p5
 X97WkPzAl3trZMGuOi7qgSPQUq6f5Smq969ZSm
X-Gm-Gg: Acq92OExRmLZIuqF6ObXqfnxGBHKRKP/vpLCZ7wjO/CpZ499Z5bavO0iI0YRcOmPdwk
 OXO+r9JceWrop0wc58wtUef08N5vGvFyIpLYa6BoipUdTyNy3+J8r2OzOvGReJtjGzsVqVqVMJA
 IzUpoJZ8V3AF0jLuai7BlamJB98H4ElP2bYqiiBz19vrLiU+QEdHnoZcvYMM4oZ5vOiyXjXf1yd
 GtKU9P94atSqbPQOssqloOQUTH1SW1hsY5u6SKYT5cnL0VgvEUtzw3Ljtdooieqq3AhfrstdPg5
 q51HXnas8mNdMGG67TG/q3zWIWhZdbi6z7u0TS8eYFfO/IEgggpGgvz8SH/OWkckzCkxtKHi3wF
 v560aZIiaGFEGe27mjjxVfh0Grtc+BD1d+fXbpI5iK2iwuurgx4oy7QTYEHTvbA==
X-Received: by 2002:a05:6000:4696:b0:45e:c64d:868d with SMTP id
 ffacd0b85a97d-45ec64d86bbmr12017890f8f.21.1779786454315; 
 Tue, 26 May 2026 02:07:34 -0700 (PDT)
X-Received: by 2002:a05:6000:4696:b0:45e:c64d:868d with SMTP id
 ffacd0b85a97d-45ec64d86bbmr12017847f8f.21.1779786453817; 
 Tue, 26 May 2026 02:07:33 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f58dsm33274647f8f.5.2026.05.26.02.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:07:32 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 12:07:26 +0300
Message-ID: <20260526090730.22455-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xpOb4LLpmskZ_m5ckyQFY0sLpffezMt7kfvq-EPPBOc_1779786454
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 0/4] futex: Add error coverage tests for wait,
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

v10:
 - runtest/syscalls: place futex_wait06/wait07 after futex_wait05,
   futex_wake05 after futex_wake04, grouped by operation family
 - futex_cmp_requeue03: add comment explaining uaddr2 is only
   reached after *uaddr == val comparison succeeds

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 98 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 74 ++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 87 ++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 87 ++++++++++++++++
 6 files changed, 354 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
