Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A8EC54E94
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 04:42:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72B393CD489
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 05:42:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9748B3CB949
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 05:42:37 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0D979140075B
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 05:42:37 +0100 (CET)
Received: by mail-pl1-x62b.google.com with SMTP id be8so713409plb.7
 for <ltp@lists.linux.it>; Mon, 23 Jan 2023 20:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pOjd3CPoj0nBrAXClvAncpI+lEp1HUON3ZX7CK16MOM=;
 b=uHgppoq7mWVAIuwA2yjSCxaFvIye6+s7EgnpYaXMshzAGNdbeB1YDgYTOYBFYFVTA5
 m4EwL80i1YgQ808ZozLJYMAqQDufqvl2WgJIvxChOteClCmtYV3xUd/s5VmTSuz2A+Gp
 cwmuWUXJ6U+iP4p6LuBN4Y5K7j3sJ/yUVAy8EifipdgdmTLUm8wgrEUmv6qpAg1W22QV
 BzS9uaMn3cSdWf3K3CgVureCR4GLx6LRJGRUQrcIgWizkXZPs82+vCo1JWfFC32Oziv1
 Awt68CKJiC08x9QSYe4kOnL7Ks+jSxt5HPosYfOZlHOVv1KFIerD30OPz8PiTjtCDv03
 37dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOjd3CPoj0nBrAXClvAncpI+lEp1HUON3ZX7CK16MOM=;
 b=57BBJovSQBK6SC+8ZldvJw5mtBmIYEFLgbjFpX5F+ye175QQ3ZxI4yCRt8urQY3Mg+
 b5hxma9ZX27IPTdzRe3/oI367K7OLrvQam8tox5NO0gtpSEkQZn+3z8ATpkRVLOjgo6s
 BLQ+1Y48WnZysxD/Hlv/pngTeiFBL6aS3/0nsOhKsk7LcEzPgq1F90CAMtufVHj0yUgk
 37lTI+2dmH4QZe0Jjs7hrbAGBxYUiTc/tS9sWCCysAELVo2dhDGd/TU67aeC/iHDH9b2
 amyrTOd7yIlEyLcEDo7IYKlgUh8szcA/Oy2hzIZSNrkvNDJdXhHTaDOBd5Bq7Yfw1One
 tyhA==
X-Gm-Message-State: AO0yUKWu5BhoLndFQnFush0DvP98kQVmdApHyHkCzVRrJww4aqUjoc0N
 8/cOcjQsm5l8hc2NXsfn71n07MdYA6h20rVY
X-Google-Smtp-Source: AK7set8dGEw1z6ZkM+ySOgD/YrErcH9BBwKqF+eLspdgGxBUrxwCNRsJle60WMS+y1ROBpifnFd8HA==
X-Received: by 2002:a17:90b:1b04:b0:22b:ec6a:be66 with SMTP id
 nu4-20020a17090b1b0400b0022bec6abe66mr1409466pjb.31.1674535354921; 
 Mon, 23 Jan 2023 20:42:34 -0800 (PST)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:4457:c267:5e09:481b])
 by smtp.gmail.com with ESMTPSA id
 nh15-20020a17090b364f00b002276ba8fb71sm265184pjb.25.2023.01.23.20.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jan 2023 20:42:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: ltp@lists.linux.it
Date: Tue, 24 Jan 2023 13:42:27 +0900
Message-Id: <20230124044227.13635-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] network/stress/http: Do not use SIGPIPE
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

curl ignores SIGPIPE according to:
https://github.com/curl/curl/commit/e2bcd2ab9e5ad894a57756fa660d2a07b69171f4

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 testcases/network/stress/http/http-stress02-rmt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/stress/http/http-stress02-rmt.sh b/testcases/network/stress/http/http-stress02-rmt.sh
index 1734c2bd3..d7a77d3ea 100755
--- a/testcases/network/stress/http/http-stress02-rmt.sh
+++ b/testcases/network/stress/http/http-stress02-rmt.sh
@@ -60,7 +60,7 @@ while true ; do
 		-o /dev/null &
 done
 
-killall -qw -s SIGPIPE curl
+killall -qw curl
 
 out=$(curl --noproxy '*' -sS -g "http://$server_ipaddr/$filename" -o /dev/null \
 	-w "time=%{time_total} size=%{size_download} speed=%{speed_download}")
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
