Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CA5CD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779735856; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=sjg9DoayC2583HfILmE8bQWsrpc++xCGS5c0bMBIMoY=;
 b=ixff0GxP8aJhUyb27WI8Xiv7HlNGL273YE+w+GGvZSrJ+YdtA2DwJFvC2w/rILeBEek/Q
 B86/6+8hPmF9cLnsZ+f52kcG3L0fqUahQN2IjXXNZjABUV1iYPokHCWCTI12fI1TBTQ3uwj
 JpFlh1nZZEZs/gZJTKjKuG34aWHUwjU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36AFA3E2D47
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 21:04:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B8723D56E0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 88E1210007C1
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779735829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HLimG2oyfQGgZg5Opae9ngiW6e/nRl0PDNXPrQ7yqgg=;
 b=Br4EtYfdnIaJnF6OA+0fpZMMqWoIro0t5W2jDH8WjuQH87Vb/qphWaGn+lmJjipYuEHjAX
 DrRf++2j7k2nnku3gtVVOptGT+tD9IcUxpfWsul2fC9UG2Pm+CpqKbWeZAK/nBasy5nJoZ
 Uo/j0+dR1/sBoSR+T/0m2E+cR/uaqqw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-qCDEj1r8P9ydlFI1JuCxLg-1; Mon, 25 May 2026 15:03:48 -0400
X-MC-Unique: qCDEj1r8P9ydlFI1JuCxLg-1
X-Mimecast-MFC-AGG-ID: qCDEj1r8P9ydlFI1JuCxLg_1779735827
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fd3dbd16aso78704485e9.0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779735827; x=1780340627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLimG2oyfQGgZg5Opae9ngiW6e/nRl0PDNXPrQ7yqgg=;
 b=d2Qqw79V8U4VDfc41wg7aifLZIZt2EibTyVTSbyYJDCDzCkYbS0zG3srpQ/NkZ6DMw
 1ISOu7Nfn/TkxfwTBT77JlJFSjX74BxMKheORn/zA+L8G7052RYz/yW90oEvvoO6SDbW
 FeEnS3soldlK/TdZsTyqAQ+r8aZ9KG4E0bz+97ydrFXYqtZFvr5Ao7mVE343Q3Q5mieY
 2I0Q5CNyXpD22hx6I52BUXLcXWnEOZbYj/UFiwJ8ns9bB8RQ6WUi57vMpu29njwvySTe
 OCUlRuEYSO7rKzjRCfYTv+ZhtAfd1Idyu/neu8PO0UhprzyjPCXyI/75Ad9R8Za8fZeZ
 rQeA==
X-Gm-Message-State: AOJu0YxFHdDb13QUB0yZ6zEY+e8N/E3JMhJ1qPnEGl67HRQ8xpEjr515
 rw7dd4cLDwmmZdAKcs3YfhIrEc4fgfa+InEP+SaVvoHxGcegZKNT0pzJ/tdP+EwNw/skUg53jIP
 sUkOT0/FfK/8Ym6MSFtUfpjfTQrX53SmIrxYe8SYdS7bZUhjSKM4/BU9vfat8qyKK8W9HoaG89H
 U0/+vjnhfRG6VQbf893W6nnYZ3gqtEbrdnDR94
X-Gm-Gg: Acq92OEddTBhgc+MDaAR4MK04fVSdkJcN72Ws7yOFwcYZXSubp//UYNWdhi64JSuGfs
 nMWzZvKvU9cB6GOZ/T4CKuQKQwBtSIl5doUO98QQ/qenyMnIEYR9n8ZMOH73Ukl6Ml8HrCOKkIK
 GcgDg7QcAq1OXDiq1gB085Zmoy1AP70vQoGDyjUq75QySBjvqlCbkh5aKVuOeenDtqUo2Iu33y/
 f5CnwcSPLGc2EJyOjWiB8tAjhEV+LPKbNxW7JMK86aDtz55I8pWgm9JTYQ4G15aXBPVtLaZbvY+
 F3stRPgSHy1W/ft7ZXn2HxLROTd5rYzxK9F2UKE6xqhiOgIq/ZVk45JTxVTMxybca5+qgyaTxWW
 625yCABZZjE88E7k8kHoVqIHETle0E9Suy0x7FJxGxR0HtNMF0ImUn+omhCkp7w==
X-Received: by 2002:a05:600c:45c9:b0:490:5cb3:e94a with SMTP id
 5b1f17b1804b1-4905cb3eb81mr118589935e9.2.1779735826743; 
 Mon, 25 May 2026 12:03:46 -0700 (PDT)
X-Received: by 2002:a05:600c:45c9:b0:490:5cb3:e94a with SMTP id
 5b1f17b1804b1-4905cb3eb81mr118589535e9.2.1779735826332; 
 Mon, 25 May 2026 12:03:46 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm397695995e9.7.2026.05.25.12.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 12:03:45 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 22:03:40 +0300
Message-ID: <20260525190344.60330-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yfQk8LCdSsm3yiBNA0HB26Q7GC0lJpZpXIWP-ltAxVk_1779735827
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 0/4] futex: Add error coverage tests for wait,
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

v9:
 - futex_wait06: replace raw pointer approach with tst_ts_from_ms()
   so tv->tstype is used properly, following the pattern of other
   futex tests
 - runtest/syscalls: place futex_cmp_requeue03 after futex_cmp_requeue02
   rather than at the end of the futex block

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 95 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 74 +++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 87 +++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 87 +++++++++++++++++
 6 files changed, 351 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
