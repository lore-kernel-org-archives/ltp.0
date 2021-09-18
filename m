Return-Path: <SRS0=tzzg=OI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DCDC433F5
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:26:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90DE61039
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A90DE61039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E1263C881E
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 09:26:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D80863C19F3
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:28 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 982C21000A14
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:27 +0200 (CEST)
Received: by mail-pf1-x42b.google.com with SMTP id e16so11344054pfc.6
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9ZZzfUTOtc2cpozBBR+5QxRRBV6ISuJdWeQWI6no/fc=;
 b=qvQEh1eajdZrrEJ6EbvuF5a5AA1niHKeNQUOfMErnKZNGivCObCB8PPg7ulbtH6/Nu
 8DqwEQzxqP5Gs+3BwLNhU4ZFm/lH2/heuwcOfMsBYh0BnmHlh/uc1LqLPQeE1B74sr9w
 KBY8gKGSXHqK2lYJHfwEOGhfYVNxonRZJSghxA/LAg3kZqRHrvKuce4KDPgrv6wu3dF+
 OrYtuN5sZ5FkryuD5+QAchni8Hm+DtHS9RjaJopIEAwgzJYoZwRf1vulJiyCqLV8j4cF
 GGGsMQHGz69rCXeA0S4yDXp8vtTawhHZOViKRViuiK+Plpq9udy6Teed3PQIcbfFaPDP
 UKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9ZZzfUTOtc2cpozBBR+5QxRRBV6ISuJdWeQWI6no/fc=;
 b=vsm0B2E42JH8UuT6uxc/btdhsikn3DFnUYXmUrN0J4S0HAfiIE6uBS5NakFvCuzGb/
 OIqWzgYlH+9r8C21BHC3RIHpW8ESoSmUBgEtUUaRfrmVaCbKPXdZB1fQjoW5BzZhWU5t
 4LH84GqsIhUJ1ptosczUF72/6jFbQxldFczyb6Dv/8DSd12Hcr38AUkjgZfAjNPVSM3F
 FYKkFfrf+pIBGpwb5Khaxbo4bMhf4iEPb5iwdjrRZFmJuuTv7SLNvouM502V0sczqRoz
 eWZHZsABD6Uv2zBhbneEMxWinjF/UzKCf7Xv2+R0jtaoHvpLt0djapHnZyAb//w1O62M
 XBuQ==
X-Gm-Message-State: AOAM530O4zAPXYU0RCiuFPYTr18TpaX9yKS9rdthfRAdkWFyCVDbJKqg
 e4RICIzcgkOL9pEEyEGcbJDxOJccX1GHYy9A
X-Google-Smtp-Source: ABdhPJz/CFw6cnDUNGG55HsHat08l7u9GKdhqriSxld9FUm5wN5aJIE8KFLd62QEWZtvuXLSbI43oA==
X-Received: by 2002:a62:3887:0:b0:3f2:6c5a:8a92 with SMTP id
 f129-20020a623887000000b003f26c5a8a92mr14734992pfa.8.1631949985791; 
 Sat, 18 Sep 2021 00:26:25 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id 4sm7334159pjb.21.2021.09.18.00.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Sep 2021 00:26:24 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat, 18 Sep 2021 16:26:04 +0900
Message-ID: <20210918072609.8576-1-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/5] Convert syscalls/dup2/dup2{01...05} to new API
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
Message-ID: <20210918072604.b7wtfZGnnRKInRoO-Sj3O2aRzGD9luGXkJekqXW-Xk0@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Convert syscalls/dup2/dup2{01...05} to new API

QI Fuli (5):
  syscalls/dup2/dup201: Convert to new API
  syscalls/dup2/dup202: Convert to new API and merge dup204 into dup202
  syscalls/dup2/dup203: Convert to new API
  syscalls/dup2/dup205: Convert to new API
  syscalls/dup2: rename dup205 to dup204

 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/dup2/.gitignore |   1 -
 testcases/kernel/syscalls/dup2/Makefile   |   2 +-
 testcases/kernel/syscalls/dup2/dup201.c   | 175 +++------------
 testcases/kernel/syscalls/dup2/dup202.c   | 205 ++++++-----------
 testcases/kernel/syscalls/dup2/dup203.c   | 259 +++++++---------------
 testcases/kernel/syscalls/dup2/dup204.c   | 164 +++++---------
 testcases/kernel/syscalls/dup2/dup205.c   | 134 -----------
 8 files changed, 226 insertions(+), 715 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/dup2/dup205.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
