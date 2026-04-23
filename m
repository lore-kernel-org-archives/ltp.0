Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD77FAD3EF
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 02:24:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4470A3E705A
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 04:24:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7B583E28E4
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:24:00 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 826576007AF
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:24:00 +0200 (CEST)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c795f441ff7so4193996a12.2
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776911038; x=1777515838; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Lcimh8JyD8wqWw2fzx7YY5O85K8lYLh4UbcAk1sHlY=;
 b=EDfbdFZuBVJGXwQ291AXWZGYfFvWeEipbYtgUz6r/6fkVKaLPg/zzg2UOh9o2H3rNw
 T5Uj9bqhTtY4rIwF9qrxlzKq9TWJysYBsflsrTSHDYM04zk4LiuiYQviNzyQswpAXdhi
 cZgP9ax56idB6BkPKG8DAC+aPTZRdedfHTmNHpiNBeldZua2gDLZf4/xMlnyNWmdRNyD
 GXnL0FcFbrMJmPoDR0xqStMDzcoTRkWLhP6uogOM2BzyFBKMig2vVmf4/A4348wU3XQW
 sfGXFjpMDhgkiJCSHOvsFm3XnN2mi7sEKJMu8YEf0dRfUvYDkHyUD3pHf9hVGKe1F5Mp
 TOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911038; x=1777515838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Lcimh8JyD8wqWw2fzx7YY5O85K8lYLh4UbcAk1sHlY=;
 b=lpCafNkB0Coig1jB8J10Gz8D2CPE1K3Nw/KOIF8TGzRNA5kK6F6N+XZXWTkG1/PQUS
 oiPz9DFNSRHmOlDGdMrLD+taGER1QlrMg8oWJxjCkTn9kFvnB4Mtvf+zcDJPXJK/93ue
 1E8ymRT4WhFXp1tWwFoBi3XqMnNZnz4pnd2nG+DJqhiMHayBH1BFSSGTKSWDVLkn3nWE
 wndW13Yf/UGy+7+HkHahKrilE6JkDpAoa/4TRnKGcDhOYNUHJS+ZAoFm3va9vXJRM98K
 Ze3PEaBbx2wCKcVSHic1j9U89xEuQ/gKxBjHH4oQYzovdpxwev+wyCRgs/dC0KD1Ycb9
 mJLA==
X-Gm-Message-State: AOJu0Yx0DZhEIxwZb9YOeeT8zb77N7Lqqr2LZP/P3dIN/ogD0oyeXA8g
 6100txU/1TZvtx75kA5U8exUVxQuGUWqVdxZPYFzoHtj819lEGfX5MMIvIo5wRFUmhIy
X-Gm-Gg: AeBDievzaos39ss1Tkkkj789Ngm4okDCIXU1yfxhXMarUNO3LkWWS1tn0fsR5xvUnE+
 oPxo5iy0DeSTr3gJJQBHzzRIO7WOTYzHceKI7yyspLxjQ45oavOHgX+5hCpsg6NqTrO0bThv7iB
 wx2mW8GTPMh90iBZL8GIQ464P436uuEqI/gg/RfzL5GEW03EMwORFM6GExmtg0yQZ8h+yX2Ipha
 A7KOmkdh2n3rrn17xYsnr7ouDMi9BCzCLKzAn4m+8R7FvnZODqxaIhAGW5PBG6NrpKReaZxvidg
 UV63ldyxzlnn7NO7pQiQgJk8b2iZ/CCpiIaN2x87dRe9yvIOfyYIfsRobJ7Wvd5BnbZsQh1uPFQ
 hevm7L5mRkmHWsbhBWGNwsr7aDyP8bUYLhKPp9KN4JieElwvFXlIuHU9giZw4Wg4f1NuQTqc4MJ
 tcIq/FkPhPqFw6rwifgftXQQ4bgWDv/UCT
X-Received: by 2002:a05:6a00:2ea8:b0:82f:807:ed7f with SMTP id
 d2e1a72fcca58-82f8c8c239cmr26599219b3a.24.1776911038544; 
 Wed, 22 Apr 2026 19:23:58 -0700 (PDT)
Received: from thoundrobot ([43.154.64.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ec0092bsm20081639b3a.50.2026.04.22.19.23.57
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 19:23:58 -0700 (PDT)
From: Li Wang <wangli.ahau@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 10:23:48 +0800
Message-ID: <20260423022348.11384-1-wangli.ahau@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH COMMITTED] mailmap: Update Li Wang's email address
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

Signed-off-by: Li Wang <wangli.ahau@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 221e22956..b488d309e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1,3 +1,4 @@
+Li Wang <wangli.ahau@gmail.com> <liwang@redhat.com>
 Petr Vorel <pvorel@suse.cz> <petr.vorel@gmail.com>
 Petr Vorel <pvorel@suse.cz> <pevik@users.noreply.github.com>
 Xinjian Ma (Fujitsu) <maxj.fnst@fujitsu.com> <maxj.fnst@fujitsu.com>
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
