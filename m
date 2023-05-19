Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7D7C77B7A
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 09:17:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 779CE3CD3FF
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 11:17:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 647AF3CD3FB
 for <ltp@lists.linux.it>; Fri, 19 May 2023 11:17:34 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B9257600155
 for <ltp@lists.linux.it>; Fri, 19 May 2023 11:17:33 +0200 (CEST)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-456d0287ec1so799371e0c.1
 for <ltp@lists.linux.it>; Fri, 19 May 2023 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684487852; x=1687079852;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FjkRsaO51J+3h62ljii2sgaVK4RT4W9ZpTfAcGqp1pg=;
 b=q982RWsrY//sxZXwnVuCUIoDXyNwhOtyjSNdroAGncPmIatXf2X6FBJxj0RsCbzOr8
 PQhA9R3Ec4/8zyOkNse/4qWIL1q9qkqPvfv5UcsKswD9EaqI0mcJhI2J8K3DwUBQQhGi
 4EQi7mDme6k522YLsoCpU12Ysp0nbGZqgnV8/IGBt0lJLYAPHf5GJjdkzmYCVpZbiC3D
 Pxv2CERstitSHawdj+6hjn7KqWQTusyRevJIzKgwBydZv96sk8AZ70LGs9JgNFlTyvG8
 jnJm9mSkSVY4NoajpnbDw5F9GeLwoheTmEt3il/W8K+W7cKYjNKzGN+TpoFVrlNhfY+5
 dPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684487852; x=1687079852;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FjkRsaO51J+3h62ljii2sgaVK4RT4W9ZpTfAcGqp1pg=;
 b=QmOzPkTL8Eq56pNkuEzDMO/Z3ujqFRh1v4joWCCVfE5Tr8TODRMotXUGNWn8Lt+nDb
 JMqvqg07sn+avrr1dWWRJ1aRUKgMQjGbtjQfOvs5ogNWONXO8K3kSNWu6d65zpoV0GHM
 jap6cbFKfu+5gV2g1f4+f+NxaFJkVpYY+iPdxOezW7M6fwdVLd5vEqWrb7VtEknGnlxv
 +Sb5jNfC2WwLs2n5GCThiHN4q+YLlJIn/HxZk0SNY14IFOiHoE+aOVyFBeqN3h7zC/yf
 hadcEq96grLA5iORmJ2fVqXBBkNlTRfBGTR3XWV4euLcmW/6wxCKQHMsLs9K2KEK+6AZ
 JY5A==
X-Gm-Message-State: AC+VfDyYUl9ETEinFXORVsK3ptNGrp/nx0n8wfLU1m8f8egwEZ4xltCa
 YVSMP/LO/nKRJvVAXi2MdIhfgeCsKkLpyyFwbaKaKQ==
X-Google-Smtp-Source: ACHHUZ6FIvI8GJGjhJKl+w6GLlSXbVimRzZmRuLgK82KaqjxlnxJtZrYpsZP2DgLh3JBOcPn7qFNq8Luweco+Xkd/BM=
X-Received: by 2002:a1f:3f03:0:b0:453:8f1c:eb31 with SMTP id
 m3-20020a1f3f03000000b004538f1ceb31mr278701vka.14.1684487852406; Fri, 19 May
 2023 02:17:32 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 19 May 2023 14:47:21 +0530
Message-ID: <CA+G9fYs-Bc6wZKx+Fz4gFBQhkfRi+pQCnij5Kh3zhHU31mmGgQ@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
 lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP: io_uring01 io_uring02 fails on compat mode - 64-bit
 kernel and 32-bit userspace
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
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP running on compat mode where the tests run on
64-bit kernel and 32-bit userspace are noticed on a list of failures.

What would be the best way to handle this rare combination of failures ?

* qemu_x86_64-compat
   - io_uring01
   - io_uring02

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
io_uring01.c:80: TPASS: io_uring_setup() passed
io_uring01.c:89: TBROK: mmap((nil),388,3,32769,3,0) failed: ENOMEM (12)

tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
io_uring02.c:213: TBROK: mmap((nil),18752,3,32769,5,0) failed: ENOMEM (12)


log:
----

 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc1-71-g105131df9c3b/testrun/16883235/suite/ltp-syscalls/test/io_uring02/log
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc1-71-g105131df9c3b/testrun/16883235/suite/ltp-syscalls/test/io_uring01/history/


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
