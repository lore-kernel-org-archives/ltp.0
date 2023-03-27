Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BBCC76195
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 16:12:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E17A43CCBC5
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 18:12:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84EDC3CA955
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 18:11:51 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A9E31000A1A
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 18:11:50 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5425c04765dso92358627b3.0
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679933509;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NkmiU4zmCqMgcQF3NLXiMPPrYfAfqOPOoQedCxNLha8=;
 b=HKEV8btwtY0oyszMv+R6EYY1tyxGPvcJnZ+SKXEFWyC9HY+9RVDucI/K8DAB2H5L/e
 uFZm4lXK/zd83qBtSfyP2kIAnmEQmdjn7jWRdG2Tpu3lq8Swfk/JOD6OMZ+KQY0oqmnT
 cOPNCT6ZkLaBuNxYc7uEqpYEndxMpUtzZUmTQfYtcO59QFDqL8dtU/GfwOdEabSo/9x+
 1VEgLwIKoGm9lyyb0KXkeGJw2vDsURuSA+VBmPLHFhZ8spZBw7lTjyLSMJi7POiTUCo5
 K15qNNlTqn7QGBW4iHsTKGatNov+VynuQymn2S/PS8aCB1XxXvAMz4KQQscPN11UCPbP
 clKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679933509;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NkmiU4zmCqMgcQF3NLXiMPPrYfAfqOPOoQedCxNLha8=;
 b=MkZ6PSkovPfcaMi8Mtsf5Sipc93JZMl0F1SuX8866Lprafn94yvYsHf1p1chAf07de
 iifuvDPsNm+NfWimjxeYKDz7PE6XvInI1CZiInVPBZGVm4LK2Mp1lxoVhyuLnNm4ZqLG
 SvN3TU3vIIHGxA42FRnCKLDlfSKv9eOD8l9M99BGuqMwxEp9v2h2PmIO+eQDBuUpfZvk
 PPsGCqHrQgy8pQpfx4+D90iX25e+a9hHl5ANC18tQYFvIr+axxGG8/9aiDg/GSOyf8Ry
 KVXJ19CnGHv5JdzUnmM+IAY2IGtQXG30xvGHcqbPEEk2DaOyZSQHFX1QeuRE6sBc4ynY
 v+4g==
X-Gm-Message-State: AAQBX9eKdOGYEJHooj5KgjQC05NDdZPnvUYspTE3Nif8sTz/AH//sRqr
 mNMlSXWyWAPECzMQJV/QpZC+ZcaHqq+KyCZ9ov/6DYBTQ6zkgssEmEfyEANq0bmiwRm7e6f0pWG
 R91VLkgGxAIawX+EsVZtUmgQ5LZJF4d6g0L2b2LBlDWvs6UOqHWRzmMOL
X-Google-Smtp-Source: AKy350YwLdvh3IxpdDqMD/5c7yMXcmTuRKpCJgf8fuG0i2pTXjbLW2YuAT8XtM/YHLkWasWi8ZgEoAl/7TI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:100a:b0:b76:3e1:c42d with SMTP id
 w10-20020a056902100a00b00b7603e1c42dmr7761408ybt.13.1679933509041; Mon, 27
 Mar 2023 09:11:49 -0700 (PDT)
Date: Mon, 27 Mar 2023 16:11:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327161145.1702680-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] tst_device.c: Handle Android path for backing
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

v3->v4:
Rename dev_len argument to dev_size and update documentation and
references.  Remove != 0 as it is redundant. 

Edward Liaw (4):
  set_dev_path: Rename to set_dev_loop_path
  set_dev_loop_path: Change return value to zero on success
  tst_find_free_loopdev: Check return value of set_dev_loop_path
  tst_find_backing_dev: Also check /dev/block/ for backing device

 doc/c-test-api.txt                            |  2 +-
 include/tst_device.h                          |  7 +--
 lib/newlib_tests/tst_device.c                 |  2 +-
 lib/tst_device.c                              | 51 ++++++++++++-------
 .../kernel/syscalls/ioctl/ioctl_loop05.c      |  2 +-
 5 files changed, 40 insertions(+), 24 deletions(-)

-- 
2.40.0.348.gf938b09366-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
