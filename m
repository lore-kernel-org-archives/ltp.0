Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF1FC43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782842958; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=noRmb2AhCfHz42fMuWYjh7JbgTZEsaOAeZSt1IBa5vQ=;
 b=i+dvF9nhIjB6pkZv+D0OvydG9XBvHWRH+GhGzgsYU3LGXDYu0LAv1Y7PgjWzLV6DIUqcT
 KS27ycrFV3ERbMF+i3sjyTKc1GrEqkEBj4lIs4rn2wcP0k97o18LkIqdfgXuKGK64tRM2dT
 lb0QD2dBHtiz8u18SWA/oOyp+c1E/mA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7746C3E4E57
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 20:09:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 807173C73A9
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 20:08:57 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C13CC1400114
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 20:08:56 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493a54b80a5so41459125e9.2
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782842936; x=1783447736; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EhElogdM8zPuKktCJHmqHMkDU9SL5V/y9fn6ydOUf7c=;
 b=Xn06HH5dM/Cl8bF8uOfml6jevNDo7rJ1d/wAcSE7eJi+k5YIDLI04BAicS/373av4s
 Xep9+BryNFgOk0Lwl0OnI14vPjRZBOglPK+O8iqR4jSGLS6CpCB0aaub9+j9V/qqbJK5
 jkz5DoTww2Rx9JW3qH6z0UX/dz7anjaZWilwNXibcaC8ie0ODMux+H2t6ivdBB8Xqxkn
 CUbF9Qc5CF9dqeDycb1elj6UTk2QZjvl/PxVqz92mZhuHpTBo9/JIEVR9hIuV/DL9Ij9
 ePDdwEvMO9HfXyIuRSXMrqkIkYUC2l5NYb3ccIiz5N6YsLBuZJ/fGHGqxA992jrZzf/T
 X1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782842936; x=1783447736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhElogdM8zPuKktCJHmqHMkDU9SL5V/y9fn6ydOUf7c=;
 b=KzjX4k8haDvxDALtB+NrEM7bdBcEctCgFHiYjrOsAwjna/028dmd2A4p9gOYcs2LQx
 jNpdEt5S9JwbeXuTBNUIf30fCD3elnWle1JD0MYj06rQ3yfAI35ahoRXcZnZgkmneBPu
 VX4kERynGvQm8WX3QOl2rK2sHQ1P5gOPPBBsRvcsWgQfKtT62WetwxFE8WoWLJnyI5AF
 ERhrbvpdReFrFoebk8pQNL5yDdryoUP+EOHkH3R3kq/IMSBHXlTKVM0xNEPyd/kFPLlf
 Vux5TMMAd7+3TbhtVo2fuuTrr965xUwALNNANCVj8xJc8M5ZftMcPyg+gCIo+vKIr1af
 pkAQ==
X-Gm-Message-State: AOJu0YxO0tleOdzSYJ3wQK/iYTFwTx80gJWmV08MP77uAf2ARhC9d2Op
 lXXXKoqT1/YX9hNpdr4ssRmak88Uy333PfV23p2Opgfi+0V2ZnJSaMH32zh5A77rqeTbSPo8EDQ
 MK/VhsRA=
X-Gm-Gg: AfdE7ckXIPKukuosrsriLayDuibovwHr1Bsbs6JYKYOTWqcVcPZzg/OHPk1LqbmwoN0
 7iAyPo9f49s0dgpizWajLp9uRo6QWjxez/p4FTRvjg1sTFHnimLpmoW2PjvM8DYvZiE6MrbOw7V
 qE5afRwEjtKdoklBGoRVBzdR+r5px/lT670rpBouhHyX1mXKPujYbl7qcClEvv75/Bm4pIpUO2o
 6bExItvLMp4vkMfdPx6hLqWUIcpkrGTTNQ5gMv3Q0kysCMqOyBPfQOwlxuJqCNggJjOuZR/3i+k
 vQuBsX3tDljLFuURvsV11xH3QXcXEdz5SfVKTvJOQCcsvCC5eIjOfrFsITz77acHwhyZZolWEhz
 H68TXbkadgLwpv5UpNpcIvwE2ZYNWgU+IFACtS/IFVtmv/2+XO8LXQL+P1VaUUyAQAQL2kurdh+
 Y=
X-Received: by 2002:a05:600c:3b24:b0:493:a88d:28d2 with SMTP id
 5b1f17b1804b1-493b82aeaffmr75364735e9.24.1782842936123; 
 Tue, 30 Jun 2026 11:08:56 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47560effc81sm9858849f8f.0.2026.06.30.11.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 11:08:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 30 Jun 2026 20:08:54 +0200
Message-ID: <20260630180855.159467-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_security.sh: quote variables in selinux helper
 functions
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

Quote variables in tst_disable_selinux() and tst_update_selinux_state()
to follow shell quoting best practices.

Fixes: cc9206e612b2 ("tst_security.sh: Use enforce toggle to trigger SELinux measurement")

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/lib/tst_security.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 03b744fb3d42..a7dd9de63339 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -119,7 +119,7 @@ tst_disable_selinux()
 
 	local f="$(tst_get_enforce)"
 
-	[ -f "$f" ] && echo 0 > $f
+	[ -f "$f" ] && echo 0 > "$f"
 }
 
 # Get SELinux directory path
@@ -147,8 +147,8 @@ tst_update_selinux_state()
 	[ -n "$dir" ] || return 1
 
 	# Toggle enforce to trigger SELinux state measurement
-	orig_val=$(cat $dir/enforce)
+	orig_val=$(cat "$dir/enforce")
 	val=$((1 - orig_val))
-	echo $val > $dir/enforce
-	echo $orig_val > $dir/enforce
+	echo "$val" > "$dir/enforce"
+	echo "$orig_val" > "$dir/enforce"
 }
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
