Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8ADC48BF6
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708499879; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mCDDaS/Rn2tVhszZR9cjIbQvGxepH0s5iOu31Bc0p+w=;
 b=k54snTv0PxSjNqcrL1gGQWQ9W3suhx7vR+3ch0IVOTE2tTVt+EwxYo2NWu5B3JnOMYAbe
 dMaYNLGYnTXrAggjp9LAQiZQ0uQ808tVWVtqpy6BRn4i6buq0CNnrgOh6oYv0sReQIEt9Vn
 Y56mjmPfvGnUPsmiWsCNTVVmZC/o5eU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83B643D0146
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 08:17:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 280193CF1AF
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 08:17:05 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6DE07605633
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 08:17:05 +0100 (CET)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d109e82bd0so83542851fa.3
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 23:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708499824; x=1709104624; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNjFvnNZmu8Cuts904meCp6Eq6patYscqnsxYYoid9g=;
 b=EckL0UI8ne0RBBQ5udwbbjdpg7pa+yp1/2ZHUjOkGlBbWswqLETm/5z7u4c0ahbvhW
 AEiK4naSB4EgYtn6h3Cr1NM/xMOH5PdmggPjbXSvt5MeVlDgZiMzYgGlxzD0hhxAncVA
 8AEpqziOVbqZ6ruogDPyi2yoVmDtl3fS5YjcAlD+VIUB8Mw2BCmRtJi9pXqnJ/hPXnlQ
 UvZrN3i/QCR4273LOcpOgwe8ounvvE9u6ej4cfBOWVG8DWp9wfeWc6pnVydMneH78BJ2
 5RtZVnwrjc26j6V6O+9C9xbJ8J6960aUqhIgHdZKUVem/CD++cIsOspzzQ3dzSFbkB5s
 eAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708499824; x=1709104624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNjFvnNZmu8Cuts904meCp6Eq6patYscqnsxYYoid9g=;
 b=DZiB/VI1/VZLzcR9Lzv6Akrr5s6bmVYsy+Nd5LjWbIARB0V32ySc9hetugR+3nv7JX
 TEsfMqA2ph2VWYqJStSvdeSz8Ajv/a5d2VF0UEgdd3ERYkrVgWqWUZgckEV3b/oJD631
 YuEFc2HYtuRdQ/XmANYySmd0Mnac+wqqnBi1CgqNXvNJ1di/4fTDNgIyJYjfgKKUrhX/
 kUwMuCEWVZZZxFayUtiYzWmaNf3b2YDEgvWTx5yVhc4/VJlgUjE5lx8BBY5dPwUF7ShY
 gk4aUFQOfZ8sCzNpHw+qZ2UR3+5BSowjm6jr5Fb3s02U9jn5CIBiK5IEFPNp7hv48Ok7
 hk/w==
X-Gm-Message-State: AOJu0YxQyjofPDfH70ts+3z+y4KcA+aspK/TPHupoNyGuydX1S4kJbBP
 siGuaC6LgSw0OYcbYdk4dBBbzBrUKlub1TlX+F0d68suAOrY1GB1sQI3Q2J9I+Br8f/ukjaOavw
 =
X-Google-Smtp-Source: AGHT+IEPCuxlX8QUCtxvn4ylWueVE5AUPKg8EMaSHJ9q13iuUi4dsm/5u8VMyNXo8ZXQzMDjZPILTg==
X-Received: by 2002:a2e:9192:0:b0:2d2:50ba:e5b6 with SMTP id
 f18-20020a2e9192000000b002d250bae5b6mr1483744ljg.10.1708499824127; 
 Tue, 20 Feb 2024 23:17:04 -0800 (PST)
Received: from localhost ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 f12-20020a056a0022cc00b006e478f9504csm2997157pfj.104.2024.02.20.23.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 23:17:03 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 21 Feb 2024 02:16:35 -0500
Message-Id: <20240221071635.17239-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240221071635.17239-1-wegao@suse.com>
References: <20240219134845.22171-1-wegao@suse.com>
 <20240221071635.17239-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] statx07.c: set umask to 0022
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

When system's default umask is 0077, this will trigger issues.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/statx/statx07.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 4dbf83e18..1ad02fb3e 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -116,6 +116,8 @@ static void setup(void)
 	int ret;
 	char server_path[BUFF_SIZE];
 
+	umask(0022);
+
 	cwd = tst_get_tmpdir();
 
 	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
