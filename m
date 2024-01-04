Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CD1C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:17:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 296E23CE6F5
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:17:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACFE33CE6EE
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:17:05 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B5CC41000A12
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:17:04 +0100 (CET)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-556aa7fe765so1086117a12.2
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403024; x=1705007824; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xV0IsQCR6IYK9BKLjVm2XuDuzrv47w90vWA7LYPVdk=;
 b=RAkH8ZaYTeuKEDTQHUfUerLw53MfxOoRNmqFLQ3wGhzxNsLQwiLADktE608sihLk1p
 WKua8QdqJP2JRprxUNKdbDxgS2nrHM1rK1cYeuLL4NUDX/qfaTv2GNVltFjNQ/gY2cyF
 DfN34c/fK+glpY84QjbpCKsIwhY2Xz4EwgdifyjusLfmpdjKJJ4iz+y4L+MRW514EqyO
 1aUv/VGQ9SJ0JEJqBwncg4GrxaIwTgLahj0WJtepzA38jxsrFzvHBG8Dpk/cLke0rad/
 BJgHvJN6t9DtVdakMKmdl0WcoUoAm/OCn2kUxrcyoCtGiwwTNexJMP2W3HygfNKt8E0B
 a20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403024; x=1705007824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xV0IsQCR6IYK9BKLjVm2XuDuzrv47w90vWA7LYPVdk=;
 b=actvQLMk8X5NyuNduwbb9kSnQoiLUk9lw4cWkgCR4fCiYDS2/aCQKoAtktuipHVvf/
 wRvekm89O4pZLIzMB1adoTRLBpn1BoSGoEtEtqrKSrn8zuCb6Rkg8kCZhsVrOygFz4y7
 7Y29kvMxjDge0y0lHAIDSf9OwI0BJDAUE5RP9YCynee5NS3qPQ4dl21V8Fg1AJmX/HSQ
 PRoyWH/MBXVYAUb5xeUXQIF8JbMZtRbcTiz3bBk2Fji4hGOEy8AugoRT/q5sLcecFh97
 BxrqpywaGqIp9EFsrRELvq+7dX/s8cGKPor9FtPruGw1uovXZhODXzd5/aom4QA+d+na
 B56Q==
X-Gm-Message-State: AOJu0YyCDlkVtclGWxUR0QXlH4QndN4NLw2JKIGjGF4zPZyREAHPwMAM
 zphjRJqLLyHYju/bCcSsuT10fjY5w6txeA==
X-Google-Smtp-Source: AGHT+IFWcvoh2ZUCD2pw9Z6rtfe40Sz0P8xhvef4pcCgZaOeLnuFqp1HXjbLQdN+LjvHP1+lbqYs6A==
X-Received: by 2002:a50:d509:0:b0:554:372d:313 with SMTP id
 u9-20020a50d509000000b00554372d0313mr580586edi.81.1704403024056; 
 Thu, 04 Jan 2024 13:17:04 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 b23-20020aa7c6d7000000b00555a0fa2211sm150375eds.31.2024.01.04.13.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:17:03 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 22:16:48 +0100
Message-ID: <20240104211654.1437671-4-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104211654.1437671-1-petr.vorel@gmail.com>
References: <20240104211654.1437671-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/9] metadata: parse.sh: Pass -v to metaparse on
 VERBOSE=1
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
 metadata/parse.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/metadata/parse.sh b/metadata/parse.sh
index 9dd097153..83a3683b5 100755
--- a/metadata/parse.sh
+++ b/metadata/parse.sh
@@ -36,8 +36,10 @@ else
 	tests=$(find testcases/ -name '*.c' | sort)
 fi
 
+[ "$VERBOSE" ] && v="-v"
+
 for test in $tests; do
-	a=$($top_builddir/metadata/metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
+	a=$($top_builddir/metadata/metaparse $v -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
 	if [ -n "$a" ]; then
 		if [ -z "$first" ]; then
 			echo ','
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
