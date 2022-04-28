Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1453C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:42:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A6643CA759
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:42:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09DC23CA75B
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:47 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F3C111400BD6
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:45 +0200 (CEST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BDE403F32C
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178444;
 bh=GdoFZh0EKiN8DC4/gBuyTCwwxUwn5bFSu9gTnI+GmD8=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=enFwXqdbB54lVAD/h9TIEA9HJNNfYVyK6vSaUv0vTxof79aCA0FyORfj2OqquQXdU
 VMOC1UfuqEaHKjeXzFbZ8vue9562dwWWPOd2tQ9ztFKmMyPYLTyQ5DD2tUPX1tg/GP
 JB1NYsbSzO+nF8ox/W4H604+PMWjbs8+wNEk2QKGAWwsFmClbOp67YEhN9lxdfGX9C
 nzoTwVR/1HdvFZrenPlsJy1DM+7g4PWkITZxIYe6VSmemi1LqKFsqFpW/8HA9YMa67
 VC+y4fpHgtA+fQKZVGRkOZhkvU8Us/0s1M9JGe2h6yxRn81WEHH+hpysX35uIiU1X7
 DtoYXybf5YUTQ==
Received: by mail-pg1-f198.google.com with SMTP id
 bj12-20020a056a02018c00b003a9eebaad34so2930772pgb.10
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GdoFZh0EKiN8DC4/gBuyTCwwxUwn5bFSu9gTnI+GmD8=;
 b=SXZyTPkiYBgL6u5l9p4J5ZPv9fV4yejlTDoNtjaHY5rruQG1DBjMKp+BIDdzmU8O7P
 ryaZ0bpbd4RaqZ0SfBbNH4A0RmY3V4qtubD7py6L0lrXKw/+tJqXD4alcmDy0+2SZOMc
 KArA5Yf87eKGaUGap5G/YLGdPXO/e25XJbrLH4M6JetAzq920shOwAwcC9vgP2k3Lgus
 xwzfI32YxujzTEETkMQkp3h8KeWv2LCTlTbTsTSaiy6goYh9sVDJJ736ZA7w0gthugGV
 unr+xSjwLq99o4vJJ4Wlqk6sVcX2U+54MviQTHEWgRzrX8IFUA/wCJ3m9V6Bot2ZJHSN
 eOlw==
X-Gm-Message-State: AOAM533XBnsBmqlvwbc+IVAtjkd9ncAZ4kqOFTTMsB38pUKDffL5m7e3
 tdQyjrkB3pKXHyDmJ5DJAFFhxS7NUKDCwb1wET+Ohz0YIEfvFW8KGBELiGmP8GhChYptr8fODcs
 YMlT0y2WlnbSnH7Nr11K39Ouc0xKf
X-Received: by 2002:a17:90b:384a:b0:1d9:7835:8c with SMTP id
 nl10-20020a17090b384a00b001d97835008cmr27256pjb.167.1651178442564; 
 Thu, 28 Apr 2022 13:40:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlIL6psFbP/0zEBUTXpSkYFCb1edW1zX8Z0b3vH1GV41rs5cPGNsjK98jOPUssUjSyr/ExQw==
X-Received: by 2002:a17:90b:384a:b0:1d9:7835:8c with SMTP id
 nl10-20020a17090b384a00b001d97835008cmr27238pjb.167.1651178442349; 
 Thu, 28 Apr 2022 13:40:42 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:41 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:35 -0700
Message-Id: <ce6c0683b6f053161fbb8b1469ad73e670e2d22f.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/19] testcases/lib: Add tst_flag2mask function
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

This function exists in the older test.sh and should be added here so
that easy access can be made to map the flag to return values by
programs and vice versa.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 testcases/lib/tst_test.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index d97df9ab4..245c78886 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -434,6 +434,19 @@ tst_require_kconfigs()
 	return 0
 }
 
+tst_flag2mask()
+{
+	case "$1" in
+	TPASS) return 0;;
+	TFAIL) return 1;;
+	TBROK) return 2;;
+	TWARN) return 4;;
+	TINFO) return 16;;
+	TCONF) return 32;;
+	*) tst_brk TBROK "Invalid res type '$1'";;
+	esac
+}
+
 tst_is_int()
 {
 	[ "$1" -eq "$1" ] 2>/dev/null
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
