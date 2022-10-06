Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04B8C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 18:42:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3714A3CAE21
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 20:42:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2B8B3C2830
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:34 +0200 (CEST)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A3C11001431
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:33 +0200 (CEST)
Received: by mail-pl1-x649.google.com with SMTP id
 m10-20020a170902db0a00b001789bd49db9so1789722plx.23
 for <ltp@lists.linux.it>; Thu, 06 Oct 2022 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xfcChaNwETuOoWrZnrUtGQgXqwQ6IqVoK55+mgCDDrI=;
 b=Vbvh+iUvj0VtEXhNxx4e1wkCepc7OlahhhwihSVqIvoR1rABOABviW35uci0RKMRUE
 HwfaZf3TPZgQidfqkaKTgUOAN2gKTYmevEBiake31WGHHY3JtLrQikaS91rk3RFOUpCj
 g6mLZKqHVZa3i7FbCOElaN9AbgrEub3JmC0ycoN+3+nmlLQ6O5zNak0QlrRrVlYzf0Z+
 v2WQe+TPBHV7hgPF9CcgER5dbeAPVf4Of/thPX4Cq1asjukrTQ8hynbSoJz/yYI1NLZD
 qX/7Hfi5PlE7IqiFRWEtMPy2RsB3iAAR5SW7/u3faRzMU4xSEcuPMEAx2MRK5BdKEVbC
 lC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xfcChaNwETuOoWrZnrUtGQgXqwQ6IqVoK55+mgCDDrI=;
 b=sMzVO4fZEQb6A4ltY5tY6EUCy5Up5vplk4V/J84AljbGzkI+CBgLoNvZTtl8Zp3MuG
 conmVLEUwYTEq1Os8LdYwRj8NRvSrnrdbC0xerdE6w9Pl1FAWMPVgjYzqoEvTzYr0htI
 TPDXocI3/GjWFl8u4lc9e7CY71XGPcKSSCscMCgRXvmY8zsq93KzTBxqlYBtdVojF45z
 d9fkcZEvujI2qp30aoZASHrSRPR1JdUGQbjEfv4LJBPP6r8W0KZ1GyuY0aZTaopOLy0e
 o5WJLH9kertH7HG636yD9m8C6Wy8NPPra6axF9QeorSAjWu66tF5tyR704MC9aQcn/70
 i8Kw==
X-Gm-Message-State: ACrzQf1k6dUd3sXkgIRAjlrPrTsOejNntj8ZnxPfvTZUTYwqjRepLz0J
 Iost23fzzIZ6faRpQvVjcwD6rHiqZJBrE7yUcDR/+2Fb9n/SZSGa37v7rBctzcXcqM8hVlXQTte
 N+i1m3hGi22IuHVRyk5OpbbBvOCpYhfYCWrNBr+vODfALPicDeJgyilw+
X-Google-Smtp-Source: AMsMyM7SVfvw7ysssu0QrXkjD266iPUe9pdeFHO0owQa16UJxM1M58+2LomGo5HA43sOoMMOabhWwiqp4TU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:32d2:b0:17a:e62:16e2 with SMTP id
 i18-20020a17090332d200b0017a0e6216e2mr1149517plr.93.1665081752143; Thu, 06
 Oct 2022 11:42:32 -0700 (PDT)
Date: Thu,  6 Oct 2022 18:42:24 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006184228.3281392-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] mmapstress01: refactor to ltp framework
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

Edward Liaw (4):
  mmapstress01: refactor to tst_test framework
  mmapstress01: default nprocs 20 and cleanup
  mmapstress01: return TBROK for unexpected failures and TERRNO if
    syscall fails
  mmapstress01: use max_runtime

 testcases/kernel/mem/mmapstress/Makefile      |   2 +
 .../kernel/mem/mmapstress/mmapstress01.c      | 864 ++++++------------
 2 files changed, 276 insertions(+), 590 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
