Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11745C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 20:15:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2AE63C8DD0
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 21:15:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E12BB3C0204
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 21:15:06 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E36061400FAF
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 21:15:05 +0100 (CET)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D7CDB3F1E5
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637612103;
 bh=zRZQa6mhJ0XBGY4fxps4pl8zKd0PeQSonSKTdoYIcLw=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=pC5wVeiXXruPzuD82exV/KWu7rDwWhUb9uzqUCQF2m3BXmrdd9NVHeS1jlthzgUa/
 GMOzmd6wz8yPNTiJ4yhrQortYl7V6S3F62AyqPeqpHocPHoIH1IMwmZMlNUY6zZ/yB
 AFwqpfErd0PAxB6mDgXOAB99L//+K0ail44VsOvKP8V7Y59SDrxyVuPeLsA5YHOJ39
 PClvh4aGLHAg0Bq1hC3Vi/Jxu/UnxuxqnOX1aBPF8FQT+t2+Jv1zqaXoWbxU0ByyZ+
 pnBWWYxtvNQyklrEtVAUOsmpaPxur0dmRXjDdrSEqDQUJEnXZlOXEVAz3b6KApZhRh
 5798YLFk27Zjw==
Received: by mail-pg1-f199.google.com with SMTP id
 o11-20020a635a0b000000b00320daef2ad6so2194907pgb.3
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 12:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zRZQa6mhJ0XBGY4fxps4pl8zKd0PeQSonSKTdoYIcLw=;
 b=ZzgYA1DJ7SwAETh6+iLsPc+/4vLmONrk9HkkabI2l+ITmePChDTkcVSo1j5FRor6d7
 RvTG3B22nFeVosXYx6+wUpH1SpBgFkoMgmZEB86AmNKtxZzTCbjRy+6L+X/0hsr5PWSN
 EzLFHwbLiSG+jF7uNHUf9yTKCwTB0Mcv1L94ThIVKvmkUMSZieAEoTm91lJRohrIJBTu
 c0fFQVzdcZFEfOwDv+/cKUTAkbx13yutFbq/l76i5Nd0CrtVvWZu0Yb4ijFLIo3/+EV7
 BwKH3NIJJqwOHiEBb/82ZW8JU1m+dCcKOK0rWQpJ7/ay9CrNlxDaB2TVos9Qqe5U4SzI
 qj2g==
X-Gm-Message-State: AOAM530S2xcLPfXrU3JLJUbZPs4YAJgGh2U4MBt3w0BP2bo/6GcLTH3j
 KaUHx3qgRCkth6qrBZcvMmZISsdW9mWTycJHsixoaki+Fv6+tKMM8V6BBpx66U92AUcJgCGFOk2
 R5bXNPuPbjTIV0CJwT1J5/WPxKVRh
X-Received: by 2002:a17:902:f54f:b0:143:b899:a9ce with SMTP id
 h15-20020a170902f54f00b00143b899a9cemr96969680plf.28.1637612101978; 
 Mon, 22 Nov 2021 12:15:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxppg/zGXM5QFzezaGBpQ6MjJle7IgjzQu02tsK9Dgsg0H7p3NT+a26/wX1FssUWCqBI+GeUg==
X-Received: by 2002:a17:902:f54f:b0:143:b899:a9ce with SMTP id
 h15-20020a170902f54f00b00143b899a9cemr96969587plf.28.1637612101405; 
 Mon, 22 Nov 2021 12:15:01 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101])
 by smtp.gmail.com with ESMTPSA id l1sm19369691pjh.28.2021.11.22.12.15.00
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 12:15:00 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Mon, 22 Nov 2021 12:14:57 -0800
Message-Id: <cover.1637611258.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] update memcg controller regression tests
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

These patches aim to update old tests in controllers/memcg to use new
test infastructure for maintainability as well as to update the tests to
work when the memory controller is mounted on the cgroup2 hierarchy.

I will more or less be using these changes as a template to update other
tests to work under cgroup2 (or at least report something reasonable instead
of failing to mount), so I would appreciate any suggestions anyone has. 

Luke Nowakowski-Krijger (2):
  controllers/memcg: Update regression tests to newer test infastructure
  controllers/memcg: Add cgroup2 support for regression tests

 .../memcg/regression/memcg_regression_test.sh | 175 +++++++++++-------
 .../memcg/regression/memcg_test_1.c           |  12 +-
 .../memcg/regression/memcg_test_3.c           |  35 ++--
 .../memcg/regression/memcg_test_4.sh          |  25 ++-
 4 files changed, 145 insertions(+), 102 deletions(-)

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
