Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E957CD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781602305; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=BAmI5cub+ROey3os0xuaedQKyi/hufibsOtbrzDj+mQ=;
 b=jyR1/GMg9JzcpvESv/PvgQusDbQbOQl7m7rQ8kWB0kWjCbetz45FNY3M+CKHStj6EAcaB
 hJSgH3Q4qj7RloUTyQpu+o49HUMJnoyftPTOHCSfLhvEAa+vfHLPZRIQrwKSByZm1gSXF8L
 7WNsiee/X/XZtn8OnFd5Boad4H5zenQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C4253E4E5F
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:31:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B873F3C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:31:23 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 55F6F600D7D
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:31:23 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso38204325e9.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781602283; x=1782207083; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXpMnyr8PofnjhylZGC7252LReax9UOEbz7tBG0IyxM=;
 b=LCblhpThcUZIdeERrZTkhWm8oqRZ5l41yzPHErpg+69mivuOkN+6HrqFxC0sX30IcM
 UNWg2Eed5qucc4FBr+wkzG9xX9Oh5TkCm8vlCWFCUyG6ILB5j0z3IeSexYaw6K3iHeBv
 jXIdWa8GAXq2SP5IajrwENOfzYw1rebmLowCUoYoFM7VNZYhNp60+dJjoDyJ3BkffoWX
 o9sBHCtUnUm8fpfDMxshSpFvJ0y5Hn8IJcJpUvbfKKKsbD4Tdqw0xEwZF25kZLHlzSJL
 nXMaCTV4d9FSNIoIoZptvQLesuOueLf9W+KPCYCUyG8axj2R7ThwpD6F1WeeIvMMMge/
 CaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602283; x=1782207083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hXpMnyr8PofnjhylZGC7252LReax9UOEbz7tBG0IyxM=;
 b=azQr4MxGnhBTV9zdobzgOIMoNoec0MQzwEoidd3YGcDsuy+AzVqxGYPzKdS+DviS/V
 fJllFaabsNBdB843Ept9KjxM5Js81B0ubl3xBSIeEzxwQNHgsdapysVDv3oLmbjZjf2I
 ODkCfBiFmMa+IXfI6Gtdg7G5wdTS3zvv7AtVJfTkWDZsEhqclrNubEucC6eSk+2DDMA+
 jJzQUvQZ3D8NOjNi3CV9yJwvK2IgCKZyP6yDqSvOJWrvZs2p+jO86iSs/soilZ6RUaX4
 k50TvFyxFa5B9U0XqYULNIX05jIOeCkjsHDiLUVlvN6oh4TZuXun7b7DPOrToc/tUjW8
 AzcQ==
X-Gm-Message-State: AOJu0Yw/ztevMZVql2gcFM/KeAvxp3G3iPtzyolcrlSbSpProVC32kWc
 BHyVJS4mpDv4MtFSBFKxOzC/M4F0/S55t/L6v+NLwgVQzjm33e1ob83ELZV2e3Tum5dTL+Sc2V3
 4R3E=
X-Gm-Gg: Acq92OE7VVMcd2sZz+Y19CpVaTcFTsF0JCGZasveQDZ/fuKXltvaya7b9Wh52gj03ir
 wosdepx+GLPGgKSFUqCepmbFdO+/zR90YUZX5fNwDIVZDQWGwJl+RT1mMQIOztWuMZ6D+nRTh+N
 /8hThK6be7zST/X77RsQDleVOe6bTNB9lTnOtzvA02jTpeq8MKU1HdQBIVu08fTTrwXXUxocHrw
 yCj/Yr4GJeyz0rmBug1oeQnwW8PHNNdSihhopYlMJhO6HYcmKlE97q4O6PBROLnwqnPJuD+p8B4
 Dh71WLBal3PvD4Pn3y/QIB+u6RawrZGqsROxNtHzIKXelMlhmFfMeAeIGVZKcP1Bc1RF4CCbIZM
 fys54IoMBhgevzXy7bRGgIqaNbWvmnWsNz2gaa67ta1QgG8PxoXpfPk7qsY1jYD6DVQFe6hTkWO
 c9lHWDyc93OR0=
X-Received: by 2002:a05:600d:640f:20b0:490:e342:127 with SMTP id
 5b1f17b1804b1-4922011d55cmr140481295e9.34.1781602282501; 
 Tue, 16 Jun 2026 02:31:22 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm46628975f8f.24.2026.06.16.02.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:31:22 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 09:31:03 +0000
Message-ID: <20260616093119.8654-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616052452.8353-2-wegao@suse.com>
References: <20260616052452.8353-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/2] connect01: Convert to new API
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

v6->v7:
- Add doc comment to explain why root is needed.

Wei Gao (2):
  connect01: Convert to new API
  connect01: Add negative tests

 testcases/kernel/syscalls/connect/connect01.c | 402 ++++++------------
 1 file changed, 141 insertions(+), 261 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
