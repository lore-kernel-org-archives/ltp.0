Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077B3C6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 23:51:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A11CF3CA29E
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 00:51:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 903ED3C56B7
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 00:51:15 +0100 (CET)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F06A0600147
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 00:51:14 +0100 (CET)
Received: by mail-pl1-x649.google.com with SMTP id
 l1-20020a170903244100b001a0468b4afcso8001699pls.12
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 16:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679356273;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SG2M7XrzK9n3fRDGWrD8aGyNHBbKSjt2PCUSkTM558c=;
 b=pGP5RFZ1iNgn7S7Ak4DImGIm1EcMKSg4o6On/1XzVPBdget99R1y9qmcWr+ECpfbkd
 72WZEd9C9M3CoUWn34IZG6DWC6iWLoLlUU1Fyi+T20qDA6ndKix0BdwPMxHB/sx68fL9
 MgAdyO16NU8oerfyqTw0O7PXB82Np7wzoLs5eT0G0oHxcphSrHs3hy7Kh4mkbuyLkzXz
 xdVXAp/dq4NIAUuzSnHwxcClYUsPLzgNexarPpzRX5tqLhUX8byHMSXF5SN9Nq+tFcnf
 WXdMxwhxdAU/iQcIA9+ki9xsDl5NLRu6VrssGf2LJUmX3YI2ycE2kfS1EjISmldYqgNw
 n00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679356273;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SG2M7XrzK9n3fRDGWrD8aGyNHBbKSjt2PCUSkTM558c=;
 b=5nGjDAuiaNA49jlUrwAdo1CocYsh7DmZPDPMEBW5ymGClFRQjl02sEkdQXFYZFzwse
 VlH4xHwyr38a1rs5nFhdwbfvYgqF9ucDRAtge5lon0yqmfFP3TqiIwjpNUoPqmsZYIUt
 H2bgevzY82A8QlNgn8rJZ0QkGxZBPnZpEYpGVgBSbzHlnv3ibmvCWrjgkL26XHPz6XAZ
 ztmIsZFSC0D9UgHfnG8Tlta+CF+EuYO2oAZyWxtVFCY6daZydnYhdzaOK1/+dhR3VFJp
 7lDUWzABBgOcjm/CbN/p+xTjIHqXKgzqrgfsKjd7bblMUP8bXswnGlWc41nh+BUzRgJU
 9KJg==
X-Gm-Message-State: AO0yUKXb0H1f5k33pG7hU5bdYswgu85ZFuCVaYUXEAAPAV+J4/Mr8ROY
 4aLRJGLdSQm9NAFdRVxBU1FEkO9hPfMf1treSHpg9gM1rxdNVfj2Y7zYtsaxOfvCaoio3jamu1F
 1UtyyA0oCCtDktd7saiQoNCWfL81h9HvoaAveBm2HvOB4tM9NXZ6iVXSX
X-Google-Smtp-Source: AK7set9mgHXUm5v2XMip5h3kPC81rpejUbCylomtR9ch9XLfZB+syS1KbhtINFyQ5tJ4NDOtrgAtVdVBLk4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:50cc:0:b0:502:f20a:6e0a with SMTP id
 s12-20020a6550cc000000b00502f20a6e0amr48546pgp.0.1679356273200; Mon, 20 Mar
 2023 16:51:13 -0700 (PDT)
Date: Mon, 20 Mar 2023 23:51:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320235108.2058967-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] tst_device.c: Handle Android path for backing
 device
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

e1b1ae66b240 ("tst_find_backing_dev: Get dev name from
/sys/dev/block/*/uevent") added a hardcoded path to check for the
backing device in /dev.  On Android, it needs to check /dev/block.

The set_dev_path function was renamed to set_dev_loop_path and its
return value was changed from 1 on success to 0 on success to be more
consistent with other functions.  A check was added to
tst_find_free_loopdev in the event that the loop device is not ready
yet, which appears to happen occasionally on Android.

v1->v2:
Changed the function signature of tst_find_backing_dev to add the length
of the path string.  Updated all references for this function to include
the added parameter.

Edward Liaw (3):
  tst_device.c: Use PATH_MAX more consistently
  set_dev_loop_path: Refactor set_dev_path and check return value
  tst_find_backing_dev: Also check /dev/block/ for backing device

 doc/c-test-api.txt                            |  2 +-
 include/tst_device.h                          |  3 +-
 lib/newlib_tests/tst_device.c                 |  2 +-
 lib/tst_device.c                              | 59 ++++++++++++-------
 .../kernel/syscalls/ioctl/ioctl_loop05.c      |  2 +-
 5 files changed, 42 insertions(+), 26 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
