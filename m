Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C60CD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 21:05:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53A133E5E1D
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 23:05:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A8D63E2752
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:06 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 084E6200CFE
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:06 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-307d0405e07so7745195eec.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781643904; x=1782248704; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MkWHY0h/ABc1PZ1582Th5297a0jGGMfBA1rDZR/WM58=;
 b=OSjqHrrTdVoxfTmfoiT2lkReYhHWxP9jYMwFpjpvUtlBRY+I8VqrilyuDn8StloySx
 ZyyTOgiM943ZY83wCFzvy/6Urjo0iTnTvB259dk3Vd5qsdgmmfy+PfY5Hrylv0Wusu8m
 OAOPoTRdH4FtFlCOxXrDsT4E0xGeQkgqalDEUuQfIac/4afkYor0eFU1Kd/LAh0q9U2D
 tWrxf2EvYDxx+/eSGvMoz+fBiy27srp5NRqvDI61WmQsE4rDFR1h7/PopT6HSFEjdP1U
 zoWnMyRqOq8wtVzI2XWMWsJtA/k1yGikKwvEOx8lyKOB4l+1zW0+WgpD16N1ZIXkD9eS
 hsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781643904; x=1782248704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkWHY0h/ABc1PZ1582Th5297a0jGGMfBA1rDZR/WM58=;
 b=oTecED3+kH6MF9w5rmTqWIzhRoqcXsijq1xwfXby3Wq1G8Liu4MoNTjiglNIiQhGNW
 WOChR/sUxD9hA+bt3GI/ndGX19BLwEDlztRCmtx8BNVZdO+04Yd9qoTc1yus0cFWvUkF
 Cugo9MVVu1w7v8UxKV9/PD7iwvO/izuG/h6VWWTEew5O2+kY/L9VG3R7ojba/UE5O9PQ
 xSIodwljimdquMyYcnvCSmAV2nvWUa8tikqQLCeqy2fiKXxqov4X1Ld6cyY5tWdCnElZ
 7eZRx6qqxsE0XwmLXF9sHpB+Z5ZFbVkoeQ/r0HV7+ilTzhXa0CODtmov4VxZY8AKqHqW
 MQHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ89JAQD4+BZme6NMLRTTBqSgZd9QHfcw3avti+02E36RMsOYfoqJGI14bbGl/JRzD9r4UI=@lists.linux.it
X-Gm-Message-State: AOJu0YyU85DdSnhc2bGvGiefCsXEdIN2xf4oG6fvZg9xS8gFrWGOqslH
 jGRIdh76K1rQ+8AwxQSmPnMbfbRSt0iwEMoodITay80Cj5dB/Euccxz5
X-Gm-Gg: Acq92OFMvstRNyEYH+7h8dAL1J1Rc/jQUzMcXZHQEnhjrSIXuC3eijjDdOJBI+CR8VN
 2T3RS9MIHpmHz5AFlSRuNCT9erI/R3RRZIFqzX1Q1ztEbp0FR3zyxDige9TDBy/lrkV4KA+lgQ+
 2KUq7Xd2672ukmEhWq36vmurNEThxym14esOF54j5xp4Zkse3fo98IC3OZ4gZpWuT3sf9TGgnJf
 l4DkWUHz2+NcsE2G8hpLyITvX3bWpdXno/YhUi0tNQr0d2VxgEHidnY0/IhBm+wDX5JaKBRNiwQ
 ffpQE62nk3yYvqcowgf0GfGkv8Yko76RYQf0VDXzeO0ATn8cY/Mi7a6v2q23+syR4H7/gZXVUG6
 kfZoJrnnF4yksPa9w7wiQXqQdv12wnK+jjQ7+ou0SiVAqalyxR9T+HM4L+uieF4XtHjzXwLZjGN
 qKwrIiNtR9cDAIn4D3
X-Received: by 2002:a05:7301:1298:b0:307:91f5:93f7 with SMTP id
 5a478bee46e88-30bc91b89bemr593276eec.0.1781643904203; 
 Tue, 16 Jun 2026 14:05:04 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0828sm22231766eec.10.2026.06.16.14.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:05:03 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Wed, 17 Jun 2026 05:04:43 +0800
Message-ID: <20260616210448.12175-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] fanotify: update pidfd tests for FAN_REPORT_TID
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
Cc: amir73il@gmail.com, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch set updates fanotify pidfd tests for the kernel change that
adds FAN_REPORT_PIDFD support together with FAN_REPORT_TID.

Link: https://lore.kernel.org/lkml/20260607003343.425939-1-anonymemeow@gmail.com/

---

Changes since v1:
 - Added upstream commit reference in comment
 - skip FAN_REPORT_PIDFD | FAN_REPORT_TID tests for kernel v7.2+
 - Added pthread link flag

v1: https://lore.kernel.org/ltp/20260615180629.7148-1-anonymemeow@gmail.com/

---

AnonymeMeow (5):
  fanotify20: Skip FAN_REPORT_PIDFD | FAN_REPORT_TID test on v7.2+
  fanotify21: Stop relying on exited child for pidfd error
  fanotify21: Simplify read_pidfd_fdinfo()
  fanotify21: Add test variants for FAN_REPORT_TID
  fanotify21: Add FAN_REPORT_TID pidfd coverage

 include/lapi/pidfd.h                          |   4 +
 testcases/kernel/syscalls/fanotify/Makefile   |   2 +-
 .../kernel/syscalls/fanotify/fanotify20.c     |  14 +-
 .../kernel/syscalls/fanotify/fanotify21.c     | 192 +++++++++++-------
 4 files changed, 135 insertions(+), 77 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
