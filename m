Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF1ACD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778080714; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Iog7OEWDUYs6KuwS922AvnoW8aMdc2qayRRxk3n4tRo=;
 b=mkqRDM9hcCjFLjgDUHVP3I3QpJlE7WDbjm8eSgsnyp4Kj5iJD3W4VTeWD3twoVOoYxjb8
 fzFTqJPWl9yqKxswMJ0ewr2US2EITAjSVZUmEZomrLuZCwQ8ztSwlFZW1azWxUMyouHxYU1
 auMbj8LxIn60wFP6xktFkw3Q5QEsgHw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CB163E6168
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:18:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9726E3E6158
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DDC006009E0
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778080687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BmkCkmLptnc4CnqVQTIVHw3AcYFCachAq0IGMCrh/wI=;
 b=a8/nUmxhF2VnqhFMTHuHxNqCyKPCbx+jZL1uG7v+myOAq0Ya2Mw1uWuFtB0ZsknbCjrPuA
 FpBtyru4sSmepurBs2nzFLbE6boUSFw8zHQJvOdEikFIit6GX96PY5k4fHP9MhIjLn+gCV
 Sk8zQ+ONyftNq8t9lpz3qTBl7Z9RQTg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-Vlvsmf9GNxeM9X4uQC53mA-1; Wed, 06 May 2026 11:18:06 -0400
X-MC-Unique: Vlvsmf9GNxeM9X4uQC53mA-1
X-Mimecast-MFC-AGG-ID: Vlvsmf9GNxeM9X4uQC53mA_1778080685
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44a122a5128so3956630f8f.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080684; x=1778685484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmkCkmLptnc4CnqVQTIVHw3AcYFCachAq0IGMCrh/wI=;
 b=rW4bEk0FUzp2DshnI8W/mh2OhMXuaFnq/Y6aqvuB7GmL+f7c8Q5k9OusM1/LMCdK6I
 +1QK2dFO3t5F1/Kp2bJNSyBV1JRap37FheOoPmQPYjJ/V2mLKCcfcGqIIr5iTXtUmX3G
 3PlpRHj7+HP8fUAEMZYZvc+SoevU2hwKPocuyQhTMMaRZJwn6la0lU+SMOOLqGd93pfa
 AA8DlAlTP9vtclE5bebFnn9ZU4UZxiB+OTnWDLLgWoRSQ7meIxsQT89DmHL0WLK2sWYs
 EtLKVwmNsDw1KLeuGBmdmsqs1o+Vs1Xa5M2uwSnj4YLFGTywbUvBGxEcYmkSHyQ+I51D
 GNBA==
X-Gm-Message-State: AOJu0Yz7AvD+wqFdPYLDFubAi59NcIzn7To9UsyCOWsRvwrvtLldLxOf
 f08PowjPHZRn/tazMpqW1H15CnjJxwPcatXZ95murhtGVFdNX01LglfWa+a9sbuOSjuK593cyz+
 izk3YOEBEeiuKm1JxLL5ORbcBqq6P4j1q+SK5bJzpOkN3TZzcyei8R0dfTiB3DWZFdvs+RrEQrb
 DHP9R9qdRzOjo8KbSdHocwu+KWYHMY+0ZEIF/t
X-Gm-Gg: AeBDiesmR+9251i+EX7K9BQK6iMYBr4taIol2HpXj6dBTUainbZ+1YFtU90Pkbi/u6o
 AWfUuMUQxQU9gKRkvsIcOdxCxuogMJlDVzGYISWGCopRVdSeb+PCQTI7DWf8vQW/68hQGpWUzst
 hqnR6EpCrSfBV5/jeEdW2p5QxLUolnvzr/Q43gvLWg4dtP3mRyNg1JAEhw2GruxtySVcmfAeghF
 MJSbjFla0x8Q4h43Jp2y2IrtHMuUe4PzT/H3ENxHVH14d5Xt3sA2igRB7OSEphSkN+wmnXvOpe0
 g4eaUpGd4OBkB64wCZYYpAVU12Ib+0SHXb3u67YP5raLTd8qE1am2W6fc1H1qqPz3su8jvIeanp
 +9tT80c7LsgnRoYyiMDJhKVrN6jIgrfjw1gPfPLTIOSyWgRzaH3mQLVwlawQj1P9NDB2LOD3w3u
 INXWmjhg==
X-Received: by 2002:a05:6000:230a:b0:43e:b0f7:9ce9 with SMTP id
 ffacd0b85a97d-4515b61af48mr6648811f8f.14.1778080684364; 
 Wed, 06 May 2026 08:18:04 -0700 (PDT)
X-Received: by 2002:a05:6000:230a:b0:43e:b0f7:9ce9 with SMTP id
 ffacd0b85a97d-4515b61af48mr6648758f8f.14.1778080683816; 
 Wed, 06 May 2026 08:18:03 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e174sm13323519f8f.1.2026.05.06.08.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:18:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 18:17:57 +0300
Message-ID: <20260506151801.20401-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fft1mVIozSOAi9lFBsjA0OsCZdG09hPrmuEYpda6UM0_1778080685
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ltp v2 0/4] futex: Add error coverage tests for wait,
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
uaddr2 points to unmapped memory, and EACCES or EFAULT when uaddr
points to memory without read permission (PROT_NONE). The EACCES
behavior was introduced in kernel 5.9.

v2:
 - Rebased on latest master
 - Added [ltp] subject prefix
 - Split into one patch per test case

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT and EACCES error coverage test

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 96 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 73 ++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 91 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 86 +++++++++++++++++
 6 files changed, 354 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
