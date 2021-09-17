Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0068AC433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 10:19:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CDF6103C
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 10:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77CDF6103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D54073C8850
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 12:19:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 933193C8854
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 12:19:22 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90B3D60024C
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 12:19:22 +0200 (CEST)
Received: by mail-pg1-x531.google.com with SMTP id 17so9196907pgp.4
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 03:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CCONt8sX221svskrGZ7kmHtSCFRdAswJcrmbaMeJgWk=;
 b=cXn8fznTb/y9u7QDBz9xQvuCXyM5geCGRvosl5hJ2NeU/RX1urn6MPCMlW0umrLMxo
 v4TItKCuDDZVAQtBl/Y2BUZryhM1f63DlDzfmrjjdlr9LKLfn4ajUfRBXzoP7zi8BUr+
 uAaGhUqXAm2OHQRdbvGZMHxxEOm2nOKuX0qhr2ixECbPy9RQmxQcrf+fwwiKHL/oJ+y8
 L+F2vXE+BqfKaVT5SLuCPebBMiG/q7M15XZfVxdkchcykIYmF2M4L0H4TYinSorzjCPg
 jDZtVfA3QV96q7Z+2W9wvUW51yFgaU9I/I65IU2s7nKxePsPAnrjlktTpEqTx2rf4aRm
 jPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CCONt8sX221svskrGZ7kmHtSCFRdAswJcrmbaMeJgWk=;
 b=qtbP0dryv+paTskDXumC7169IGTxKBRpS9NziR26vLUx5fYdrZjJ11GNt1VLNZ9qiV
 +fv+qsZ1D8HHKtfmjLhMhMuJ4KXOWQ6aTA2ttGiaYI2OIPwdb1zkMmq0DOCe5ZpHf/V4
 OVp75JZ6E54QPxtADTWjTS8SMz3jm0SHnqPf8yqD8YQypWES+e5O344GdQZMUC/ikGtQ
 SZWY6kCu7cglGl+NAFol53APi3ThTDLs+G+PH7mXPK8uD02rMe/L/LcVIAXWy06dAOT2
 zIx/bodlzeEVsp6/Zk2EnJqFZkQ5Hyhm42XtHcdMVWINTnig0csacESWwtsWu9uDhWDo
 DXVg==
X-Gm-Message-State: AOAM5308B2HDPUgPjGzAEzEH/1zVluX2ZuFMkRpw54YwXhPkg57EkAEl
 grv1S0yIT462q9pHXAVhal1UOStUNJhQ0vOF
X-Google-Smtp-Source: ABdhPJyPnWn7SKv2BCbfTw29B8jpXZQ87M34QhSPlqYv8bJEYDhHN9sYzFTduo59tQitrBmX78CcTA==
X-Received: by 2002:a62:3383:0:b0:438:4b0d:e50e with SMTP id
 z125-20020a623383000000b004384b0de50emr9726016pfz.9.1631873961031; 
 Fri, 17 Sep 2021 03:19:21 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id l1sm10208453pju.15.2021.09.17.03.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Sep 2021 03:19:20 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 17 Sep 2021 19:19:05 +0900
Message-ID: <20210917101907.2657-1-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Convert syscalls/dup3_{01,02} to new API
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
Message-ID: <20210917101905.OcvxQAnMZJxvG-XvWHqwD5RBO8MsZ1SmDgR6dnxKCW4@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Convert syscalls/dup3_{01,02} to new API

QI Fuli (2):
  syscalls/dup3_01: Rewrite and convert to new API
  syscalls/dup3_02: Convert to new API

 testcases/kernel/syscalls/dup3/dup3_01.c | 159 +++++++----------------
 testcases/kernel/syscalls/dup3/dup3_02.c | 118 +++++------------
 2 files changed, 76 insertions(+), 201 deletions(-)

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
