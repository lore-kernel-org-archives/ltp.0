Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1526C36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 12:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742817677; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ZKkG56v9ZtikZniwNEDFTrn9vl9VGuQCJDDbbMItVII=;
 b=pzvxI9Dqm6VawnIF+ls/ArrmP7flSvY8agEJa2XCJGCvOj8Q4phS5NCOBhLWTFRnE+g9Q
 nSaqpRyXtvIsnSy2tdRYA9TmzA1n/0UrwwDRn2Z02zRyvjEM8L9UNFXY1bNKYhXC+G7AI8M
 nOeQ/2bYT9wJGloz9go/dIgj0nocqmE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 333153C919F
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 13:01:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEF173C6F9F
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 13:00:54 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D03D720116D
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 13:00:53 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3f4so2735563f8f.2
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742817653; x=1743422453; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDKeQBCwbEnJPK2DAbzKcOyajnnYDncjkojbCYJBwUQ=;
 b=HTI7RZuiBFprvcNWXFR+XFErqPPhMMBzCbJeus7DOForfJmkGHfEifeoMqBMaOLevB
 if3LMVgSuorHkzb/myY6fr2gL1R5Xhk3h5/gbAVZklxvDWbOBfQRt06Vgyyzd4AngMhw
 ogljv3IbIZPVyWCPEN/RSiUHhczNMk+Bys8gwwdm9JTGbE9sn8N+hAmZEReoyyygXHae
 +Q/lOdJuaSqcWb0O3kF6JU/R53jL10NMfZdl30sbcgwZe8lFEhi57UFTL5kwI3kxnvkR
 ZRT+enyuS5rbR5/6wbZn67L3IjwIBB6GdJKfZwQudn5UYA6tIDna/Bc0rJ+3E4Ro7u0v
 sDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742817653; x=1743422453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDKeQBCwbEnJPK2DAbzKcOyajnnYDncjkojbCYJBwUQ=;
 b=NBGYGEQJWj89IgXIf7jE1AnnCjwmzk0Vzk5blJ3Jz7T1KAts+3SuX9G5SMODrZ3MVM
 H42q8IADukQZGL2UbVMgh+ccQlzQBUQTSeVyfnY1ZLoC5O8PLzgz+fuaebVzIOWeltNj
 3stnirsvLD8RKH5VSORJYpn/oKMN/fO4zXsTwcqSXmQEgeCtyr67A+u7TdM/ToFf423Q
 oBQIos0UAvlm0J0jyvMLI438DlNoiiR1NW0tLv+DSZTOKrs4FAQsimZTg8P72NTGeR+z
 EMm58bd4cG8pOyMskLRwN5fF6eoj5pb2Gwp7+dS7AfYH+d0g64Mcgn/Qh0tnbqE9V9F5
 AkAw==
X-Gm-Message-State: AOJu0YwceEbCX1qfbwL5znoaWJpHAWorCT4V0lAECugzGX7sdldka4AJ
 kT35VsF8p9voVw+7vnvGvlFoTnuerrINhMTp3ap3MQgo/Es5XhaOqNQVggQPuTEFyj2uFGhtu1N
 WXBRe
X-Gm-Gg: ASbGncvm/q+hPKCchPFlp9jrgGM5GSCJJk6qpwA2DHDG7QjlZsxnMC48B1koDUPEoeV
 W8OcnacHpPaIpg+Td8gk3KD/BbZtxINCzlQ26N1KBh+ubwZ0eaf1VGS6gOR45xGO7TOfxq+jAjg
 xW6AGzMsnqlyhy+XDI0J+9WT/+gV5koGZWLXnZNa6XkWy4snCEfB92/3tdVHc5ATu0mIRKS1nIL
 moJdvFBLq6Ml6tu/GqNGy7kQEbZ4B5DSfkRZ47DrSNv4wS5/NKXDON8TYI1mvrIk29iamm1oHBx
 O2JFKmLxyXt7RdYr2ADBx//fd4UKXm2OQb6LbVIOa1ba
X-Google-Smtp-Source: AGHT+IFN9El0PBbWKPg5ySrUOnD/TRNNDW7o9zaiDZBGcMYCslt7WvtrnKpV0ztVCJyCmecy3s7ClQ==
X-Received: by 2002:a5d:59ab:0:b0:391:43cb:43e6 with SMTP id
 ffacd0b85a97d-3997f937c30mr11484227f8f.51.1742817652915; 
 Mon, 24 Mar 2025 05:00:52 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fab1c6sm7749162b3a.33.2025.03.24.05.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 05:00:52 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 24 Mar 2025 08:00:47 -0400
Message-Id: <20250324120049.29270-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250305050805.7905-1-wegao@suse.com>
References: <20250305050805.7905-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/2] cpuset02: Convert the test6 from
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
 testcases/kernel/mem/cpuset/cpuset02.c        | 132 ++++++++++++++++++
 6 files changed, 142 insertions(+), 35 deletions(-)
 create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
