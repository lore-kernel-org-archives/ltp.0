Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36862C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:45:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EE760EDF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85EE760EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C569C3C68C7
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 11:45:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B44273C0CD6
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:44:54 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7150420172E
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:44:47 +0200 (CEST)
Received: by mail-pg1-x52a.google.com with SMTP id h193so2413521pgc.1
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=L/b2GwN+iVZqH6KJ3pYKgkkgaF3GvjyBu/iMDY4besU=;
 b=QoIdeSDoC/S4GZyyTS1Po2ctQYfHsqFGQ/O64z9KEMRGG28PaVch9zAHtBhjsjxzQc
 UnwL8OIjs3htlebXiRFWQoZt9WwxwoQgcU/NeklvNCNS74zx9mG1AG332DmV6Xwh5w/v
 204Ky36SBzek99mU8SROTqmSFvRwPkdiVSqMwJU80WRKdI0LUhLucczwApSiElWpVOR2
 NNCGQv6EIZ3sKNYxDf1kv63267+ML400whQ7EaEisNxEy27ea1nEecHuQMQBohyRFvPp
 3q1hYfA4Q8vppQdtaw/xykmVqZssBNz3nIBgC3uL7tvSv9Qx/NsczJ35RYJIb7zBwb90
 B4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=L/b2GwN+iVZqH6KJ3pYKgkkgaF3GvjyBu/iMDY4besU=;
 b=O/L19rWZAyWDf2pwyqhsGn0CjZth22+U13kozwxRlVWs2CCiKSZMqUhB/xL0IYUYDH
 lIOEaE4geI9xMsIWlryqjxC1lBvf45P+Lijx5B4b15sBMMnLneG5n7pEmuquQmI6Rfb9
 Kxui9MtU66ndtcjdTBP5yI63mV1NDsodWzdu9u3CsTL8F8CIQVVvEAoaQL6AiAsqH88e
 X+EsmRUj87Pryl7vCEO2k9b67Aid2TSIJkLw7710XCLAHkhesS5fC4I0J7Nser9xMScM
 OBCRKyy4sadypAJylGN47AV0uA11APH0dsm5ysMRi7N+Z0RPfUtFfb6uH6+bpQvTTZqZ
 l4jg==
X-Gm-Message-State: AOAM532t9dEjl6sNg6ksD3QE2Nfva/0mOrZ6mX8W/G48GYLbg5Bq6snU
 9JrdD3WfN/D9ZAfPT9yQpmUseEJaGx56fw==
X-Google-Smtp-Source: ABdhPJyviLi5AvUAeNe8NzSdoGtuhjSI+2TKqxFSX2qPpzSnCazkgG4HdqG+bWq23sEuPOer4cyksw==
X-Received: by 2002:a63:d30e:: with SMTP id b14mr23105187pgg.454.1635327885465; 
 Wed, 27 Oct 2021 02:44:45 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:ac4c:4230:ca81:632e])
 by smtp.gmail.com with ESMTPSA id j12sm19114541pfu.33.2021.10.27.02.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 02:44:44 -0700 (PDT)
Date: Wed, 27 Oct 2021 20:44:33 +1100
To: ltp@lists.linux.it
Message-ID: <cover.1635327490.git.repnop@google.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Test support for new fanotify FAN_REPORT_PIDFD
 feature
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: jack@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

This patch series introduces LTP tests for the new fanotify
FAN_REPORT_PIDFD feature which has been merged as part of the v5.15
release.

Matthew Bobrowski (2):
  syscalls/fanotify20: add new test for FAN_REPORT_PIDFD
  syscalls/fanotify21: add new test checking the returned pidfd from
    fanotify in FAN_REPORT_PIDFD mode

 configure.ac                                  |   2 +-
 testcases/kernel/syscalls/fanotify/.gitignore |   2 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  21 +
 .../kernel/syscalls/fanotify/fanotify20.c     | 133 +++++++
 .../kernel/syscalls/fanotify/fanotify21.c     | 363 ++++++++++++++++++
 5 files changed, 520 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify21.c

-- 
2.33.0.1079.g6e70778dc9-goog

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
