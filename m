Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065D2C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 16:45:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B00D3CDA40
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 17:45:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DB2B3C0796
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 17:45:23 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96336100046D
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 17:45:23 +0100 (CET)
Received: by mail-ed1-x52d.google.com with SMTP id s12so8903290edd.5
 for <ltp@lists.linux.it>; Mon, 07 Nov 2022 08:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BccJMV2LlbV+6QtOI1OEnY3pr3jT7pGVrWOSpGzq32U=;
 b=qbWQqCd84AitM5pwJIXxhSOzpyeY8RvVI/BAY8aotTFEtCSx8I+UdjUDU4Sa5jCExD
 vvn3EoXuCQoPSQz65/09Mukeuu7WB7cb3OtTO5xY0jFVifdsh/F+cEFkwV4GgJ1EUkaN
 u7foJRjpdEWTj2mQDsU3XrTqmBXyH9SrN1lytau/oVEDWRUgn54pW50wz1H808y1DFZk
 IQ80ECl6sfbS+M5YJDK6aO4aZO8CS2ljrtilgpwABSAx3WDWCaVEn8qKeUryZU5ubZeW
 s+9djjQ2MDCVHhzGVqPqjPXhB71oYEGuV/oXj/BJ7OLuJ/vXKsUSaQ98mVVUoCv9eGQj
 kNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BccJMV2LlbV+6QtOI1OEnY3pr3jT7pGVrWOSpGzq32U=;
 b=Cfx3TMPr0VFrL6bZUQK9s+QhnhP4VliAJY+kIxjQFaA9FaJElOt8AWj7C4w6lMjkRK
 qjvBgNewKDJGqC8WW2xZLmc0FWWExBBtnb5Jp0hZ23Fh59ZKuIL3Q6tCdZHZ2uG5doRq
 Dy8pDcfH/7GdyLeKRioKQiCXu7qWk2tVpJOt3+sl73SJUs/CgtmlKVxT3zpQKXy/IIoA
 pyhSqpyripxgbrVxzAweQ6gWPVOnB9IJOc0p/tgCECVsO3FC/w7LPHpoFY6JqiUujCqJ
 vg+CyTPo8seRfZRmShAfupW5Kzo/BsBXsTHevkIoo0QYsh5pVJBPT7v5Q0KleNAqkamW
 gBAg==
X-Gm-Message-State: ACrzQf2FS3XnpdlpEPHLO/OB+uHPdpotXO7SjerXol+me1m4WitVyJu6
 ZgbqtLtPavAZlvGg4mJGQn1Ab7VXSk0=
X-Google-Smtp-Source: AMsMyM5Vp4o0AWJWgWbVfM1jcO6YH8FKKbmhAJ6J5S32lAytkSzH0IH6LmAls4OJCDIWUJrmugr5jA==
X-Received: by 2002:a05:6402:2903:b0:463:19ca:a573 with SMTP id
 ee3-20020a056402290300b0046319caa573mr779909edb.31.1667839522626; 
 Mon, 07 Nov 2022 08:45:22 -0800 (PST)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 17-20020a170906219100b007add1c4dadbsm3645684eju.153.2022.11.07.08.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Nov 2022 08:45:21 -0800 (PST)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  7 Nov 2022 16:39:55 +0000
Message-Id: <20221107163957.721315-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87h6zbxgc9.fsf@suse.de>
References: <87h6zbxgc9.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fix tst_find_backing_dev adding BTRFS support and
 /dev/root missing case
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, rpalethorpe@suse.com,
 acarmina@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test is specifically forbidden on tmpfs, but I agree with you that may
be some weird scenarios where the major is 0 and the filesystem is not BTRFS.
As predicted, if for example the ioctl_loop05 test is forced to run on tmpfs,
I found no way to make it if not change the code at tst_fs_in_skiplist, you
have a confusing error message:

tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
tst_test.c:1278: TINFO: tmpfs is supported by the test
tst_device.c:94: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:545: TINFO: Use BTRFS specific strategy
tst_device.c:563: TBROK: opendir() failed: ENOENT (2)

LTP_SINGLE_FS_TYPE, if it is the env variable that was mentioned on the
previous mail in this thread, seems not to affect the fs skiplist.

By the way, I modified the code to produce a TBROK message if the ioctl
fails.
This version of the patch produces:

tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
tst_test.c:1278: TINFO: tmpfs is supported by the test
tst_device.c:94: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:545: TINFO: Use BTRFS specific strategy
tst_device.c:562: TBROK: BTRFS ioctl failed. Is /tmp/iocVvqexV on a tmpfs?

Thanks
Alessandro

Alessandro Carminati (2):
  tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent
  c-test-api: Documentation updated

 doc/c-test-api.txt |  7 +++-
 lib/tst_device.c   | 91 +++++++++++++++++++++++++++++++---------------
 2 files changed, 66 insertions(+), 32 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
