Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6338C282D3
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 05:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741151313; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=bftfvT0L14HCAyRJa6VNHr2YmkJ4ZgeuDW6SiYMwhb8=;
 b=ifjFfeqGws116IFNujdYkqgRSb9BV1VmXiiZ9lLh1xhmdl/hCTGj9BnqbgG7R9C4H7oWE
 ZF2N59cMl/KjsRSGE/VnCVaBRG44SUju7nuzY60whjStDGBP5fsjFpIX+UDKY2CD6hWPvPf
 v2yBimCBNeOAb+hCrEODoV7jLg7hYMc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F5463CA066
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 06:08:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 250F33C7B04
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 06:08:11 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B385223D8E
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 06:08:11 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3bcso7353118f8f.3
 for <ltp@lists.linux.it>; Tue, 04 Mar 2025 21:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741151290; x=1741756090; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kb1+EaAE8uvAGJhz1Hs7AFnAp5A+RczA4ZnOFPr0VLY=;
 b=FkLyE6NTn1BLAujVADwGI80KRjzwOVEO/3m6UacteKvE5ESgKHr96T6U8SiIP9zi6N
 3YAdVlNF4o3IMXVjaMk+aZ6Mn6tLnEljLo/E2GIkOg0vcJwafiRapPbqBoSJqBjQ79Hx
 oaT9Lc+cU7Mz9XOXk1oTtAzL8mRClBdr/4+8uafz8zJOScjs4DjDYQkhItsy/+AMeKpq
 +Dtilk7R4jzY+N7lr0hsVdIejrrLe5kZh/Bx/4H4TpIpvAclXoxmbJo1NpcvFWgDrt9F
 iL8SIdl7vrjDYOReEd1V57JmUfBM0Klu78fyVekBosB+bptW5qGhtM1PCO4IaPNeF4r1
 mJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741151290; x=1741756090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kb1+EaAE8uvAGJhz1Hs7AFnAp5A+RczA4ZnOFPr0VLY=;
 b=C0qg6lgPMzM9xTUCnGFJsxvCV9jz22yyQtCs/IyzVs6ISaxmCQ2b+S5b9PgLinEZ74
 jD5Ag8jRlwWHAncH2QnWEf8+as0LoBtkmymp9YW1vBTgRXZq6exDal+gYNVwoSIwp5hW
 ROD7nyAYWfEJmRhHJ0i+aJ4SO+YfCIb6jbwDkBLa5SlzaORWinlvsPP7kM84z9YG4uUF
 mEIPMZ0jcfdSaTkg4PuqAo0R2s1GNVy8gX51vqVR4lPdRQSqt+BVITl5Pp+qAWGrh6jF
 rXwuLo1DxzyfFcGxbQKgWSRVjh7Z5IQQ3wnSZiJABeqJ6Z4SeFgnnM/wlr8m39V/jURn
 5diw==
X-Gm-Message-State: AOJu0Yxe76amP/2u2Qb0SXqLfLgbmDa+qhOuxr74LsuNJupXjflOrPDZ
 ONHzJe5i1VMQPcaZ/OBZSIdkxH193jmWPbp6SeuSdRa6YosYKf5h281nJLf0ilxKzRjVTA8sNsX
 9LA==
X-Gm-Gg: ASbGncudpBpq4S3rqqLKlwHaJLr+MYUl9UKzzH8091CC2tJbcCO9wID3Ss/rHBugiFg
 tGycZu/ZAjL5XmIYm834CbEpkOj4MyYjLKmXulLu8GNNLOHn8dZja6BSvMMEkwHLrLpRJIZsQ6S
 F8qqzihcCzoWSz+8WG/hEbjVRVLDqEPHa/hoVDB6J5x6P6yN6/uog8nradDaClnC+vcv8z4NAXt
 xNdLkBa3etIH3zre96V6SI5ALuaMNpwGH/vFxtXUzAKL6VOCxsQ6CwMjbMFDclNub79CsRSSOQT
 ndTvQJcHfkG/cxqymFR4ZDyvDpuQjjaUxzcmZ7Hl+HsR
X-Google-Smtp-Source: AGHT+IGIpgpXdD0yY9jPmKKYVmJX0MvVPE7upljgzjJOsLZedKxe6R6JSjN5P8iyOdkShmozhg8HcA==
X-Received: by 2002:a5d:64cf:0:b0:391:212:459a with SMTP id
 ffacd0b85a97d-3911f7406c9mr924888f8f.22.1741151290415; 
 Tue, 04 Mar 2025 21:08:10 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4310539sm5841435e9.35.2025.03.04.21.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 21:08:10 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  5 Mar 2025 00:08:02 -0500
Message-Id: <20250305050805.7905-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241209060117.16870-1-wegao@suse.com>
References: <20241209060117.16870-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  cpuset02: Convert the test6 from cpuset_memory_testset.sh to C code
  cpuset_memory_testset.sh: Remove test6

 lib/tst_cgroup.c                              |   1 +
 runtest/mm                                    |   1 +
 .../cpuset_memory_testset.sh                  |  37 +----
 testcases/kernel/mem/.gitignore               |   1 +
 testcases/kernel/mem/cpuset/Makefile          |   5 +
 testcases/kernel/mem/cpuset/cpuset02.c        | 139 ++++++++++++++++++
 6 files changed, 149 insertions(+), 35 deletions(-)
 create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
