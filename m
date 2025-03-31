Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2588DC3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743427571; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vj4xJgjieeXeljWHAHC2+22XHsrPuct7UcYyrpaGo/A=;
 b=dJfUZhmWXjbm6SKav55XZ6hS66BbePkBPlsuywBF2/1swlsRByMoVQxjobbMiyzzX/fgX
 rpYdFWPLTAchjZ0vfnf66uZxaVCiTNj7KV+I2a4RwVYmSMW465AmRxESpaGhGupkI6YHTKm
 F2AkSUN1r2vtJvhwNjiQmQ9r6VzJ/Q0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AA2B3CA6C2
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 15:26:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 030AF3C024C
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 15:25:46 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF406140025F
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 15:25:45 +0200 (CEST)
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso28709985e9.2
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743427545; x=1744032345; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gpyz4v6LSZjj5bHSPxbXtzezR1vg1RYAAgnU9MXDL6k=;
 b=ADgkN3hRjaGOR9T/nAWJnRzNKCIUti4/aRS+vsl7NOmIFrqEZiMSfEY70ztdFMypcc
 3ywXeEIx6Gg3MqTsTB1vSdSeYpHH9bXgEGtoGK3IT0iSMOA4tzvzWuSLrf9wgsCUf/HH
 KePB7RXoa/Josik5DkMuDq5obbwcwfaWylY02Ob03iUD2OIPDCmRoB6/f9cQ8+KGy+cR
 h395OJCkO4TaN864th/tpUEfDKt9NziHexH7kRQsIRjJTY96E8Kt3s5kVtb2pJhAOEaS
 yC1Itf9gesGMkva/QucqpV2ov8VMDEdO30F3ZVQ+YcNFzOXDBG/HnxwaPzjoIdYhT2pm
 eNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743427545; x=1744032345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gpyz4v6LSZjj5bHSPxbXtzezR1vg1RYAAgnU9MXDL6k=;
 b=usuiuVfuvLs6zwl+rUN0d9mz2xqeBwbb/+0d5vjKoH8z7bMS0rVS1xJP5UIQX1Zias
 qdDEOzYah2BukYQehTfUZnAgU3pAQ/ufA3yXqCveDQtImKSAUJRUqdunWScjmtcYwx/G
 4/TUtA6C4osY5DoMUbH0q/TXocySDeAQxGuQEqufpuB410tackO04iqNsh+27jJobbDl
 UURzCO8/gRSPzzW/Bq7nfsSm0g/3qORogIqyJTzNBPec6P4e1B8Ewjujk0at080Hhrs6
 EExUt1HxaOTkYLztxBqFAdByxoAUF6NI3m8Ag0gFnZPFaLgoDlq92SLYzHvMCpKfEEHb
 Jo6Q==
X-Gm-Message-State: AOJu0YxRyHc45T0LfsDPAJAyF2Tjiwp0m12cyAi0AJdPEHnCqCOSfY05
 VWujjsDtjM8n2yc40caJylNuBXHgdRJmSqzEUK919sX2x5Y3R1O3xGRfHJuqAe1+LLWUSYVXf2H
 ROr0pBYE=
X-Gm-Gg: ASbGncvmwtWXDqGk+ViOaH8dNUyUqGUVgbQpNM54uqfTJ+P0y2ozntyyuILsUu1R/Z0
 93jUQ+JakJFGtPCi6XvbqrqtfFWpqAouL3MwSjN3Wa0zoBw2lNdOvyMQlaRGrd4S4GIgwLONnNU
 6txOVwK06dxpPsYj2JqU9v0ay1sdjx1QdqzWnk4lYidgmNHWF2lvsPzpaAxswFmtlzZ7rwY8FqG
 nUixa+ed1rmuoIEwylXrughFqShat1KkM6Wlw/Z1lsrzc394TYlKSsZ+F+gv40nGE6PCpNLMXTu
 m34wkQX3x3hXDqbPxEvmWxyi7YEkgQXTLg==
X-Google-Smtp-Source: AGHT+IFEeP0mBzzPhbWVGtK8TcAvf9F0ntQg2j69JZd1au55iv2DOUTjBOa6+JDygvhVQto23YwDMg==
X-Received: by 2002:a5d:5f42:0:b0:391:2889:4ea4 with SMTP id
 ffacd0b85a97d-39c120ca29cmr7811986f8f.9.1743427545097; 
 Mon, 31 Mar 2025 06:25:45 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658803sm11087522f8f.6.2025.03.31.06.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:25:44 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Mar 2025 09:25:35 -0400
Message-Id: <20250331132537.26417-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250331031945.5948-1-wegao@suse.com>
References: <20250331031945.5948-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 0/2] cpuset02: Convert the test6 from
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

Changes v9-v10:
* Remove debug line
* Remove whole test6(), renumber tests and set TST_TOTAL=17

link to v9:
https://patchwork.ozlabs.org/project/ltp/cover/20250331031945.5948-1-wegao@suse.com/

Wei Gao (2):
  cpuset02: Convert the test6 from cpuset_memory_testset.sh to C code
  cpuset_memory_testset.sh: Remove test6

 runtest/mm                                    |   1 +
 .../cpuset_memory_testset.sh                  |  63 ++------
 testcases/kernel/mem/.gitignore               |   1 +
 testcases/kernel/mem/cpuset/Makefile          |   5 +
 testcases/kernel/mem/cpuset/cpuset02.c        | 139 ++++++++++++++++++
 5 files changed, 158 insertions(+), 51 deletions(-)
 create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
