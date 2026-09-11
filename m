Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CADBC88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 12:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789130108; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Dsf1eFIHZpyDqb5SFxhmys6eP6Ch4IDmHWr5ejRA0mg=;
 b=jg4VLxykQaEMMmDasoaFCBM/tpEmKGQKw5iCKoVLnWp5bg3lGALBh2wJAVgb7454RHjLF
 qrJ0JUQQ8uXJMVYf65jSgCIOziUJcL2b5KAC0Sql7YpSgqketMpt6Tnt9L2xzRlpDOtesUk
 h1CMvhTwzRnoYXhvB+w1+PhHlGqmWgY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 727AF3E9210
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 14:35:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 492EE3E2E82
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:34:47 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C72D1400E00
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:34:46 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49e668491f3so2306305e9.1
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789130086; x=1789734886; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hcussDjy8aDZT2VDYiixpgG8YausUO4Uu+h6NjpIfpA=;
 b=Mhg+/639UFR4TU7Xf2GWXvxAo+jIELfGBIoiVZEqx2DZFL/Y0JCuZ8lsgUayYkswWf
 HAeDuSyJ08FmpGXIYq1llpaO7SH7kUBxO503FwxeiNg9t38mT+4B9oiS0IbxlkjNRARl
 esXu5zO5WkKVajYDJQXOsOMjI5/4HhtmWq+8vmkOADJDywLdG8MUgK7QmVb4/dL7SMfj
 fcx7qxd6hZ7yxWc3TfPH33/zVTLEV9JNtKi6Pb5dFGM6Lv7mqeJuGqgosG+dz+XQQv4P
 4cGoQgKX+3ALC35tbnKWGSiodYz736lFbRV0p8SspUyZnKWYP7+pg3Pj8ohcMwksTtP3
 fgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789130086; x=1789734886;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hcussDjy8aDZT2VDYiixpgG8YausUO4Uu+h6NjpIfpA=;
 b=MRhoKgcIfkJ1IO7/QglpR76JcBc4tk9o2FQfAH6ywA36qc7PG3adAatm6QfQzMZh5y
 +sif/SoafZ308i9MfwC9ZZrEtU9aAIZYd326S2dzeGMCfMWEZ01Bth1R9Pwd4bdnkfZc
 ytzRPHdshzPy8dj9N/hiPzLzOyjkw+2sjuG6ZmQJM0RdvrgMycWYljbancFmQhS2n5zj
 fuqQf6yPQv1P91Qh18FfUHCKb1EPWezpqP3aW9/UstVeHM3wt6mgWH6XIgvJ1mY0Fjzo
 lbetR2xjbrlc0sZCB3Yc4ZBH3Oj62gGVWJvQ2bFIaCI+605yVY3ufsJtx67kKGiB9Kbl
 +CrA==
X-Gm-Message-State: AFuF++lPm29rMoHtBL8VUp8yoCrxCjSjTKdQ1a34ocvOUJzzqukXein3
 nWKC8/IJnrOjT+5b/0ztWwH9zjlJZLAteEgc6htBwpEgmtfAlQzOz2J63CXqB/sBX0g=
X-Gm-Gg: AYBFou1ApNOwTCpdgq2xh1uQgoEdVXnKN0ICXBYBTmRJfjV3TZlNvu16ZWn78S1FSXK
 31BWuf29gXMhSFuLbQuzM8NMkELD1rWfkz+ArCAgL1hdeuFJDIYMYC2lWKZvGHGeOt5VKTKRttZ
 zYWgDVvd8c28L2YKlYLIDHNqlGRifzeUftKsgwjRQMKv4AFzWezkHt3u7ouB6mOJak+xpKPMt2r
 BwaPVo7sMUw2ZzCIqhXtuWugjBKPHds4Mblkx6BAtR3JF6L0n3MiyRzdzdWNpcPZjsWyvHEshQq
 OEu822mbrzsmqRqmGt5lJArMj4q3h3Fb8NqEPaKlRjDykXzV/n+hPesnER82UON36ANY6IEuMVN
 kRZ/DJ/GA7BZSUIQBgN6tK6crEgMTBYOH804XCqynBCk9pLwxxEEBkmL2HV+IST8QH4Uzs6smV2
 XJs0c3hWprDjTzHlGUAs8wjKR90a7XjqqnK/PrIf3qlSiEgZxj2n2YyYdY6C8xaq4eDFcNW6fxk
 ZhxYEC3/cjPaNDdTxxRzixgcLht9eYpttwPRt/D3cYgbpT52itc3UsTwHaDUfqNP/UuuBJ6aYl+
 vl3jJQ==
X-Received: by 2002:a05:600c:64c6:b0:49c:fc6e:a3e1 with SMTP id
 5b1f17b1804b1-49e619e7235mr43420095e9.32.1789130085833; 
 Fri, 11 Sep 2026 05:34:45 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e81asm5873436f8f.7.2026.09.11.05.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 05:34:45 -0700 (PDT)
Message-ID: <6aa3f565.a02854e2.1a0266.ebe8@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
Date: Fri, 11 Sep 2026 12:34:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/9] doc: Improve and fix documentation and API
 comments
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

thanks for the review. If it's ok, since updating documentation is not
a blocking thing for the release, I would fix the whole patch-set with
the requested fix and merge it.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
