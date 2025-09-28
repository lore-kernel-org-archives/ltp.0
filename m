Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55627CAC5B5
	for <ltp@archiver.kernel.org>; Sun, 28 Sep 2025 23:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759102055; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=DDLYeYBduxUMI4RUvM0rWSO6Wdt7QzP3vxW3/xLQwrQ=;
 b=Tv7PJIHyxr9heWe+o6Zq3J3TJSMvdE7y3CHA8J66HgVU/xK7n2+TKczAU+kjmK1LdVIJl
 IEeD0iNyvXdAH519QLKwGr4+dUJcjmxZTP48MPeujDls2/pnojZl9okFjcRW8Xv4auMF/AY
 W00meKSB4kD5aba7UPqUNKhv166l9gk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63CB33CE1AC
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 01:27:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9413E3C83D1
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 01:27:13 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 98D1E14001F2
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 01:27:12 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b00a9989633so752906666b.0
 for <ltp@lists.linux.it>; Sun, 28 Sep 2025 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759102032; x=1759706832; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFwdq9VcxboYSsaTh8gFKL9C6urMr9Mghu7l+X+4ZbY=;
 b=DomsHjYpdAS+vtIFn6aNKXkKXb6iBLabe6wl2l731612vsOlMJKGz0pU0H4HW/CqyH
 P09+jq6hCwpcpRTSBe+kB7Py9ljgizCpbk/aHDthnS7Gux2qMqfwCrQ7Uc27cAWzcjRZ
 fl3pAGqhK8llAxw9bhVSdbMVgstqiqWgL5b5zSOVmJy1MqzsL76WmUn6p7LZBiA6CuxF
 p5nIMbyG9dMm4AeFR8E+McAzHO2quPmp0U+3AgqyLUfZoxPn/jWScKPcAXDLfaupWJh+
 Q79Izqf5cs8KM8IUH+oOVaFoXhCWxz3V5YyrEZ610aNkaCFr2scNM6sMVEcgQeURKQ/o
 gWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759102032; x=1759706832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFwdq9VcxboYSsaTh8gFKL9C6urMr9Mghu7l+X+4ZbY=;
 b=AO9Iuyf/B74uBdEdWfH+x4YCb8ft9F0nqpxXDzqnep/H0/XcfaVSIYarQbBCCJvEt3
 8Msp2lE034BrGw79CJI4rqwl+u7xqgWq0ESMtsvXGBMUNqVtmeh1acHSzcvpcE4v3gCY
 3LgGJcBd2oOx91jzym+EvsCC1k5mA+h6y7HsCKpgGQGXcDRNyYEEfUP28k2xucNUvBJY
 UaKLbR5Knd82J4JHYfC9P4BIEOfW7CiStJTdP7W+jZ7ax5GqZBBoBGcQSvh2HJOZAbS2
 8UWqJOw1Ah/+Or2V98Y5JGL18Rnn53aZdCTml8BF6H/tM/T89I9s2iUStmzrA1d6Wf79
 BEZg==
X-Gm-Message-State: AOJu0Yw1W40R3NzlqOruanI+Fjd8q/TInmWc6QPmaEpDjjfhX5klGpz3
 Z7kQiJ9EnzNw6UGvndoeBysTS8GBK84YTb3pH1PxJzXXPMr9m8Rfj0MUf6cGUeOzIFhs4TgUAyl
 zlFIzjw==
X-Gm-Gg: ASbGncvgKmZxxTVF5rh/b4VcDCTi5XK/hj/DYRTqW4sVag6IsRWKfjErPD+MaNQv2eR
 yuLULJJlaVITPhAOau1MMN/LG32zoAp/pVa2ahckSceSuXPctGNOkMy/hKWDPtz+WjEz7jBG+dE
 zDTp4tD0ppHaMIiEgUUTdmzsk8ro/g5kAS23gLc7KumC8zG1RFUI0vOHOVW0F4Vg2x4RJn8NVvU
 C09rae3eFJqZiS1Q2dnlLECxuD1bS5PtQ8B7GnRDSr9auC3V4UbYvCRY0t6XQz+bWTlaFT+yvCT
 k51pNfj2IM7v9ZbaV7yprMrpETxtA2slQAKfjWEs/+coj2ktMX4mbSsiPSZxdbNzNouXGVhFFhx
 Q5gRiisssZWjkny/jeW50RRAtnKli5kBSrD0TgSCJvBH+Z8QwloquytD+xoUBsmZG
X-Google-Smtp-Source: AGHT+IFKccQYsiR9O1NSEKriuFsZHoNiQ/E/tIvi+nOYalujfQBnjQXjj8ZOTfb4lQWnOmFaR80THQ==
X-Received: by 2002:a17:907:6095:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b354b480695mr1664615266b.16.1759102031645; 
 Sun, 28 Sep 2025 16:27:11 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b3bc5761d3dsm291657766b.19.2025.09.28.16.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 16:27:11 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 28 Sep 2025 23:26:56 +0000
Message-ID: <20250928232708.24007-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926085021.22141-1-wegao@suse.com>
References: <20250926085021.22141-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] new cmd support option for needs_cmds
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

Changes in v2:
- update base Cyril's comments

Wei Gao (2):
  lib: Add support option for .needs_cmds
  ioctl_loop01.c: Update to new .needs_cmds struct

 include/tst_cmd.h                             |  6 +++++
 include/tst_test.h                            |  8 +++++-
 lib/tst_cmd.c                                 |  7 +++++-
 lib/tst_test.c                                | 25 ++++++++++++++++---
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 23 +++++++----------
 5 files changed, 49 insertions(+), 20 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
