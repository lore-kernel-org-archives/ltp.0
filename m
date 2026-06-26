Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6DFCDE008
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782456243; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=e/AGicGzXBQD7LtBKXgfCOkUwL30gretHCSwURspnbU=;
 b=TqX9wEYypXASORk8TWDMzPyVjJpbGLQ5cjUT35S9z5ooWORxnRlyTUyV8X72ujIQMRwWh
 euDT7Avtul7VMc4aTZ0KyvgFM1UBkQjH2eoc5xf9b86hRntKJ2/jT6F6vNm6JKspzuJI0lS
 EXqIWFKLPScwQyvQOKo6IG8FSTo4PPw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A82F23CE99A
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 08:44:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E686D3C9E1F
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 08:43:43 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 618F21000A59
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 08:43:43 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso7578985e9.1
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782456223; x=1783061023; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=f51eU9gMyBVZCvmfc7YIgT4KNMlhcood1F5fweLr7zw=;
 b=XdsRZNCcMZItgsNgcWnmnFGnNy4EGGRYuqsIRbtMupkpeGZQ6m8fJySyYMtO1ITaaG
 di8mnMJFEbjS8wTy1ttGVwqmPMA9q1y4PY4ypCbp/NWGH3n2ZfLGMnY3QMdrFzDyvXSv
 acifSMEHUoX/Y7fxJ+T8D2Z7yjI3bUAjvKOiCJBD8A3RD//yW8x/c+Aall7ozqjDEq17
 jE7pGurgc+0aH+JF6SlGhDz/Y011RPa4Zgz6gKbKS8rIGjn54QedfkUnBC8+SSjpwm4z
 KSZEp6S21NrYQgUS8/wjntG8zO7QuU+nMZuEUOmFBBA4BdTQme4yHzVj2D/o0HfbEWfw
 L7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782456223; x=1783061023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f51eU9gMyBVZCvmfc7YIgT4KNMlhcood1F5fweLr7zw=;
 b=TahcwrzZfGevCp6dL4WPukgml7Bo1JVFRjTZFH7hKYrHbh7S2xcglSM/uEgrFRkUPA
 SIC+GKNrhY3xbAI9iAPY2+A/9Bs7PBzm5BcEKagTFnVya6qz/DUZUwLhMLWA+bd7L6e4
 qTtIOzvqJCMLSjug9Lyy468QHj/v//xzvuLK/L3YYd75fKD+kOhoRuYniG/ubF0wNBrh
 GDmSerdTQOfcqSijG26s6bT3Gn50RN8dCrpXddtZgY/+KEuat37m/vAS2FfdKkwkPG5g
 HV5oaidEC4cu87qSq3qeAbpp6NobXuhyCbN8sptCT9jv4YUv0HKGznclSEWBJsqtBzS0
 emHw==
X-Gm-Message-State: AOJu0YydGH5KWhxWV7/Peu4SzjdPEzCyCBAsoIKHxrii76NTQiRcE58r
 A/0QnosdJMrGQ4Pl2gf7dpOMGba8pUiLkJz7/3f2xe5AMi+nc3UKzj6HPXm/jJyWO+TajkEEqg6
 8yhQvohs=
X-Gm-Gg: AfdE7cm69kn11P8jQgVQDKaeGJm5rutkQagl041KTBrGR0Txc/J9enx7G9419I9NzsG
 aeL3Nnak+xAaaKxjQefIwRr3JhGYK8JmUnekZmS7/GdADl0lyLhlgXUKBsmEnTPGY30tMg+5SqY
 4fVlEjWAw1pCfpWUIlxWMIFZO9M9B1S8usRfYNOizZFH9SzDq0ijQQ0OaQc15cUTB9AffMtLDEl
 3XqN/f8Bjre+pZ3Q+3Fng7o4szOh4X1EQX+eaeIlxCnBswrlTMpNwjT05XLUUBsdBmsIqd4u+jK
 eO3o38mWTiluKKNoWfwLbK4swqly3ZVFgaih6nx1Glqh0UQJQXp/9+fxqP4BnarlR5FUHVqB0QG
 bUN6vVyCkptZf6zgtS6Inj37PXwp9GGd8Z4H81u1Nh3nolxCSKKBPO7mLr30CDDMlabF5SrPXy7
 E=
X-Received: by 2002:a05:600c:a46:b0:492:604b:c77b with SMTP id
 5b1f17b1804b1-49266885dcfmr73965605e9.26.1782456222644; 
 Thu, 25 Jun 2026 23:43:42 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46caad603b3sm20429895f8f.7.2026.06.25.23.43.42
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 23:43:42 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 26 Jun 2026 08:43:39 +0200
Message-ID: <20260626064341.196316-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nfs: specify NFS version including the minorversion
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

These entries were missed in commit
4e115dfeee4b ("nfs: use NFS version 4.0, including the minorversion")

hence tests run on NFSv4.2 instead of NFSv4.0 in these two scenarios.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 runtest/net.nfs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 5d6adaa70..905fd5187 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -58,8 +58,8 @@ nfs05_v41_ip6t nfs05.sh -6 -v 4.1 -t tcp
 nfs05_v42_ip6t nfs05.sh -6 -v 4.2 -t tcp
 
 nfs06_v30_v40_ip4  nfs06.sh -v "3,3,3,4.0,4.0,4.0" -t "udp,udp,tcp,tcp,tcp,tcp"
-nfs06_vall_ip4t nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
-nfs06_v4x_ip6t nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
+nfs06_vall_ip4t nfs06.sh -v "3,4.0,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
+nfs06_v4x_ip6t nfs06.sh -6 -v "4.0,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 
 nfs07_v30_ip4u nfs07.sh -v 3 -t udp
 nfs07_v30_ip4t nfs07.sh -v 3 -t tcp
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
