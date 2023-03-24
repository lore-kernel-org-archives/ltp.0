Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797A2C6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 00:25:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BACD3CE2EB
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 01:25:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2C853CD349
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:46 +0100 (CET)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C42F36011F7
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:45 +0100 (CET)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5411f21f849so2458407b3.16
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679617484;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ewIdp5qCcVp99opDBE5UmLI6L/Mnwg9H1xvxgvyIMB4=;
 b=ZOPy1ZkDSyhTmUzH/VDuVAKP0HDXj95ZRlMXNMK/j0rwVQ8opkZrav7/5W4MiusqJM
 6su11PwDD9pTVNRT/PaV5NrMxYUzMFtA1a5cVvRnB3nZIICjE3qI0tAp8CvOG/Io9Of3
 QvVPKbPAJswvzwhoPMU0GQreaQaI3m8jCIaM4S0GHeZP/XL97HBMaH9BTbF4Kio2wz/M
 nQfZM5kTgMEdTSfuiio+DRIUVRLX0T+a1CHg6rTtUFDMzj1GMQ7Wx8qLb/NlFCeetYr4
 2amjOfbSFELbPf0sN0EyVMr3YLwiSZFIzwvId3psQqqTTXhSUb0I8QneoIAvYjM4dBuh
 35jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679617484;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ewIdp5qCcVp99opDBE5UmLI6L/Mnwg9H1xvxgvyIMB4=;
 b=27ddU7StatiFI/OeJ5imn5JepXr8PELmsBIcIeS+a2Yudt+p4aKH8JHgQlzt5bCrJQ
 QvB3Xg4rn/rb1qCbo5imd1a5+xF6DSaWQVgkfTRy7zkNRO6i6MpIIiGAB/9ZSNfIZogr
 k0AtJ8bt9HeUNuwYCsdhWQ4NNui7RdqXdnPF5Ky736Qu+2IArx86BUJI+Ftm1DfbDzoW
 f+nvuThctFCdyD7G3XNnQhHGa1Ri/Jv630+NDYCL8c6Cs4Ak2otvTCSE/bxvpCXLVH3m
 Mojgg51N5Ay1KpchdG2NklCE6toVAq+t7sAuo2NvnuUSmNRtatVi7marr4u/08YEHBMw
 spMQ==
X-Gm-Message-State: AAQBX9cfkVouXkqNTpzIJ+LwP0e5xigGSV0pSjz6cF8BnONSVtHmUe/b
 bJshOjVy+kWFEVpvpGJQd5pozVyVZudMwPi2j5x14ErTyaH0hKr0MLIM31yN3E9H/R3pfL02DTL
 +JGu97vW4oe9eq/RqloJlr2yKezuTFn6O34klXuRECfAKaKzzw7Z1atRE
X-Google-Smtp-Source: AKy350ZZVn/BWgibggi3mGeR1WOlOggke09wXn2lxhnEdSUvUQlP2ottKy1UHQRHApBydsSdZJ3EUwdVegw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:3:b0:541:698b:7bdb with SMTP id
 bc3-20020a05690c000300b00541698b7bdbmr3296771ywb.2.1679617484366; Thu, 23 Mar
 2023 17:24:44 -0700 (PDT)
Date: Fri, 24 Mar 2023 00:24:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230324002441.987778-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] tst_device.c: Handle Android path for backing
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

v2->v3:
Split the function rename, return value change, and the return value
check into 3 commits.  Fixed logic for non-NULL path check.  Added Fixes
tag for e1b1ae66b240.

Edward Liaw (4):
  set_dev_path: Rename to set_dev_loop_path
  set_dev_loop_path: Change return value to zero on success
  tst_find_free_loopdev: Check return value of set_dev_loop_path
  tst_find_backing_dev: Also check /dev/block/ for backing device

 doc/c-test-api.txt                            |  2 +-
 include/tst_device.h                          |  3 +-
 lib/newlib_tests/tst_device.c                 |  2 +-
 lib/tst_device.c                              | 51 ++++++++++++-------
 .../kernel/syscalls/ioctl/ioctl_loop05.c      |  2 +-
 5 files changed, 38 insertions(+), 22 deletions(-)

-- 
2.40.0.348.gf938b09366-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
