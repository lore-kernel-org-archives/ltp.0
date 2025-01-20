Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA7CC02185
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 04:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737346504; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=3pJYJUeLlpv9LNefBZEyH/SbABpOAbrE4akOMStb+Uw=;
 b=PbWO3lovNBjUCN7bwr7BSAvjxQCCf9Df4WgjuLilkVYj6gUDg9+XdWlBZSDsbw8xkc5F3
 yg2I0J4qg5W4Iq2TOy6j/e+WRKoaMgW/ofA+tlaIl6YOUpTiyFOIYZZaUYyQVjHG7P780u+
 B5i+RZw+sRiDE/+gOg9/l1sPmh42W/A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B43E3C176A
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 05:15:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB35A3C0325
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 05:14:42 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8CFF4653732
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 05:14:41 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso24920495e9.1
 for <ltp@lists.linux.it>; Sun, 19 Jan 2025 20:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737346481; x=1737951281; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVOeTh94FHgU+qd8j0+dFVCfDWyY56Rx7pGf15ZC4KM=;
 b=AULFeC3B67k2e7UgY8ZjT4JjqfbO2KELxxasnfAxMhVfOZcfZ9vxcwWG2pOTjAOMC9
 kMpfQZcj93Z9aVUYK7aW2AJhCSLd35rmevMGDnJqJhHF8ZOlh+nutLz0emK5hwS4hj9W
 5eIP33CF9V5ihE32hDf4odJYzApzeI8qbJ8nrVA2xGtrza+EeUIcTn4aHAaq7YnXdfwA
 U323rzIv0ZjOL+ChONgXzV+LlRZJiahjEz2fqtSqjqPf3ZaWxmWMH7B08sm5vQOGjMcP
 2ECIELF+I0gEm+dzFPGwrMU1BAAy5/tiKmiPqU8LPT2OGH6eIgTSeVw8cURfv+D+zekg
 +khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737346481; x=1737951281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVOeTh94FHgU+qd8j0+dFVCfDWyY56Rx7pGf15ZC4KM=;
 b=ky7GvDRj40Aye5BHoX1mrS1UyN//gwlHFXAQ1rulSMJCIs6SsqHSYQY9nSxEKXlJA2
 6WGj1T8MnP7xunxDlDF4aQiU0ETCbM/JA5++fThRHPIBYT2J9yGLzcqdiC8r1hA54DQJ
 16hyoexNppOjW5na+wejujmdLnZilKDhuhyyzK0x6WLgAhkAXbKl6FySrwulDpf7qQJI
 Mqbu6YblapbKA2Y46x6WPQIoJ52bCcqF6Sq63HxDnkyjSLx6xGbCDcpBAg1RNO2ZVzOn
 Mo8aW3ltmHzrjguvaOJNFCXrc8kRsDDNSqe7VlNmL4AU2WkJrSRTMSlEpV+xhwBBmcdL
 A98g==
X-Gm-Message-State: AOJu0Yxr+SRuyhJ1s7AkiKhG4MvfrhiA6AudrCizNXHgeSWNfale7S0q
 tNLjYysgdwfE2X8WTWgKkv3aK3+AG8ZW9Uu917QO4yv7nTyOn58lRpGqfB/+MFD9UfImTeDyjlA
 =
X-Gm-Gg: ASbGncvl3djdWwc/nUKMzcuhUOJDJMp6t/yYlwdtUBHCXbDn+imUnWWfuDL49A6Onle
 zUedbR0Yn73GEsgPKy40BHKv+y/8uQdxiXdA3ziQGoTCAA5wEa5zyVbL6hNexTUzX9kj73nsEa8
 Lv00zv+FZf4qnCaLeSV/4F97QfAO7DpQl2QqrhcXUKiJzvDO4tsmiwiekjYBeXb7Q3sMoCAM/0l
 S7iUiS2mc+McuGKmtn6GaQ3SltBtYdgChqHhRZIzQtVK7Pjt57xnpEHryM=
X-Google-Smtp-Source: AGHT+IEbpodw0Rcjre+AXeajw0nMW5aGBanmgTFvA3lVWe9xWr95vAQXhONDz0YIn7nLC+YOODTvGg==
X-Received: by 2002:a05:600c:8712:b0:436:1b0b:2633 with SMTP id
 5b1f17b1804b1-438918d9008mr101701965e9.9.1737346480832; 
 Sun, 19 Jan 2025 20:14:40 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753bee8sm183985315e9.34.2025.01.19.20.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 20:14:40 -0800 (PST)
To: ltp@lists.linux.it
Date: Sun, 19 Jan 2025 23:14:31 -0500
Message-Id: <20250120041433.22399-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250114143217.21018-1-wegao@suse.com>
References: <20250114143217.21018-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/2] ptrace: Refactor
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
  ptrace06: Refactor the test using new LTP API
  ptrace06_child.c: Remove unused ptrace06_child.c

 testcases/kernel/syscalls/ptrace/ptrace06.c | 323 +++++++++++---------
 1 file changed, 172 insertions(+), 151 deletions(-)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
