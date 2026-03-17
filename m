Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D5FD7068
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773742417; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3bxHluxyPfpvB7K/zqEmQosJM+Ml80ZaYgHexRtakEU=;
 b=HNVt7BmweucPL1fe9qHGyms+jPOTzenJLyqwE95I68iLLnNDEl6A/x39cKUq85eLQl1Qk
 gDbhyelBoQtZgHrI28DBuOB7XrNtyoy9p+I8iwA/CtbByFWWlB9sGB1HRvSNYAwLE7MY8Ts
 MdiGM65Y3av3Xhpl479OUokHuIrLzHI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E296D3E4850
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 11:13:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B8BA3D0343
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 11:13:16 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AD0A6600274
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 11:13:15 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b40fb7f95so2074299f8f.3
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773742395; x=1774347195; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8KMZhXTzYCsfK3x8NUS4MiKm7gfRAYeg+2KI236z4Xg=;
 b=Gmn4xMAQ+M6rnHdNFz7J4hwxBHMBpR8a2Ra3ktzrLMPi7stRUrbepEKIKOBv6lDsN9
 LJg2G/TTJT8lD2kb/kc4b6QMnYTr0o57v0C/59IqZ82nXFlf8/BRDX37h6IBJ30HVIiR
 BVkiy1+q+EerQx9hJcR++fsMUWQ9Res8kDnb6lNk8bKleRF5zFZ4UB50osggxJyHqaPm
 AGaFbXlHWnNOx26/eRdUCy9PWmF6IFE3nvStlUdn3ggZmfU3+55z+ZVCKkkpGCLDaJ+D
 72gWCF6af2SxJ2x0EROkMkE6SrG7nkP5kPuMLvqIl2F5IzVoZARXYGEs4VgZJzbdCtWm
 pyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773742395; x=1774347195;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KMZhXTzYCsfK3x8NUS4MiKm7gfRAYeg+2KI236z4Xg=;
 b=DNqEInyAJdqix/xYWJc1q2c1xbgmdadgo1sIZiqOrZNZLRUb5C9WDcxi4Zjf7r3g26
 pabKKvumoGENHHztW+qcEkTkKIGUDy4xytAMbN02J8l047a8QTyHydlFURXab6VjiW93
 s3ZS67YKCBJ9nHP0pKhZB359/Ngkz8VbrGNbtRjV70uhpc9IXFZPPQa9JeLxBhAHx3Ws
 6YGYNSW4cibpKTufVeYQrU4Mj6rGHzycWWlB/PyJW65itV0xOmOi3jmMsslZzoeD/uVU
 bYV+lUrjO1zXqyBJ3rQyTH0uMfc79MXxoNy4xa+lWBh5H3CgarVP0D7WvuSRgp7vgvBT
 f6eA==
X-Gm-Message-State: AOJu0YyrLPS/ApN/l2ng4LQdP0McQQfk/LeHI0uK0ib+MLU+w4sVVmSw
 MzsLl6sJAX5j6T+o/tzqnd5luZtrsP4Qk9qcuKdYJP9ekcaTHzPb+hdVwzW9uS9p9dsSgitgd5I
 MSJxFK1E=
X-Gm-Gg: ATEYQzyA82pfTvHDL7d101PfU0uWpPLkOHC/NHiiv510bbaH8EQ2b6iNKh78MD/+B0Q
 hmLNeK3fB/nZvMe+p+6M9ZVuo6kvXAaAV0m6CXyHj8xJtGALrX4OBaEbFxvNVMhwSTycTBLvv7M
 sv/DTU/hlLguN4cQ4mdjO+rGbUN0uy3H61fOSeDBzVr5PblzI/HBxAN00qic8ondqcYuthU+VLM
 Z/spGTBcV5sopAIZxWy/sX+iMiO/4UD4LWWFu7AsCdmZKm7m5+ZBBusGh/E223P49qYfUWcYKDo
 juCQG+8dbExiOeBExvLmyUz5DggMv6WNyjqWPcUxp1LES0Myq8jFejcrIZPbSDyhGsLIZBC+7L0
 PermsE5p4y9Thptnq97CLp5F0uBhqgcBM0OvUhheY206Rztwmh3lsm+64dKlJ1m9nDrt8+uqN75
 XdJmxw93zNzn2Y7qAFRl1gZEhKvOD0Q/vbbx2r2++5Hv0w3omzjyRiYz6jKwbk/ED5SyZ7y1nyU
 Pk7yYH+BY7xWC5FJPAiQ5rhIhcTpJY7NCw1padLslv46R+anmF9FeBl35XuhjVBP54xYkf5q/14
 mQ==
X-Received: by 2002:a05:6000:22c9:b0:43b:493c:8767 with SMTP id
 ffacd0b85a97d-43b493c879cmr6423754f8f.27.1773742394941; 
 Tue, 17 Mar 2026 03:13:14 -0700 (PDT)
Received: from p200300ef2f4fc9002549698ebd81b8fb.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b46b41e93sm12448077f8f.2.2026.03.17.03.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:13:14 -0700 (PDT)
Message-ID: <69b9293a.5d0a0220.1d5216.d0f0@mx.google.com>
To: Samir <samir@linux.ibm.com>
In-Reply-To: <20260317095559.5766-1-samir@linux.ibm.com>
Date: Tue, 17 Mar 2026 10:13:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Migrating the
 libhugetlbfs/testcases/alloc-instantiate-race.c test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Samir <samir@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Not compiling
https://github.com/linux-test-project/ltp/actions/runs/23188879299/job/67379374583#step:11:10432

Please always push your patches into a github fork to verify that CI is actually
passing.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
