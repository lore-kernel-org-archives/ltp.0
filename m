Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F7EEB64DA
	for <ltp@archiver.kernel.org>; Sun, 16 Jul 2023 05:35:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 764BD3CDDEA
	for <ltp@archiver.kernel.org>; Sun, 16 Jul 2023 07:35:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9633B3CAB8D
 for <ltp@lists.linux.it>; Sun, 16 Jul 2023 07:35:37 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9CD231400DA9
 for <ltp@lists.linux.it>; Sun, 16 Jul 2023 07:35:36 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31297125334so1994636f8f.0
 for <ltp@lists.linux.it>; Sat, 15 Jul 2023 22:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689485736; x=1692077736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cpGWKfrvQL+1ybJCKw/LKixi3HgAxlKOyIbrMWu/znk=;
 b=BGwyDHb4qeQsyhngbcVqiUQycE/dObFH32HIZdJMhI2gMJtASW6DtfRr/TcSeaanYC
 lVPdxZDW9Y55wpv5r3poOfX1sWcAA9qnHRo9r8MljW6TSgLfx1V1Ea1gUzSaHLoqtN9B
 Wtj4y6V6Rzo3QStqytGJ0oYF1FFIorBf/62pp46e7nDvYiqMKik1D9qyIlxt0nw4jXPp
 472IZP0187Y2WaQtnVrSdvaoIICqgzFj5ka98aqQa/Y7BZOmjNRE0+5dld2sW68nYudE
 FMTmNpiTKVAuz/IOrNBqhBqfJvIJBWMbl581y4JqgE8dDO9zDTzvJxJz59sqt2Vm8BC4
 jNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689485736; x=1692077736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cpGWKfrvQL+1ybJCKw/LKixi3HgAxlKOyIbrMWu/znk=;
 b=iKhurMXqeobxMFrE6/p9rmusnP2v7/YHH0D8uxjHSowgNzOaEdMnnXP31AkzddJn23
 ybPcAEJYYlQeMtPdNog3895XPhS/D0eGv/6auFSAD12LoiSRnaVLQ26XbfsGYOY6sCNY
 UW/5UGiHh4kZmWoe9RDLuUdhifv0KhHmlrJocfheJGfTucVONa+LjvCeJBUKUEppSUpd
 y6OHf7PB6Wylxmp8JhXk1v0gZb5ROcvhEOLAo0/iAtjFcCivUO8TCEQ1V7WOKyk+zEe0
 8nMGu9i55MveHWhZ1voi3hTLQE1F6lp/0fHKp32q6F3TQklJ+fQCm8P2ybWpXNrrYNv1
 zFPA==
X-Gm-Message-State: ABy/qLaK1LrcxxGsG+eR61qd4G1Dp+znPPJUU4wT/EWk2AA1l3U1ovKc
 lS/SYDb0QoPxTfykbgdI+TM=
X-Google-Smtp-Source: APBJJlHVuGiq7ysR3JUq93SYiWGR4hqufyQShZ168MhLBFB1XFdjnG/xIBEJUCnSiwhD14ZlKywXGA==
X-Received: by 2002:a5d:444a:0:b0:314:475:bc6b with SMTP id
 x10-20020a5d444a000000b003140475bc6bmr5924371wrr.18.1689485735591; 
 Sat, 15 Jul 2023 22:35:35 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a5d4682000000b00313e2abfb8dsm15556087wrq.92.2023.07.15.22.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 22:35:35 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Sun, 16 Jul 2023 08:35:27 +0300
Message-Id: <20230716053530.1629416-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Tests for fanotify on anonymous pipe
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr,

This tests for a behavior that we consider broken since the dawn of
fanotify.

The fix was merged to v6.5-rc1.
I've already posted backport patches for kernels > v5.0 [1].
I am not planning to post backport patches for older kernels.

Even though the two new test cases do not use FAN_REPORT_FID,
fanotify14 requires FAN_REPORT_FID, so it is not going to run these
test cases on kernel < v5.1 anyway.

You suggested to wait for stable tree to apply the backports [2],
but this seems to be taking time.  Since I am going on vacation next
week, I am posting these tests, so you can merge them whenever you like.

Thanks,
Amir.

[1] https://lore.kernel.org/stable/20230710133205.1154168-1-amir73il@gmail.com/
[2] https://lore.kernel.org/ltp/20230710155006.GA659329@pevik/

Changes since v1:
- Fix build warnings of uninitialized struct members

Amir Goldstein (3):
  fanotify14: Use FAN_MARK_INODE semantic flag
  fanotify14: Use named initializers
  fanotify14: Test disallow sb/mount mark on anonymous pipe

 .../kernel/syscalls/fanotify/fanotify14.c     | 198 +++++++++++++-----
 1 file changed, 150 insertions(+), 48 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
