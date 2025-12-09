Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13201D3B7EA
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765296123; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=0ildQcgiT5DkOsWDN0jOAy381APWb6yGpV9KFYwsnPg=;
 b=LcEfENAjAHiBpyLSZ/nKC4lhLvDwz801tV3E49BDWSVBBKWFtZ0AWuIXL6dNoEYgmX85d
 dkLw4ZK2Hgbh/BO93dESmc3tGw2fhQj6Q2YBehsSCwqQKSbA92KiEKodLIWElKAKzPFY5Mg
 EgItm6c6Q1cSfTQ5i01LumLYu3sXl94=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A56163D030C
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 17:02:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C1573CF72E
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 16:57:35 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E343B600448
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 16:57:34 +0100 (CET)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 06F773F2BE
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765295853;
 bh=/DAR/fwsFub/c1NabREmktbJ12NBxv+ZrbQ9IcfgWyo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=QoBWto3wjVnBaDrlNZ6jNNxkMyDkodKktRSj1HcSmQbFRjOMogVklucgtedadIZiL
 lHemUGjHNGno54EZWtSPSLjOYjn9aeMRrxaTObg6ySJkVl0WPwIWEAUHbG2V886s0B
 +8yFm+u8pzlc7qQrqq+X7EQ38eX14oB3KeQDA+BUaqR7sNuOxhrlMJiJr3tzy1/TPN
 FcC/phgxURORdoDmDieSOus0sTuimwDJGj8vJM15zkZowDfYf+bLSJCoucyekT5orK
 9AQlT7fDEnTrhyAPxBVeVjygySHI+OxQMDb8fHN0bUakShkrqKBCBh7RaVqFhp1TJy
 s+rg0CIjnVUpeGCwyJk2H9isORV7SNpciVAWoUJTPROy4DMz64ia+2oci7FsFXBbwQ
 h7CFV0wl0kiVI5R1919gV20zhMtO9IdagbLZs2rbQUWi6k92W+5D/F81DMi+sF44GS
 HYzvccxUZmvxTg/pQrKb0AaeFrLDKuL57tPl+upWHbqY4Xq4cKf+PN5K8XaXTl2MNI
 UmzIprPcC5QSPlLlafPUfc/dH2jcP5frIXmckAm2BlYgdWZrC+xruWBiQAoiigC1pB
 dFzlUaMBvHxrZVUVJx16Vc3St8ep0QEGBm+uGFjDYHBl9nor6H8LQY6AYOwEarX6L7
 G1vpc0G6/9BIiv2OudbYjybY=
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b79f8f988faso564352266b.2
 for <ltp@lists.linux.it>; Tue, 09 Dec 2025 07:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765295852; x=1765900652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/DAR/fwsFub/c1NabREmktbJ12NBxv+ZrbQ9IcfgWyo=;
 b=ZJpZld1642vEaROqJfBOY5IXJUJM9g2O6UXdlMpbA5lfQ5Mqat7HyDAmApHZuZW0Q9
 FnrRUfzC7kgtYM2SlOb824aCZBahMurRSOVqZz+sI2Zk7Wh3Y94hhbeju83yP2wm2wdB
 VeSsmCYHpPiow6Olz2q6uLNaHAuA528RL61X+2mhJwDDoTll/G1NbLjRmmcnGvmQWo75
 K8W8o9IwFGmBq3+a+/Janj6iI4Yi6j0di7viTkscX/hRg1zVB78iIZFd/415sVsHNamJ
 aL/wzqGH39ua4b4lAlgoeDu3MsWM5b1uvcp+Uucc4hEezMMyF1XkW/kMfXK60cy372xE
 rAOw==
X-Gm-Message-State: AOJu0YyjnoUqhQ6C6uqP593emmS8NH8JfQrG6OsqSR79Zc0GUyjaRQ6V
 yqlzhztLmZI/rJeH44pRZErakq6xdIjBLhqrn6clsDMq+PItdoO9AB/hzTpJs6SwHFHk7i4TgUI
 6FJPLnlgDiz4da7jJ6oPHN9vX/+ifsEXAftIVAavzD1z/ANOF0bktuPsJTsmcP8hjO+HxRmKtjJ
 Yv
X-Gm-Gg: ASbGncsXyLqMNVvUUgO0B2z4R9TZzrUmPCNGuVpYH01arTvUXlKcdM82FkHxJV6hugh
 WE77rjxr4oQdiz4NIYTyCOQGkyarNJRGYFAqmed082b2Ha2hDgTXDdxQxR7VAUJ+dnFwrJIIz2X
 nbCfpRMY1MR8fzBFQnDnmZhL93c6KR9So/1U0+VwaepptzETwidm6wUPIz0T/Q5PYGuc2kJTryf
 2ljspe24BnJ0AIfbXqIERp9HnqHxXneLZeW7uY/Qs5CTE+qPICpdYw/qSWYbIMC1YjQgU9r3LlC
 XLhIkZoe/09TrXsYkUXZfb8xF4dlFOXgLt7jEcrFVvjv1TIw5kt0xyKo2iJKfee0do04KO5hIVz
 T3ddwdilXQvonrOkoGaWuu/fZZ5E+cJJA6byywFBdIKX4IuIOUTU07hcAmVXAWm956OpwpbgGBQ
 G2hAbppF1wck4=
X-Received: by 2002:a17:907:3d8e:b0:b3d:200a:bd6e with SMTP id
 a640c23a62f3a-b7a2451e911mr1121361366b.47.1765295851868; 
 Tue, 09 Dec 2025 07:57:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEoBcom38icUPX0SznczDAlGsAhOE1ORC5dfkdDQwS4J3GgMGt7JktS+Gxp1ODl8j5Q3fFlg==
X-Received: by 2002:a17:907:3d8e:b0:b3d:200a:bd6e with SMTP id
 a640c23a62f3a-b7a2451e911mr1121359166b.47.1765295851451; 
 Tue, 09 Dec 2025 07:57:31 -0800 (PST)
Received: from localhost (151-243-191-194.pool.dsl-net.ch. [194.191.243.151])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-647b412dd8csm14257880a12.33.2025.12.09.07.57.31
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 07:57:31 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue,  9 Dec 2025 16:57:23 +0100
Message-ID: <20251209155726.519179-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 09 Dec 2025 17:01:25 +0100
Subject: [LTP] [PATCH] mkdir_tests.sh: Handle error message from mkdir from
 rust coreutils
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
From: Juerg Haefliger via ltp <ltp@lists.linux.it>
Reply-To: Juerg Haefliger <juerg.haefliger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

mkdir from rust coreutils doesn't print the directory path. Account for
that.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 testcases/commands/mkdir/mkdir_tests.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/commands/mkdir/mkdir_tests.sh b/testcases/commands/mkdir/mkdir_tests.sh
index c0a570e5c0e6..3bafbfdda7ba 100755
--- a/testcases/commands/mkdir/mkdir_tests.sh
+++ b/testcases/commands/mkdir/mkdir_tests.sh
@@ -34,6 +34,9 @@ test2()
 
 	if grep -q "$LONG_PATH.*No such file or directory" mkdir.out; then
 		tst_res TPASS "Got correct error message"
+	elif grep -q "mkdir: No such file or directory" mkdir.out; then
+		# mkdir from rust coreutils doesn't print the directory path
+		tst_res TPASS "Got correct error message"
 	else
 		tst_res TFAIL "Got wrong error message"
 		cat mkdir.out
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
