Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412BFC433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 22:03:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDCAA3C8E25
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 23:03:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFBB43C2911
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 23:03:45 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6CB91400C50
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 23:03:44 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id n8so23883870wmk.3
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 14:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QdP5Y13A+6ynBdMjPrN/g8FbdbK4xTYj3UaqRwZlhdg=;
 b=iltZSXK1BUCRyy/wwKWPXi2Kobwg+oNPzyZWfSJX3LSGH7G80U90uUvOvct0Avanha
 PvoRA4UfKgjnM6J/783U/5m0GNEk8orivdIgre9dTohthNVUHNGzIur57y3gsO6SBlV0
 dDXCQcRvxedjDGNNoc5R/n+b7hF9/dKnE3v81O4y2HiQIir1JcBIfb8YYrOkcJEjriz0
 FRjy/vPWBo5apMYQSyV9zuGdZxL+CgCck6OGyWXfN53uktfcZVj6R4UglFszScxPAxaw
 4EHtkZuPPLqRjVHICNcWkeya92Jogmens5jF7Zq22Zp9n+G1/bbgZn1FnrIQfCHqav7T
 wK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QdP5Y13A+6ynBdMjPrN/g8FbdbK4xTYj3UaqRwZlhdg=;
 b=TqJw79SwBovibXab41R0xGLgr8r1YSzoodAm3zURlPA9Qwk2fgdsKrl7fiIzK9Dju2
 i2kTJXRfQY4UPobBRLjrbPm1ePcpSRaxycHHAOwFDyl6HqkhkT6qG6ly22dY3QMvrAG2
 dtz2lZjEEb06W6WAvc2Fbz6smt/LOCsLQBYcFAnaRT+UCUZprIeklRh1jxeEzg5CUyW1
 Rnrqd9SaqdAHg9CmaHuN8iujCutOM56a9GmT4GjtRtnf+g7dbBe0jflZ/Mkw1Osgl5Ke
 kwr8hC0g6dYngGr7ER4K00lPvsD+nSmhSSMQDmWMZOpJjd8/xRUFWm2tddpg4G3a+sR3
 gy2w==
X-Gm-Message-State: AOAM5332O23SCurlPGIIKLjogNJmj9ZGUcCCAvFm4P5H00o43WXP/vZh
 R2TT8WjQi/L3EnKgcHK7a4QTkmqBH5Q5s+tT
X-Google-Smtp-Source: ABdhPJzDGXCUrAryi2jljNiebeovtH1Tnvl5g1bxmb6BHzfsq9TQR//fHA0blh68mA31DGKwaXWA+Q==
X-Received: by 2002:a05:600c:4f13:: with SMTP id
 l19mr270025wmq.126.1643061824340; 
 Mon, 24 Jan 2022 14:03:44 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id n14sm457789wmq.42.2022.01.24.14.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 14:03:43 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 24 Jan 2022 23:03:34 +0100
Message-Id: <20220124220334.154003-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124220334.154003-1-petr.vorel@gmail.com>
References: <20220124220334.154003-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] broken_ip-nexthdr.sh: Check IPv6 support before
 forcing it
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
 testcases/network/stress/broken_ip/broken_ip-nexthdr.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
index ec6643af6..cb4a3dd39 100755
--- a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
@@ -11,6 +11,7 @@ TST_TESTFUNC="do_test"
 do_test()
 {
 	# not supported on IPv4
+	tst_net_require_ipv6
 	TST_IPV6=6
 	TST_IPVER=6
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
