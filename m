Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA24FA3740
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 21:58:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE7493CA94F
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 23:58:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB6753CA88D
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 23:58:13 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5D9B0600D27
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 23:58:13 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 c91-20020a17090a496400b00212eb50e75cso1557696pjh.6
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dQEf8kncBwknQcK0o4nJCA0XnTYtwqbCS78yzlt3EZk=;
 b=F31ru6bdyQIyZuS05wxiUypQ9mxWF+3VFRmu9D1Z1KnIP0LgYtLSMQQ5lotT6zA2iv
 sOaA3gpf5dOhdnX+cIIBlQ/nSPicQt2jJcCBz6k5sZimqjRsCFUsUkvvGyGw899/qyMB
 KO4WsJKBVL0sRNSh+scLtDnBM2aDLJWSkYWtpisOpvkKeYbkUnYEgQD8c7ELilxJQMFa
 TnBzoLJtvtzFZGL8Fn73ZnJBxfUixmgasGK/LM9Ez5THwaGtPibJ3GWpX20QEmCT+Lk0
 SGIf7kQg1LSa8fsz5qrKd8fOts4qq5Fool6dw78J3StEmjyFH0GjiB/+wBDrjdNSE2Ug
 zOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dQEf8kncBwknQcK0o4nJCA0XnTYtwqbCS78yzlt3EZk=;
 b=6rJcqLwqjIYEuX7EOfIGkV+Gp4cd0iJ5RBiXtDOuug90aPrAwBpDI1ZV0JmeJO1lH1
 DJ3Uti2dFEinCcO/3vz6OnCbqI+jejZkKrdQKDvN94ScZTl5YUsyAv/77Xi91yGZv0OZ
 yw3+aHrdxmhwTanwf2EJANU9LG17luqUwOPnIB80OJXY6Rdln8PW8wE9XptvyRWrNWh3
 VBynJkNcsEIUKY1I6Ff+I0Pdi9PiKUxIgU7X72NWwF+vAgqekPq0sbvKGZZnO9OIDHfj
 Ek47yp+8HgmIyT109GKupqd8huPM/YIiIkyTzVsT1cqPVeooEnLfJ+poqY+piQl4l83m
 96Lw==
X-Gm-Message-State: ACrzQf2azPBWS9BrNA3R9EPBRJNCMQ7UUCwVoHDKGfxqIiPdaWHVtgRF
 6A3o+NGSgiTvup1A8swfKBfxxe5vuvd2oo7LBrAAQ0Js0ZtsDrSKj7ki3sNBG6q5r2nUSGsWznX
 EV1wQbR3C4OxtjWeYMpD/VfS2oTilFtbzhbwnJWdb8OpjeZ0i4Iw2b9oV
X-Google-Smtp-Source: AMsMyM7c2FpuyX6vtM2LpDVO62tWro92CSheo2BD+VmZB6GWdMU/SI7AaOAfjvHHxorBxniV9MV9zHkVECQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:5617:0:b0:43c:9a42:fe95 with SMTP id
 k23-20020a635617000000b0043c9a42fe95mr43411700pgb.446.1666907891436; Thu, 27
 Oct 2022 14:58:11 -0700 (PDT)
Date: Thu, 27 Oct 2022 21:58:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027215808.4126148-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/1] mmapstress01: refactor to ltp framework
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

v6->v7:
* clean up pattern option
* always print configuration info message

v5->v6:
* revert pidarray removal because children use the array index to
determine read/write locations
* add option to specify pattern for reproducibility
* set default nprocs to ncpus with range between 1-20
* remove more comments

v4->v5:
* reformat top level comment to docparse format
* reduce amount of verbose comments
* clean up file size bounds definitions
* make finished variable volatile for >1 retries
* remove unnecessary pidarray because offloaded to test harness
* remove unnecessary sig blocks

v3->v4:
* squash previous changes
* set defaults of nprocs=20 and max_runtime=12
* clean up comments
* return TBROK instead of TFAIL for unexpected failures

v2->v3:
* apply make check lint suggestions
* refactor cleanup
* use SAFE_FORK
* update license

v1->v2:
* clean up formatting
* remove accidental change to header comment
* use SAFE_MMAP

v0->v1:
* use tst_test framework
* use FILE_OFFSET_BITS=64 instead of LARGE_FILE
* use safe macros

Edward Liaw (1):
  mmapstress01: refactor to tst_test framework

 testcases/kernel/mem/mmapstress/Makefile      |   2 +
 .../kernel/mem/mmapstress/mmapstress01.c      | 886 +++++-------------
 2 files changed, 261 insertions(+), 627 deletions(-)

-- 
2.38.1.273.g43a17bfeac-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
