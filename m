Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC104C48BF6
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709461899; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=uzUTxtIkA/crnimyvgkBDNaMUCLuXtAXrFay880UMUs=;
 b=Wl7u/TdXritNgMLKMOfCerxjBEzD462dvD7ygvc2wSwZ0OCKOZpIDRMPQSfHd//7mQwLt
 W+GsnHnxEtH59+ljUEpf335rpwsehORMu/zDvrURB2BzY35Q1X00Vw5849E0pZGYpg/6kGR
 IJXTcLtxIhM/cRS6/e2RtEZLbe7mXFc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 163333CE710
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 11:31:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C14F83CD859
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 11:31:14 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2B624140119F
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 11:31:13 +0100 (CET)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a4515f8e13cso35700466b.3
 for <ltp@lists.linux.it>; Sun, 03 Mar 2024 02:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709461872; x=1710066672; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KZIsLk5GHdbJahEov2zlCmkR9Duc7auwgMNlMdUX7PA=;
 b=NEBX9X3fjgi3uBG8WpJgeF5PuAph7UwBRbOqO64cMQzFZbIboGhSVBIVpJ/4uiOCg0
 FxpL4/j6Wx+lBBEmwfzAtTq7fZCMtp1weGbjQ9LuG4azAV4aV29AojAsU7EDehA6Zh0e
 0op5FJ+WE/G1q7fOXBzNyDkdKu+dlHvvBQBIBoRdQ/ZVJzNJ7YM4Tf6VAnGKcC4MWENr
 aOBqE2QbWPEsoABEDgUjrF2KXTYsXYPDMqOQQqQ3jrrzKBaW96p4gkC3jneeI3z+8BDk
 pR7z3IrrZOedC+/P0Ycz9XlpRMDHQPicR/sTPqC75O9OYSvel4GVjlMklaEvPYNf0o7+
 79Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709461872; x=1710066672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KZIsLk5GHdbJahEov2zlCmkR9Duc7auwgMNlMdUX7PA=;
 b=tk4Rl1wzsfKZ49QkXwziALKIKZbI+9dVUNeNYZ28R7kir8jubCZRk+nah6/knDoHlC
 fR0IGMsZ2QmVyptn+yqZX52L+fXaUFO/nJ8g8870iJdpCSt/kMk+vQCAPARTlCOIIZ9r
 cjdPre9lg3BrGb3iWUQR83wZS7OBgHsVKRUDOeplpUCLcoPe12YpRAU8gfqX+8anxROG
 dXvWXbzDhjiXl3aVG7UU9f5G+wTIGW+rTnsZOxcRbzJdqucy79CLFYdCDFHvH4Lchwb7
 OgjmW42M0MJdn2anAQhx6chL+QsyU6trLqJF2jzvWQq0Pg+Q5UOECOpEcACP+JIQ5C/9
 JmYg==
X-Gm-Message-State: AOJu0YxMUlWh+F27lLT6MA4TPWcm545MK8nX8GHYQWzHAnM7T16XFytP
 ZmJBGSewG/kpjhznKmpDBLrPh792/qR0lN+hhBLlJXWd+Wsa6uvTEa5fY1SsgmHdhg/ZfroJ02A
 =
X-Google-Smtp-Source: AGHT+IHW01/pk2EzA0jFGCF24UX4CZue+J63TIex0KJ4IeubcgsH28WLD45Ltz4jO5/VogKTdhk7ZQ==
X-Received: by 2002:a17:906:f950:b0:a44:1cb4:2e85 with SMTP id
 ld16-20020a170906f95000b00a441cb42e85mr4704463ejb.52.1709461871992; 
 Sun, 03 Mar 2024 02:31:11 -0800 (PST)
Received: from localhost ([81.95.8.245]) by smtp.gmail.com with ESMTPSA id
 i8-20020a170906698800b00a43e8e76825sm3601979ejr.149.2024.03.03.02.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 02:31:11 -0800 (PST)
To: ltp@lists.linux.it
Date: Sun,  3 Mar 2024 05:31:05 -0500
Message-Id: <20240303103105.13401-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] statx07.c: set umask to 0 within setup
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

When system's default umask is 0077, this will trigger following issues:
statx07.c:108: TFAIL: statx() with AT_STATX_DONT_SYNC for mode 644 600

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/statx/statx07.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 4dbf83e18..1a568ec9e 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -118,11 +118,15 @@ static void setup(void)
 
 	cwd = tst_get_tmpdir();
 
+	mode_t old_umask = umask(0);
+
 	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);
 	SAFE_MKDIR(CLI_PATH, DEFAULT_MODE);
 	SAFE_CREAT(SERV_FORCE_SYNC, DEFAULT_MODE);
 	SAFE_CREAT(SERV_DONT_SYNC, DEFAULT_MODE);
 
+	umask(old_umask);
+
 	snprintf(server_path, sizeof(server_path), ":%s/%s", cwd, SERV_PATH);
 
 	snprintf(cmd, sizeof(cmd),
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
