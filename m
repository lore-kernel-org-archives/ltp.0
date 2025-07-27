Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06BAC87FCC
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 20:38:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5828B3C73A6
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 22:38:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA9063C0F39
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 07:04:58 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 122B210004BD
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 07:04:58 +0200 (CEST)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b3bad2f99f5so2914442a12.1
 for <ltp@lists.linux.it>; Sat, 26 Jul 2025 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753592696; x=1754197496; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sGHC/IKmsZBEaw4ybOELhghZPARSq+F5hG2wUERKcPI=;
 b=RbrPAjRgWOtROe4jFcFu7GGFVo0mGToBfVDLQmpZsKCLP2qpAm8odFUERkP4dp+yHe
 OYpjrNiicDtruTjSanHZbuY76u6L4ywj7/Y5l1QY2M3ggFIdX0QIDH1CKEYAx9Tm6ct7
 acZFylARF8E+ZmJpce/C0Yd3ZZOrDnDZytdV2+JnKWHWK3rPxtpnCHqE5MSp7WXGuoKa
 5XiK02yVzSMcLL4RJgs3bMuemS3bmCmqWpcgh5OwsKi3mTw56iT/R3znmBOrn5E1X3qV
 j+TZkC1h54yW20XdYacXzLM2pzSR9fQn5V7IAnqsPGNtdle0yb4c1ERy012qnCaRUdrX
 VoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753592696; x=1754197496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sGHC/IKmsZBEaw4ybOELhghZPARSq+F5hG2wUERKcPI=;
 b=wn4EUPo9YN5G/LpTmXXEhrEsOW3ddlEnD+6wa376g3lzfvdwC0wIfwU6FOdSsGc0LA
 kLKEJv+txoPsgYTHLuSvh+qRobwelSjD/fJ6vWRGrLVacY+wahnAG2dxky7Wo5693FG+
 289yz7frB6O7h/kcWpgRIg9NVvPEQwhIiPkFYTr2FENHcpbQrcDJY9hdy/18QftzL3zA
 Rv40Cy72EEznLYGLpA5bt8yrUCnyeQckPlvVwD5uQdHcGmlO/NvDvXRO/eToKC2IP0S7
 fn65gA2qsvK8NCK0vYDOrB2mc6ykguf6C9E3N/ybX5V3fr6h2MzvakBtZ9Sm6XsStgxg
 j9lg==
X-Gm-Message-State: AOJu0YwBejdgq4PiOxlslV0d57s+AUJtOYoAYT8qrCjLmwPKvJGjPHQG
 jaBo1n6UbyjK0m/+tClgDO9Bt6qdF5TIRDX9wEqfjVYYVNFrUO45NTK1Zt7xKnCL
X-Gm-Gg: ASbGncvZ6i7v2aHpOuJRxdx1w16bsE6mF89RUMDoh/Hb28Or/9jnJdHabfc/oWqvWnE
 nZeG+4f+8yWWpTXO0X2QdsSVuM8rNvJDyEDDUfXJAhH2F7n77ZZJ9qJvgmNjo/SZkMQWQOsBT8h
 n2Vz2tsVh+5Q+2+fFCXwq0BLr6v0ocEjqksMKdv/XMW8XnFdC4y+Dl5KlrTNwR+0VB3PgL84LWI
 +F1xLIivHux6J4EPyYjCDvtwFfrIDGFTiXHQjB3Ev1vO8kNxZ5GxBSdfpd21ZRzAyCvk4Vcvdsf
 22dZdD71T+fqJopHU3L8zbF08BxmobyaEEnSWmfepQImOKFX0fkk+cNKrFLX9DtDk4LPK7raHXn
 4TO9yctfvns3APwAjfCDJdyqAVAAxLhidTaJGVl+aAlQGDFkFj7zEC1IKTxq5U1pc
X-Google-Smtp-Source: AGHT+IEYIIrVm1hjvXWP2v1YB9fHqRudojnfC+LwDmpZjDZsGCoydxWlaK6QTB8eQeR33futEVB00A==
X-Received: by 2002:a05:6a20:3d8b:b0:234:4f73:e657 with SMTP id
 adf61e73a8af0-23d5b3e126emr19671201637.0.1753592695753; 
 Sat, 26 Jul 2025 22:04:55 -0700 (PDT)
Received: from vbox.. (softbank126093126126.bbtec.net. [126.93.126.126])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f58bec0sm2521505a12.17.2025.07.26.22.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Jul 2025 22:04:55 -0700 (PDT)
From: Xiao Yang <iceyangxiao@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 27 Jul 2025 14:04:50 +0900
Message-ID: <20250727050450.104599-1-iceyangxiao@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 27 Jul 2025 22:37:44 +0200
Subject: [LTP] [PATCH] doc: Update the usage of kirk options
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

The kirk options have been changed since kirk version 2.0.

Signed-off-by: Xiao Yang <iceyangxiao@gmail.com>
---
 doc/users/quick_start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
index 8a25b9129..e73175e33 100644
--- a/doc/users/quick_start.rst
+++ b/doc/users/quick_start.rst
@@ -87,7 +87,7 @@ To run all the test suites
    $ cd /opt/ltp
 
    $ # run syscalls testing suite
-   $ ./kirk -f ltp -r syscalls
+   $ ./kirk -U ltp -f syscalls
 
 .. note::
 
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
