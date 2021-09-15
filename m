Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E31C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:52:26 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDD460BD3
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FDD460BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD0B23C89B3
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 17:52:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 575A83C55F4
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:13 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B5994140115C
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:12 +0200 (CEST)
Received: by mail-pg1-x52f.google.com with SMTP id h3so3134371pgb.7
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ik0rnKZIWh5cQh9LrELm22GW+TakhVYjWjdYmcqj4Rs=;
 b=eeOUmxfFrtjWXHzIoJ8vo56+5k3H9R7B0fKNws3jHw001NPpO2iA68RRufCG7q0APF
 75SOt20NmRgj1diYdH6LYBk8Y0yfExAW/9+vxJch0WVDq8SU8pTqLbwJVbQyRvQU5n0G
 9mx7ZOGg0IPIz7CPYwaAxVxb7XoLy/8wGl3Irnf2fDyHRsQvsOEx1QiBQCHPIh3SVEF1
 pu1/waXGil0JrS0vdRUA7V+fidxWir2UMpmAEcNPuOdwRxEMrtVYRbt6avq2Har7oilY
 YjPzk1Z4c7DAoionM7o0qcZ3MRQpq3vZo0WqPVK+klx3W5K06AEQsOgB0YQxdxFEzxLC
 8ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ik0rnKZIWh5cQh9LrELm22GW+TakhVYjWjdYmcqj4Rs=;
 b=ptV149afU/WeG4S3dHmOc4VkglllxI7ogXjXI4UDq3ykXlD7uAqlYNjQd8H1L2vPYv
 OeK6H9GGWW4jtCzwAinbyQ37UozMKGavqsPUEtDf0jieW9bLQiG2BGqZ0a+G+XK28boO
 mwiRCTsaxkHbQn1VPUcnA8am0wegFPfBG5uqvfM4ID+CbfgIUVhcyEvbyN5ttzVHD6Mk
 seEp5X5MrZiK3TVGk2pifh/nAbcGtnFm+GLib1ZIztvHHhHM8h2rhE1HpfP2om5katgb
 Q17qhWxmDL/hJMaqflvvNoC2jFDzR70uxDb9L7NCgTrHzsO3Z4WKjpMGFQWXeI0OmmQl
 yyyw==
X-Gm-Message-State: AOAM532CGn4eBdQmgVt0EvS0ZG+gdEgipD5/9QvG0rLUyxi6uc6J9hF6
 8QIm0BRlJzZBKkevRT83wLOryvZqneuwv/Qo
X-Google-Smtp-Source: ABdhPJyma3A0tbEMejd9RNZ+h3CSXzJ9+Pr366o7uXIUk9d5h+HoJ/Pf6xjQtyVGC6s5oHzbH/icmg==
X-Received: by 2002:aa7:9626:0:b0:3ff:6d8d:1d25 with SMTP id
 r6-20020aa79626000000b003ff6d8d1d25mr179274pfg.80.1631721131010; 
 Wed, 15 Sep 2021 08:52:11 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id l14sm5452484pjq.13.2021.09.15.08.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 08:52:10 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 00:51:48 +0900
Message-ID: <20210915155152.8515-1-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] Convert syscalls/dup2/dup2{01...05} to new API
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
Message-ID: <20210915155148.kXjrBCAvEnQiIt_4oCvY7T9miJ5HsS6ELQqI8Lz8pRc@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Convert syscalls/dup2/dup2{01...05} to new API

QI Fuli (4):
  syscalls/dup2/dup201: Convert to new API
  syscalls/dup2/dup202: Convert to new API and merge dup204 into dup202
  syscalls/dup2/dup203: Convert to new API
  syscalls/dup2/dup205: Convert to new API

 testcases/kernel/syscalls/dup2/dup201.c | 174 +++------------
 testcases/kernel/syscalls/dup2/dup202.c | 190 +++++-----------
 testcases/kernel/syscalls/dup2/dup203.c | 282 +++++++++---------------
 testcases/kernel/syscalls/dup2/dup204.c | 128 -----------
 testcases/kernel/syscalls/dup2/dup205.c | 167 +++++---------
 5 files changed, 243 insertions(+), 698 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/dup2/dup204.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
