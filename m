Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BA0CD98C5
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 19:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA9463E6EAE
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 21:45:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB0A13CC91F
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 21:44:45 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD7F920005C
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 21:44:44 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-91562bf6c12so858185485a.2
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781120684; x=1781725484; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmCV3kvTdPQXSZjdCWsUwapBDVLxZGvCS5HLt6MOoPg=;
 b=ZMfj5rmw2Hwk3sqARl0SKA5GvimAI9gDanHph5u02d1BCo8Zc+sM8oa39W61RevR6i
 EivIdcVwfSiz3gNyWj/N+2Y6e9dGbpIzEPTYJbFJmMRRj7zuzBT7l9QKfpMLVt2kC0Bg
 oIUUqRZ6Et017xyYfRmL38w5XCzX6VU/WAxvSFrXHKZbNQ3yJf1VpOb6WArnZg/4ZlAw
 6zVxm6cfa69460u4B7oYebQL7baEgKEH13lhhJqF3W9qxHiP6iksa5U3KQLX3MvOfOez
 D4ky/7qk1QqznHuOC4rAobVxKelCFOU+my990r1SrRo8TMAGGxoTwyR6qHnXKH8+Ikj4
 jcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781120684; x=1781725484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cmCV3kvTdPQXSZjdCWsUwapBDVLxZGvCS5HLt6MOoPg=;
 b=D+YEGtsTmGe4iEwZlog5YYz7lVZzVp2iaC3sTHUCNWeYGkP7H4OsUzjbsNSzLcWkvi
 SJjpuIyJcruCfPy5/RLF5xdsydjQMKyC31OT7owe8UPjhFyqtgXGrYRzI5Ggtg0Ikblc
 nscjNwPFkea7ekuyqICf7ELyinvf2FteFBzE0wq9fTAhyxcv4F5DdpzvU+6BcYqYFMVf
 DnguM0Q25NSh//mYqh/n33rfe4rvYIRuoqrOnKYwSsugJIspXalChF/YcIZK8LQKnfPD
 Ped9v1nAyTwsyk9IQUnF5eAGhpbI7ukUJRMQU0eI7dv0dqVcInteF/Tu3modsuOefw4K
 yP/A==
X-Gm-Message-State: AOJu0YyUmjznGtM/fx+SFimJqdKgGVz8tQ5Rgr3e1JciVTmEmvatrfNO
 IhUHqYRkNKY0jZGo0pj/7pZk350NABCWIP6AGgDbujxYGl6QU70hSMPs
X-Gm-Gg: Acq92OG1spM+vmOock3nmetpr4CXBu1VjjK+DRTT51NcOPdG5OQ5UBsPrHnzZJBfR14
 FrreyH0lyRsLVTzEEEq/Q2x6ERllOHbazejULlUz26j6BjLjVFHO7wRbRKBr852IHCMX5zDPSpt
 Uncg5U1MzsXY96p5t00PPyIx8mDenWOgwoZrRUHCKU43Me9HyGDB2NVxcOblYaWAQ0brGF0q9XN
 /6cv+uoFpnQvKCG+law7kVhb9aTNlb0wcW19FTQWzpSGnA0PR0rpAGV5YdWV9ESQlQj0TDPHIJs
 ZcfqRbMsJMt7Yk5eupsNCIA9O8WctBOkothDqtEA7F0Dx5V6wbeTJ7qAhb8Fz33Lknqx9biHpwD
 JlDd9GwpqCjTlvftaXglFRTjZ40hGnkq7SnNJZJZbf7fL1QdyN8XodMAaUc/2TvjBqtpSHQIq9E
 u4/jVNB8U74wkz58uswHnzXQWCF/pDK95VmNgW7kLGiYJtVDGX8wtaIJvuElrjBUE+Jem4s4uzi
 UCjZAbf2vM5i8kAKK2KKz04cdGNS5hCMRTxQxEh4KdAEdVGfg==
X-Received: by 2002:a05:620a:488c:b0:8cd:9033:1724 with SMTP id
 af79cd13be357-91606a1397emr88041785a.9.1781120683579; 
 Wed, 10 Jun 2026 12:44:43 -0700 (PDT)
Received: from
 runnervm3jyl0.uwzlcyryxkeuzosgxp3bao2qha.ex.internal.cloudapp.net
 ([172.183.91.53]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a2359ecsm2536199485a.14.2026.06.10.12.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:44:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Wed, 10 Jun 2026 19:44:42 +0000
Message-ID: <20260610194442.4062-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610193500.30783-1-sebastian.chlad@suse.com>
References: <20260610193500.30783-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add io_uring_clone_buffers and
 RDS_CMSG_ZCOPY_COOKIE fallbacks
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sebastian,

On Wed, Jun 10, 2026, Sebastian Chlad wrote:
> lapi: Add io_uring_clone_buffers and RDS_CMSG_ZCOPY_COOKIE fallbacks

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
