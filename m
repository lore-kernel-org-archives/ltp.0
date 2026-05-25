Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C977CCD5BBF
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 10:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779703530; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=O3/UuV7OELLIJER/ZlUdu55B2G3P8erscTRlvKhvND0=;
 b=HxY+YCwvLzb0JkoTJPiEoWybkhBxh4SzexEuKRn2xMvZaAw8hUAW8HAaUO52taaFnSbVl
 3PJdJ54UxL7FNeC3OSneRB3hawUDJhKlMnsVQUHE6Mt96tUhd2/LpZmFEcBD7KKeGBrFUDT
 j11jlSuxnCmNkZBXG+MTROt0Y81X0Nw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1C2E3E526F
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 12:05:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E1163E526F
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:05:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 37DCF6002C4
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779703498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b9rkGX9jAsGXjCtoGH7HvKUdnVeQP2GlLZ90hkYjZ2c=;
 b=ORPmSoxm1DLDdWbkN6fg+L9oOIE/3iVH6CK8nRbmJXpJvdewm8dqEeEAPqs36sGR554zTX
 LyyTVH3lQ3BTmFUhzAOFSqpy4C9t9WG/Z8vuJsS/lJxooSQcmNkdThco/CetQ6ri9XHXHm
 IUdUZx+RD9Zuf7G7tCIlSNdVD6S68YE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-5_BadKIYOQCBRInT1CopRw-1; Mon, 25 May 2026 06:04:57 -0400
X-MC-Unique: 5_BadKIYOQCBRInT1CopRw-1
X-Mimecast-MFC-AGG-ID: 5_BadKIYOQCBRInT1CopRw_1779703496
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48eb0da933fso62920885e9.0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 03:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779703496; x=1780308296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9rkGX9jAsGXjCtoGH7HvKUdnVeQP2GlLZ90hkYjZ2c=;
 b=CPoqs7im3T8RzbQj4j2iVxIaaYXcwofiTUm2QoA5i91S00cMwJ5rFg1q0k+QogB6nk
 SMj0sKBfgv3FBSFTANaKgKMP9KrYmbH+QSAiGchZEoUR7037rk4d76fK/GEYwoGfDuUH
 OnUstfvNpZnRxY4t0C8tGCQzSaClNpigTS/D4CarOp1yhBCFEQOOJmn7CFjQIGXN2E11
 1VTQVStN9IEa41dT04pinBVI7zhc8WBbrFNssn8jTpHRVpNxF4uSPvc4Rpvcfz044w52
 WHO9FZEMW5EhbpeZf6RsK4kQdRPmtdAAm+2GClvunc3qnP+2FFDd7Dzfz0WcflQHurEw
 lH3g==
X-Gm-Message-State: AOJu0Ywukmoy4nml1FTPRKRSU02d9NsJ/O0an05mey/XFneHG5fXa6Hu
 QzqvSksjRFH27YzeB7e+YLlqXDDqyNmRtGcT/6uO5M9PzsjywPaktKPOrsW4X7MjFr+9kMyuOQO
 VAdNRcsVyX56wZcGQ+0Kb/BCW16O0A3srjCoehIwMrkbtpEuVBXrhpwWHjYXrU/ISM+wTV/k9dw
 nd6yM/nL5hwJnm/BO7lsiBs2HGPSLBgIyrOBxZ
X-Gm-Gg: Acq92OE7F8c+ZMOwACJ4WWkQhiHwEeiUVlWUCgg5ING4xiEnHKi/PVmrGTR6ofZ0214
 LkVk2G9aSFsq5ql0XRTAb4PmOWd4/vdA1iEcU71h2GGbKzI7XeKf8UBrFRc1SVl4OPAVTH8yzZ1
 GOVH5Mbaoaag9iX8CYh3cOSr2DzDPC3KGD6mTG6zgP2DibvAN09eGe/Kqeg+B+YEIQe1YNkeWdT
 0Njlv7jA2TD/7jU2s67ROXIPQ0+PtH8lHXZTbTplwZkn4Oyo6NTjmu798YEm+zu/chyZtHGwqz/
 A0azpqPGauJUDWDivnqIGzKR2vq6diJuauISJB0uY5dbwFiBxm9L8ZaEO5Xg8NUhMtHCPoTPO7O
 3kxYdGETLofcUXMu5yrWx8GY76z7wCBr/vTRUis8/n5GBg6yKx12f6m/0o27ix3xxvQw=
X-Received: by 2002:a05:600c:a213:b0:48e:8741:fd42 with SMTP id
 5b1f17b1804b1-490424ada3bmr144513175e9.12.1779703495897; 
 Mon, 25 May 2026 03:04:55 -0700 (PDT)
X-Received: by 2002:a05:600c:a213:b0:48e:8741:fd42 with SMTP id
 5b1f17b1804b1-490424ada3bmr144512755e9.12.1779703495433; 
 Mon, 25 May 2026 03:04:55 -0700 (PDT)
Received: from fedora.redhat.com (46-116-113-151.bb.netvision.net.il.
 [46.116.113.151]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm236519805e9.11.2026.05.25.03.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 03:04:54 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 13:04:48 +0300
Message-ID: <20260525100452.336518-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -prVh_HUrQYz0F_xyMi7fbtDaN-9RevcD0nibpTWwBY_1779703496
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/4] futex: Add error coverage tests for wait,
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

v7:
 - Add author name to copyright tag in all four files

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 96 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 75 +++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 87 +++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 85 ++++++++++++++++
 6 files changed, 351 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
