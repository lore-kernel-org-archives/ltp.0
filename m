Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F352CA0EFB
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725011906; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=xL7wMF1Xvb9Pqa6p9LQ+3UvVymv8OTKUpvjCHuSyca0=;
 b=XEVxhYV0wFc+L5lK56S9/43JtPkpaCUJEqm+hASajRFGpPLArZoOnSDMT6JPo0xCqjdkH
 03M/nYVEIzQtvDucuuAjfVbmtedJztZyhxdIwLmxNI+gyaDR4NFAkQd4XZS7dcX3rtaqwxy
 RJ9PrG1uC1ymnbrrJYuZK9+M9McBFo8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11B4D3D284E
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 11:58:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C9833D283A
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 11:58:05 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57449610201
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 11:58:05 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a868831216cso200001966b.3
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725011884; x=1725616684; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sCsqk88fZbelrDT6PgGYA1juXQvJTKxiKEQaHepAc8c=;
 b=W18byHTivY7bGj+kFOU6RRs3a0XTi2uneLiVvtJMZDUNJgMz4yBoDGy2hJdN6kkeZj
 fByH+ZxFzeudzekvq0dVJqn6hrlNS7a8o3RkEr3Lb1mbP9radWQPm1iyCpz1aJeoGoVa
 29FjhoAFa5lEang1rz+DxA58Fv0aXjLIvFuqqJE1VIXnytar7UDzPKMVgCdZp2wFuIHD
 INohPOpTABZHR9NaBfdPxBD1qsWxBWJ/T2BHO5tEqA6g8CRYOIeNd2CCzH4av2y9RnVh
 3y76QVQ7+4jCaaH/Y2lX71it+Pf7yjMzjlOGGtRsBT9OMBK71MMMs3noFNp6PLvzceBB
 5icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725011884; x=1725616684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCsqk88fZbelrDT6PgGYA1juXQvJTKxiKEQaHepAc8c=;
 b=K80H3P2X8KSWmLubLM7OkUlu72QIDISnE41qqVvVT3Xjb8UlG0nRxSMvLVv/95DzbA
 gfQ5itQR9DZvbNal430/+r594+Up65eC+Y+zPsUjvmUjQlZsEfIq/zqKcgUNWizOi6Ef
 1WFGPsoAtQdB7Fha2whT4sV6dpUfkiXovKPzTbkySdVCAMItkmqCecG7hS2Fc25Jdm+M
 QJsJ0M3xRqe3DzukrubvZ7YZmChf8lSGuvHhJtd+NHpe3j94QFL3KLL3OfjMLJOVWIfv
 F39TOVuAB+YWrN0Xdu6LqJfszIsOjYIhEEXntFm9FTTgEuSK7avj7S8AY6DuqGMvWis5
 bgvQ==
X-Gm-Message-State: AOJu0YxjU4Th5O4F5iCjA8xYv8pg+QhTULw83WDor3ihyDht4UQQdwLq
 GwkSm3jwsdLS75Ma9knu5iMqZ4UiPQX1SxXB/AwWfZYR9kWGqgeGCku9zcvqKsM9Vz9h9HbP8Io
 =
X-Google-Smtp-Source: AGHT+IFwpC/QSgMXl++RzqH9EMkFbnzbouYHqoCj0an4+cJuHgltxLD/PvMH6g9CTF1fNH9j/TjmEA==
X-Received: by 2002:a17:907:1c29:b0:a7a:b4bd:d0eb with SMTP id
 a640c23a62f3a-a897f83ae49mr447678066b.24.1725011884222; 
 Fri, 30 Aug 2024 02:58:04 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89891a3e9dsm195805766b.108.2024.08.30.02.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 02:58:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 30 Aug 2024 05:57:58 -0400
Message-Id: <20240830095758.20018-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mpls01.sh: Add --allow-unsupported for modprobe
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In sle-micro we encounter following error when do modprobe:
root# modprobe mpls_router
modprobe: ERROR: module 'mpls_router' is unsupported
modprobe: ERROR: Use --allow-unsupported or set allow_unsupported_modules 1 in
modprobe: ERROR: /etc/modprobe.d/10-unsupported-modules.conf
modprobe: ERROR: could not insert 'mpls_router': Operation not permitted

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/network/mpls/mpls01.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
index 196b5b2f9..7f262d83e 100755
--- a/testcases/network/mpls/mpls01.sh
+++ b/testcases/network/mpls/mpls01.sh
@@ -21,7 +21,9 @@ cleanup()
 
 setup()
 {
-	ROD modprobe mpls_router
+	if ! modprobe mpls_router > /dev/null 2>&1; then
+		ROD modprobe mpls_router --allow-unsupported
+	fi
 }
 
 test1()
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
