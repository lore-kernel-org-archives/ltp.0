Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15193ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:43:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A9D03CA96E
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:42:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD9A63CA8F1
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:47 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41D442009F6
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:46 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id bp20so11389498wrb.9
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=CAfdbXOCwgxJFTL8avHG3yfTM7JXdTgqCR1Fwq4XRNw=;
 b=c0LL7/FonbKZALKMvF/cSlfkxwQQAG8KvfrTf0bz/VK0zKJYxrpthxXPuPPhkZYnzv
 V/9E5wmzc+N65Sls9RjAKSJmqkhPg+JU2njqiHOhKX7EZ7B/c+g19vIVht+KW8YfmMnZ
 qRQ6K8xortFgs/qZ8yO2/fCDfeGS+U0nWIMk7SFnFeJDzB8H9LaiMo6U7yj2H6MGV9qy
 vK2FkZbKEYTs2sFJ2btY1CuvB1UL7Ug8IMemW7kQsZJZC4Ut4WoNqWqShRR6i6gOoP83
 TSuS4zf52gZQrT+fJxHrWdEU73aq5tYV0SSgS/ic8xJPj0QX+nwVKjE+81xovEMVDZxi
 h8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=CAfdbXOCwgxJFTL8avHG3yfTM7JXdTgqCR1Fwq4XRNw=;
 b=cO2HAbTZYCZGwTC0ySPQYzz88T0fKnDxOMe3+ayaRM9NzwVg1un/iGBmmxaR6EO/qp
 +SfCzWtLJQZ9LKj5e2mgNztbwyqee4+G7BUWJbTu3fZrPJDMpKGrMpG7LK8sC7OeCY1z
 y/scsyd1E801qaWvRSvVDmFmFkMT9BeQ8d1UkYkfp99YksPR2UPnp6HPimnFVRkRNTMs
 cR6/72+e169TQwCNga6GEDotedfXpHJKi9XVCqkEEklObyMxkow0ddZJ6OBevDxUpd6y
 bbvMFzMBxn0GIW7DwsXZZseH4Jlergnlu2mQ52/H0f88M2xzTSok/NIp7eKt1WthdrIM
 xeeg==
X-Gm-Message-State: ACgBeo3yZZB5rchUYW8+s8EGKFeYV5xL9F99ssdhMpP4Wh/Ef96LMit/
 WjsQLcnivcvOgy4rWMjI95pUhZB2Fog=
X-Google-Smtp-Source: AA6agR4GXDOPlaOoJpgGPtuusy6Lu83oEgZxJPw31xwdzLVC+x6c5lQrMsNGH4nvbx+JJSAX3c6XVA==
X-Received: by 2002:adf:e7c2:0:b0:228:8733:3a6d with SMTP id
 e2-20020adfe7c2000000b0022887333a6dmr3164606wrn.215.1662392565653; 
 Mon, 05 Sep 2022 08:42:45 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:44 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:30 +0300
Message-Id: <20220905154239.2652169-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] Fanotify tests for FAN_MARK_IGNORE
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

FAN_MARK_IGNORE feature was merge in v6.0-rc1.
A man page draft was posted here [1].

Following are the tests for the new feature.

All new test cases are skipped on old kernels.

Note that fanotify10 will run ALL of its existing test cases
in two variants:
1. Legacy FAN_MARK_IGNORED_MASK
2. New FAN_MARK_IGNORE

On old kernels, only the first variant of the test will run.

In addition to the new test variant it also has some new test cases
that only run with new FAN_MARK_IGNORE variant.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-man/20220904155113.2623371-1-amir73il@gmail.com/

Amir Goldstein (9):
  syscalls/fanotify09: Add test cases for FAN_MARK_IGNORE
  syscalls/fanotify14: Require FAN_REPORT_FID support for entire test
  syscalls/fanotify14: Add test cases for FAN_MARK_IGNORE
  syscalls/fanotify10: Avoid undesired event in test
  syscalls/fanotify10: Add more verifications and debug info
  syscalls/fanotify10: Use dedicated mark type for inode mark on parent
  syscalls/fanotify10: Run tests with two ignore mask variants
  syscalls/fanotify10: Test FAN_MARK_IGNORE with FAN_EVENT_ON_CHILD
  syscalls/fanotify10: Test FAN_MARK_IGNORE with FAN_ONDIR

 testcases/kernel/syscalls/fanotify/fanotify.h |  19 ++
 .../kernel/syscalls/fanotify/fanotify09.c     | 102 ++++++++--
 .../kernel/syscalls/fanotify/fanotify10.c     | 186 ++++++++++++++----
 .../kernel/syscalls/fanotify/fanotify14.c     |  42 +++-
 4 files changed, 290 insertions(+), 59 deletions(-)

-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
