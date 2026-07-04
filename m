Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA702C43458
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 08:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783155450; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=VtCaFZfTtOcFh4x1lq/Pt7XvHfrhJa44HS3GaFxBG6E=;
 b=nLTWCs4wNCuaz/c/vYzHRLePAfnxwjUTucSAkpXQ4mRLFhTRD5Qf+oPHzIpWN48XCgFqg
 eiDARZyEPzEyTq6gNIOcegFJtvYKHI8/3o6nrsaj2qjv5j8kKsLqDJ1i6ELONQM/UXPq/B/
 r8wZ98vHMcxprn4n0QoN93YITpUXpyE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DCD63E5EEA
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 10:57:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19D6E3E2327
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 10:57:08 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C45C66002D7
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 10:57:05 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-472326ca506so867476f8f.2
 for <ltp@lists.linux.it>; Sat, 04 Jul 2026 01:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783155425; x=1783760225; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fjCbN8xAFegrhsMkAFmCOAjYryE+nCRIbf41nbnuOrI=;
 b=duXMZveVgxL/kN0YRdrHSw2L7F8Dy5ffbhCwoXv/pkDh1PTlU/JALEacSVr2D7tQ+B
 V9Ze1kAqaSFjG71FrFIpD/FIqO8g64s3ObrDK0NaUUcQXGLeFDTv91eIalUm0Gkmaoeh
 G0VtPn7tCwsR0lmvFzIdU4qV0xCLZ/69UC9ShUxbZhDwaEZmuWKflJWzGrUhutNrKOnv
 alQj/4pMZmNVMNZPEulS/lKqnFPat145ZbG8URLBM7tvrG58kClEhn6uCRXrlWAWv6+k
 VobMTgMdi3o/I2TvU6qSNz17WJVCa7ztnf/Xb9Y1Q7hBxxY9R2RVXqO/pHPmmiyjHkwo
 rOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783155425; x=1783760225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjCbN8xAFegrhsMkAFmCOAjYryE+nCRIbf41nbnuOrI=;
 b=UzxgoIEOeZb9qXeMeBDqej9i+IMM+44W3gbg9Ovpk47pc15y8Gqit6S7nS1/y2JkY7
 h7Rqw1s6qlgp4Ei+f19puq0VWmOJMfODGtxsYwxXWkkRmhEzD3o8N+KbJpHuRI0SZe9e
 XsA/p8ZGZY/oDcXf1uxgq79C3b4LUPomfaSQtCNiKWGNYO+TBZQLsVCZi2z2EmWPEg7i
 v6U5fual1p5MnfBXVUEIV5DUNGat3RBmzvJsQ8AJGiu+YpzqxsChwQuuapaiA8SEh9oS
 AxMRLw8xDb5aHLEHSX0NBVa/SohGUgtxZmMWJGUQ1fc0w5DNvuCAhG7kiC7KHq7J4Z/Q
 G3Og==
X-Gm-Message-State: AOJu0Yw8bSCuMKQeN7C1/AoIYSaewfFXwR7r2Ov9pW8aDm33xgfWdE1J
 EbvEspm/YG9nCQPLCacSDYxajKb7FqsWh/nvV0ieJO/X/4y7vTLwSOyxINEh+daiE29ZP5RsCdp
 qgJsiLYE=
X-Gm-Gg: AfdE7cnP0GaRQFzMKmpjM8xv9Vu2q/h3gb9j2z21FZQLFHojD6r4KdijAyqahN3xfrW
 Zw8io3v2HonXffQt+5sna8Q0P9XNYNWDiVXleQCz6qV40MwrTDK42Tj5Kr/5ymMI8IgeVjyT2xc
 idGm8W9uDnb7hOVFoQupWBQvacnIqlDP4cWSEaIfki7tx8iqC9ceV3ogMO0YrTkP4mnJC7uk3Ut
 ugx29bxeCwb7QmlvG8ZTzMDdm0q0ro0QfaGnZizpUZTjGZP9Trpxizsga6gGdCBshnbtL0wYGQS
 oxV7hbDAeaOslkThV4q7JdHOZrJo2IW4nx9wlZbIpB/mjln/+O+bYNN05wYadFaI1yROzyh/LlO
 XlDAB79iiiFEouuXbjdONQrYiSwiJa73QxY4hgGqsaJ69bbNKDCTmHB0mtpBP9Ir/FT7se+TKaq
 mqkmQKeSRRBw==
X-Received: by 2002:adf:f3c4:0:b0:465:ba53:a006 with SMTP id
 ffacd0b85a97d-47aacf86305mr1956897f8f.23.1783155425068; 
 Sat, 04 Jul 2026 01:57:05 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960816sm5998496f8f.29.2026.07.04.01.57.04
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 01:57:04 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat,  4 Jul 2026 10:57:02 +0200
Message-ID: <20260704085703.618290-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_test.sh: TCONF on xfrm algorithms rejected via
 netlink extack
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

TST_RTNL_CHK maps a kernel's "not supported" reply to TCONF by matching
the "RTNETLINK answers: ..." strings. Since v6.1 the kernel reports an
unknown/removed xfrm algorithm with -ENOSYS plus a netlink extack
message, which iproute2 prints as:

Error: Requested AUTH algorithm not found.

This matches none of the existing strings, so TST_RTNL_CHK() reports
TBROK instead of skipping.

tcp_ipsec 1 TBROK: ip xfrm state add src 10.0.0.2 dst 10.0.0.1 spi 0x1000 proto esp enc serpent 0x81ea7757e7c71dc8f95bee692c0e8b1a2ac6e006066e74ce0024a54ee0175b70 auth hmac(rmd160) 0xf46316501051af3e3b2abd0bdfed7cf21a76fe04 mode transport sel src 10.0.0.2 dst 10.0.0.1 failed: Error: Requested AUTH algorithm not found.

This surfaced with kernel v7.1 commit
05d42dc8ab92 ("xfrm: Drop support for HMAC-RIPEMD-160")
which removed hmac(rmd160) and broke the
net_stress.ipsec_* "-a rmd160" variants. Match the extack form too.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/lib/tst_test.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2a83c17a5efb..8701bb390388 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -266,13 +266,18 @@ TST_RTNL_CHK()
 	local msg1="RTNETLINK answers: Function not implemented"
 	local msg2="RTNETLINK answers: Operation not supported"
 	local msg3="RTNETLINK answers: Protocol not supported"
+	# Since v6.1 the kernel reports an unknown/removed xfrm algorithm via
+	# netlink extack (-ENOSYS + NL_SET_ERR_MSG), which iproute2 prints as
+	# "Error: Requested AUTH algorithm not found."
+	local msg4="Requested .* algorithm not found"
 	local output="$($@ 2>&1 || echo 'LTP_ERR')"
-	local msg
+	local msg match
 
 	echo "$output" | grep -q "LTP_ERR" || return 0
 
-	for msg in "$msg1" "$msg2" "$msg3"; do
-		echo "$output" | grep -q "$msg" && tst_brk TCONF "'$@': $msg"
+	for msg in "$msg1" "$msg2" "$msg3" "$msg4"; do
+		match=$(echo "$output" | grep "$msg") && \
+				tst_brk TCONF "'$@': $match"
 	done
 
 	tst_brk TBROK "$@ failed: $output"
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
