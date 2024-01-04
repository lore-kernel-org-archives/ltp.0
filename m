Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BB1C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:17:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECBF13CE6FF
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:17:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF2F33CD1AB
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:17:04 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0AB981000A11
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:17:04 +0100 (CET)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ccbded5aa4so11839471fa.1
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403023; x=1705007823; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDDn+cKlW6YUknawoTOZmSBhPAug/YYoepGhvxdJhdg=;
 b=G42hRyAhDy/fkZvzi+cmPsK13S/iRKYRgNCVNVxQNosPzrqVD0Rp+A7fPt4i5Y2k7Z
 dmd20Ad6g/9zkg6l/752jwoNPtVZ5Jfo7uEHBLYU3NvTTDwHNvN/3ylZ+OcWXvF9aHF7
 erUrmoJB7jeCmaSWMV0QnQe2/IricHj3I8Mq+yNYk0duQiXySL6+4o80tfHsXg1WIiKs
 3TD8Z+LIqefN+fujsS1LyH4GUParZ+QG+9HItp80J9rkY6oKbeKBzAfYyaUAzewHm9nY
 4Jvh28f7ank36LcKEVGgenuHTFyzX5EcG3GLScvyKhu9pKnfoWo4ijcA1NUw7GqQ0J/E
 mCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403023; x=1705007823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDDn+cKlW6YUknawoTOZmSBhPAug/YYoepGhvxdJhdg=;
 b=PfiJl8TfFj/N4zsVvUDI59158Vo1ZGrLvNm8qXJIk8bDmsOpQJbLzwb6hYCSYEWqnH
 BpMPEnpVi+uBvNrZEQNfv8dUoiys581W2stZEu36aGkPBYDIoM/z/nGXxUTFcEzqWzWb
 kjo47iRLyg17WsZF8JtxbM66OE90VDiGgScXlQuC+HcwRtebsyDI4YMERWIQixe+HZOk
 YhNTxAPSWupdAj0w4QY2AjNVoPminwM8iEo+sdWb97PBwJTeO3HqZ01ZmbyZ/6+ATbDd
 SOe04QkqwBXxcaVIqJmbhumEnZFD7wImbv+FRxD4WMyWdV3ixIschk7eHS8h2MIhXJwZ
 yFUA==
X-Gm-Message-State: AOJu0YziKrYI6EOCoCcXDujBcXwZn3TV1+Z1eCK7NTz0t9cRKXtNSAol
 KHlAiOZmIHAUZ6X5ztNZVCjg3UqUXKzrNw==
X-Google-Smtp-Source: AGHT+IHpaZ8n3RBl3HB4PMhD2DT/BoTyj9VitDlkLkQ9ST41bIpbpkCw5GvmZkv5YO49oqrwB9Wwug==
X-Received: by 2002:a2e:99ca:0:b0:2cc:3f83:e3ef with SMTP id
 l10-20020a2e99ca000000b002cc3f83e3efmr665335ljj.12.1704403023169; 
 Thu, 04 Jan 2024 13:17:03 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 b23-20020aa7c6d7000000b00555a0fa2211sm150375eds.31.2024.01.04.13.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:17:02 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 22:16:47 +0100
Message-ID: <20240104211654.1437671-3-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104211654.1437671-1-petr.vorel@gmail.com>
References: <20240104211654.1437671-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/9] metadata: parse.sh: Allow to pass list of files
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Petr Vorel <pvorel@suse.cz>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 metadata/parse.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/metadata/parse.sh b/metadata/parse.sh
index 69bf5db65..9dd097153 100755
--- a/metadata/parse.sh
+++ b/metadata/parse.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
 # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) Linux Test Project, 2022-2024
 set -e
 
 top_builddir=$PWD/..
@@ -29,7 +30,13 @@ echo ' "tests": {'
 
 first=1
 
-for test in `find testcases/ -name '*.c'|sort`; do
+if [ $# -gt 0 ]; then
+	tests=$*
+else
+	tests=$(find testcases/ -name '*.c' | sort)
+fi
+
+for test in $tests; do
 	a=$($top_builddir/metadata/metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
 	if [ -n "$a" ]; then
 		if [ -z "$first" ]; then
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
