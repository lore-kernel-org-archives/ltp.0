Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EB3C02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 17:25:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E5523C3090
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 18:25:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B9CE3C2CD6
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:45 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B0730140BE97
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:44 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4368a293339so82696735e9.3
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 09:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737566684; x=1738171484; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rlkzTFLe5U12W79I0sEsZwPOndG5FVPWXHkftO6iB74=;
 b=JsqFkQ2Q+SXZsVO7unk+Ergu5xXmOQs9i7i6pQMX+JWuQO8X132CyGaqZxwHnvZ+eu
 o5xT9ZK4e/q1fdbG7VAmsmV4NRDXAlxjiSD2u7pjcheGWi6FsFaeXJksf16RLxxJKGh/
 SoostEDi+veOUHtUt/cOcWmvNOduugpR82mW5lXXd142qv3veGcBXbkzca3QtLeCqYXe
 GAPtQZO9jo0X7KxbYwdy1qTYjPYAkHsjIjglmrg2EbRqZuS/JM9QeSVcoPwnVSkMQMIj
 wqSM7rUGQB65go3K2M0uzIyPg467v7e6JybW+9y0qfmp9yrmAU2rjkxrXBBsse2K7lI9
 o9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566684; x=1738171484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rlkzTFLe5U12W79I0sEsZwPOndG5FVPWXHkftO6iB74=;
 b=gcoMUCur4A+u2mfOgdkNZRHym8Jfdqyib0/2/f4LasVXyb7DMdvITheRF/XveLBY6t
 8MT8GloVHWdC+aC4pGFQK9ljRgqOEM1eHWEeBiXe3bRM92i2gQslCwMtyD138itHBQnv
 U+RrfLzHSWAcuS9PHKrvtrddF2A1Dz9LOz4mjllOcFGcw6Adfh3O+PWQRz5Gg4363Ope
 WfheZyZl6Sp4u+ynQtlD5aFiyD/8eqKkR0jVBJHvfhXmGc0mfy86Qpd1/jbN/T78LXF7
 5fcM6A+yYciB8dFjtvH/JuhGvMhCymGGOyLRwAx2VbeHpvnRHwnbxVDXCw689gDXw/qk
 NKgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCvjugOr0q7XXXV3zAgryq5rArPHkK6/00hf+pBFmMl6zHlUguKuypF+1s6Rhc5D638ik=@lists.linux.it
X-Gm-Message-State: AOJu0Yy0tnlOC7769CzTx/ERpQnBRAhOoHivf1t924uajzSAfQrVO2BL
 Arknhi6x6pmAQqfYe9CDZsanHST3an/4jWgtbRPdB2PvIxb8+l+ZsknyWnyz
X-Gm-Gg: ASbGncuQ2iDNkPeLWlDcyyub10kCN4c6AZ47qhfInVWrDxMxh/XfrRIOTgO01d2W24h
 PBNLL+ksQZf1yU3bIfjMkpD+IQKS52brjbrpTEaalDds1VXsAt3rtryVvh1o/XJdLwYokwgF8XI
 2X++9N4SwKAtklPZFNMgpQ/w0E2Fpxmu3lq5Xo5u2nLpnm6Vbjoe2iOMXW99E3IGeVPgkc/qRkV
 lnLuONHLm8enyjrgrDTzrv0AN9N5wNviBsaHa1Vg+cWQTcfkTbLW2Py8jHwM0r0rZYNSshEki5F
 0rtaEDLqptseEHEUn3X+vKnPolLlYYQhcD0PYfof0Ag7/Pn+cNj+MCWVgWAY09uphAU=
X-Google-Smtp-Source: AGHT+IEqhUp/yRKO9RSTECP5QwYAcc71X3XX2KtxpShp8w2Ve2uCHBqQywcWYmErq4Il++495FI6Pw==
X-Received: by 2002:a05:600c:3d86:b0:434:f9e1:5cf8 with SMTP id
 5b1f17b1804b1-4389143c306mr218956235e9.31.1737566683715; 
 Wed, 22 Jan 2025 09:24:43 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31d98e2sm31592405e9.26.2025.01.22.09.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:24:43 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Jan 2025 18:24:35 +0100
Message-Id: <20250122172440.506677-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] LTP fanotify tests for v6.13
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Following tests for fanotify code in v6.13.

1. The new test case in fanotify13 fails as follows on kernels v6.6..v6.12:

fanotify13.c:282: TFAIL: handle_bytes (0) returned in event does not equal to handle_bytes (24) returned in name_to_handle_at(2)
fanotify13.c:282: TFAIL: handle_bytes (0) returned in event does not equal to handle_bytes (24) returned in name_to_handle_at(2)
fanotify13.c:282: TFAIL: handle_bytes (180003) returned in event does not equal to handle_bytes (24) returned in name_to_handle_at(2)

The fix was already backported to v6.12.10.
It was also backported to v6.6.72,
but then reverted due to a backport bug in v6.6.73
and it now staged again for v6.6.74.

2. The new variant of fanotify21 is skipped on kernels <= v6.12

This variant tests the new feature flag FAN_REPORT_FD_ERROR, which is
not effectively a bug fix.

Because this feature was added as a consequence of a bug report,
it was auto backported to v6.12.5 and to v6.6.66, but I do not
feel comfortable with adding a fix tag to force distros to backport
this feature.

Thanks,
Amir.

Amir Goldstein (5):
  fanotify13: Verify that we did not get an extra event
  fanotify13: Add test case for FAN_DELETE_SELF
  fanotify05: Test reporting overflow event with FAN_REPORT_FD_ERROR
  fanotify21: Test reporting event with RDWR fd on RO mount
  fanotify21: Test reporting fd open errors with FAN_REPORT_FD_ERROR

 include/lapi/fanotify.h                       |  4 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  1 +
 .../kernel/syscalls/fanotify/fanotify05.c     | 18 +++-
 .../kernel/syscalls/fanotify/fanotify13.c     | 90 ++++++++++++++++---
 .../kernel/syscalls/fanotify/fanotify21.c     | 89 ++++++++++++++++--
 5 files changed, 177 insertions(+), 25 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
