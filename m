Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC65DC36010
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 08:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743148829; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=s8sSKjkto3PWOEpCf4s7hYJ5H0tmvYrtCL6SWHxpbRk=;
 b=ZioJqLU76CcvraFHctWjaAXP7opJV1OI6eQfLhYDdLJN5Do2ev4pUMr7977hXRL8jynee
 qNRJ03xsJPPnmJYFbkNtHL1W0kUMRbjOMTZKb1gt2jY5cwl/o5j57d4ClsBdO3nnZIm7I5j
 8EQzNABv1/tmLQDhRBkZLMMpc+ptrg4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8FD03CA1B9
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:00:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B80C93C25CC
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:00:06 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7303B60FACC
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:00:05 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so13001185e9.1
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743148804; x=1743753604; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxsH4f6mISCZXukp5fDaZA/w9JtqyucPfyF1e76/ZZk=;
 b=B5gUoErehyNbhL0jqpCEgspkURn6rFUiXGaKjZDb4zsiV3Ej6mKbzqkFowEdvmv0BP
 bzZOYypYqpxlGIXl9X8PfH6Niah4l5x/PGRc8ZaKhQ2TW3Aw/DDhPSc/C58MXsRAh3ec
 UdvRBTQFDfgBF27VzQO0iwetMks0EGNWCm/DQsGnaySJ6KC5VL0HPOkJevyaAeJT4irG
 mkh0RrcktpEqtnp7k585lEYGC1/Y+bg7Xd41ag03XQG3MjBSv1X3LHHao95x25umFEme
 F22ozkK2/34HX1PNQYLU5VEGxM2Nhb9Ge2dwX5aGIlS5PkmCh9/w/We9zLH+Slozp6U2
 ezwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743148804; x=1743753604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxsH4f6mISCZXukp5fDaZA/w9JtqyucPfyF1e76/ZZk=;
 b=ZPn53V6UKk+OVVpZaL8oVuhevSvJqR9lQ8h3+k9FqM5wJ4Ni0muRG9uhofUWJhsXjl
 LXENYOJWAIvicEqHDTgLVpNAg9vjwKXc1t48flzWVGZzt1/j3a0H+vX+x0h844RcmFni
 v4sXHfQxpj9J+T45ZMwi1cexnWcWyrYuGwOgKX4sub00VMDfTKCmzeJlsZ0+Qt6qvFXY
 tDEwIQD3nbQoRVHu9u+hVhGMip0j9NbCpIhw0x79O/vhow65SwQAj6Mr07t2UBqsFfLK
 LQHbsrTUKRB0Ja1iWWaS599DxxUmF/BunNuNbfKmcibaxLskbJCXxnNiWCgrtOk7Es8+
 TI7g==
X-Gm-Message-State: AOJu0Yw9MWBtNIIjdCgSm64sDH0ZidIcwYmxgWEkLwqhOD1rpqwAfA02
 ARSRk6Tf5F1xfsO2i/QKym1pIMsXs82199SeXMvh0T5/eFnLB7/SumhZiw/5EE69l4jQxK3EyOd
 N90Hr
X-Gm-Gg: ASbGncvcUZv4bG8/iuxG4kRv/+KqQuhBMwOaGPum3nk/lime+5B1BfvOj9W3ODR5p4a
 BTxkXD0i2zytw8Jvex4VsKht9AYf7JM2M/tTeCm6sh52yy1CVbYIhVjeDw8g5vHpJLmjEuV45FS
 wI+v8A/E1AVGpKS47hhGhD+YBczfDgVx83Udthrew7/aNatJl1KRlep7FbmBc3Wp+VoXv4lETeG
 c5n0XKbwHhiehaLbbL89vZWyBOQKK9fzf6Ijkk+Bs2GWjx3abIRFXdj+D3hcJ0igIB2zuFJ2jx3
 WK7V3u41/QFya91FxgzhI1JnieJjIwYDbiAIYPMQnNS4
X-Google-Smtp-Source: AGHT+IEuu7XEZ5D6/85lb/x7pvB6hXovuFBqGjXS4T9ivHg/6S90kCDMaXqo2GbYxIRQrpAOVs5SIA==
X-Received: by 2002:a7b:c30e:0:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43d8509bec1mr44987335e9.29.1743148804214; 
 Fri, 28 Mar 2025 01:00:04 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e6ac9bsm61290225e9.12.2025.03.28.01.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:00:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 03:59:56 -0400
Message-Id: <20250328075958.7616-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250324120049.29270-1-wegao@suse.com>
References: <20250324120049.29270-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/2] cpuset02: Convert the test6 from
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

Changes v7-v8:
* Update Petr's comments on v7
* Reserve at least 1 page on each node base Li Wang's suggestion
* Change check_node_id from node->map[0] to node->map[node->cnt - 1]

link to v7:
https://patchwork.ozlabs.org/project/ltp/patch/20250324120049.29270-2-wegao@suse.com/

Wei Gao (2):
  cpuset02: Convert the test6 from cpuset_memory_testset.sh to C code
  cpuset_memory_testset.sh: Remove test6

 lib/tst_cgroup.c                              |   1 +
 runtest/mm                                    |   1 +
 .../cpuset_memory_testset.sh                  |  37 +----
 testcases/kernel/mem/.gitignore               |   1 +
 testcases/kernel/mem/cpuset/Makefile          |   5 +
 testcases/kernel/mem/cpuset/cpuset02.c        | 138 ++++++++++++++++++
 6 files changed, 148 insertions(+), 35 deletions(-)
 create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c


-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
