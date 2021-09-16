Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEE7C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 10:50:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3D461214
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 10:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD3D461214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C7EB3C891A
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 12:50:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DE2F3C915D
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 12:50:04 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 67ABF200CF1
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 12:50:04 +0200 (CEST)
Received: by mail-pf1-x42d.google.com with SMTP id g14so5569790pfm.1
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYamLoXSjOl+yEJMefa3oD+exTupwgGSDYBt2h8IRyY=;
 b=JEQnN7qeRFhqyHbSSQgKTh8QrAi4TwSAFV6mkaXwRvCtx75QetwmCAsTZ0hInFcucM
 28mK/Y8zRBAOZ+1SBvHj8jiwZaDoI/+fZICgjzBO1s/BoC9gMo0bsAQKNFcn90YJF3lC
 JrAmSxlXjSJnvO3FtP1AYQI+O3KL2eXopyyKRmATCse6PtTxdt/wBT+HWA8uWdvhXLeC
 2NQdaLcTlRc51Hyp0x9CFE3WZrdPoaW7i1CD8hFVLl5oKJQDzUdYvOxhY85xnUIp/f2v
 nLn2Sz5/7qBdsjCYD/OFvBHDOEzADg8/8r64DsaJVHDUdDIdhpd9NveBYptcP7jVHu56
 XCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYamLoXSjOl+yEJMefa3oD+exTupwgGSDYBt2h8IRyY=;
 b=AwGWNudQyxN1uceDaqgix1zJpTyc2VYSjQBo3CzmiY/gsgvaq6ETtJODkykvEPiHBE
 kKXGL3z3WRdG5LIaXGek8xz2Xbz800sLsm35dvfWbRfaVUb5UJJ/iQ6ed4Z2rGzl0Jvi
 R2K/UpxeMI4po2T4TSLcaSlnPqnqwoZthKsEtVUYlflXwn6PgdOC4qLGEHH5BYNzTAFO
 fk6rKChDJtZmCCXygQpNUH6ik/REeDOZy8NPHKr5sCli9xvN0oz53YvHDODWeVG7Byl1
 UcIBXiVuXoRoyjqPQfekp6COeJnvbd+ikDsNKPNhgmsaxEGbt2Zjo5JWOnPhFk2p4vNd
 ym/w==
X-Gm-Message-State: AOAM530YE5S/Bu8uoTD6uMqPgAL1MzAv7rU41C2mVTs19dzRq6d9yqA6
 Fz19T/4v3Qmq6VKPb9VSq+sV9O+biqZJIRMc
X-Google-Smtp-Source: ABdhPJytd0E6aCtPOa+Ao9z9hetaZjRDf0DgDPgGdLhheQ61Ttc82J3aH6A3tgoKz0KnB8kkkBiW4Q==
X-Received: by 2002:a63:3e8b:: with SMTP id l133mr4404523pga.352.1631789402838; 
 Thu, 16 Sep 2021 03:50:02 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id j6sm2831475pgh.17.2021.09.16.03.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Sep 2021 03:50:02 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 19:49:33 +0900
Message-ID: <20210916104933.33409-6-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916104933.33409-1-qi.fuli@fujitsu.com>
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] syscalls/dup2: rename dup205 to dup204
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
Cc: QI Fuli <qi.fuli@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210916104933.G5s3VaRpCDhY6J5IwdbW93opRdz343XOmmRBEl5Whwg@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/{dup205.c => dup204.c} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename testcases/kernel/syscalls/dup2/{dup205.c => dup204.c} (100%)

diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup204.c
similarity index 100%
rename from testcases/kernel/syscalls/dup2/dup205.c
rename to testcases/kernel/syscalls/dup2/dup204.c
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
