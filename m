Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6357BCD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781601803; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=K0oDYO8n5yae3EPpfWpDSpQVJfXzRCnMjTb8LRzfAwM=;
 b=MU1uJqZWwYssxNzMfsEHF3cUKSW5MioWED2V9T8UdDiB5ic/tdhWtGHPx4Ya/hc3TpxFG
 3Dp7y1oaoLt3ZXfFWzp+lEzUbQWJR3ABBMtouKVgWc9bIW4a4si3W9b3eDn8WFTHicS2du3
 3QgbE4S9ERw7DE447qVgw4fUOr0HPLc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74CF03E5961
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:23:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D86E63C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:23:02 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 473731000A12
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:23:02 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso2369399f8f.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781601782; x=1782206582; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bt8M6ndSwF603K6HmTyq4JRho3lFBoL2YRTwL8Gz7Ug=;
 b=TRLfJG/p0a48iuswQ508+0MDvTmFRV3+r4ISvAUdQ0cUWPh8NjfY0SeGiKMzClyGvz
 /L1Zt8LUDPkRjDcGKTrCdfzBSBC7J03/Hqjz9FQ2CwkVgKDBF8TFE7cG4Y1VNSCw1vBf
 7++r+l2Wsp5ZMLqgBVoQhY0DpCpotKv9VFnqawCZlhBD0FqLc6y8rRcbuxawDu1wpAHX
 AGUNR+dXRNdMSmcKsD1YSFc9Tr1n+vlwhuLUv9Y2uLMmvuuaWDtNKLGe3kdN2A4ionD3
 ayZRqib9TuWKRsZ/sdOe7hqvKfzcJuT3aB+PkbQf5//swxMpWrQm5eTpdTEw0jFmwrpn
 YMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601782; x=1782206582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bt8M6ndSwF603K6HmTyq4JRho3lFBoL2YRTwL8Gz7Ug=;
 b=m4DaMq4TqBoFVOje36dttGUTgM2ED7FeJkOCgiUhrZltqZORzYUbXg0KEY+vrB9Fqc
 BzQmCcfFJcGemXdHRqIsXKG4Hagv9ot1RGeXULwR/RsMCTc5wQohLAAD+hjtcvAj+7QP
 HqvkG9iHXNzGkplDJFajrVDzYWis3kshS8hKQOzmet+MpLeRa+FrNfeGNBu6Em9X9dkF
 pGraQl/z21Jc5XCrrPboUKt6W4izlbsxQL0kqoF8zHMFaNj6zvXhsYcNXympvIn6GJg/
 SaglOwspBdBYQZe/F0Cf77Lsc1budkEmJ/W9b3M0NR8lFKmTOnF7yksC6HlofKrTzkTD
 BbEA==
X-Gm-Message-State: AOJu0YxK0bsgHtjJPHAgnHlAxZtVkVnx9LHUxQ/vty9U91J0jSJAZFrU
 ZI5a92u/VT3s+jZlXqDetqLgJ8gwrE6v3VTWJUYacuEz7UpWfsL3IKrNBm/1YnTdUrUb9BecNi3
 WFXxy+HU=
X-Gm-Gg: Acq92OFr11dnsP54cM6YqqclbObrI3sdRgWVswPLXvBydQ/yV2UC/pqdz1h3S1AZuLt
 vV936BfuTY50jekgT+4BGYxk8ydCia09rAVpvRRojUStR7CyM6k7QNosT6NCuq+/f3e/VJBq7z6
 udl7X8W3shROkcFKwoEmf1RuqHeT8faiGDJRFwlsS68wblBkH2dBGf5/TfOZ+NmIn/in4FgSEPF
 VVglDqayGWVSh3fPOWB2wu9Kv8Xx8qNm0/dZ8WtE7caMyWnaKD1q29xxKWrFkv7PHq3Sen84yHI
 AbYhyFOo1UhXKoos3THH+LeaejZ2LBgE5Ni0IYsnOV6GOsnKk6NWt4lQ14jellOl9EI+/FJwI2I
 t9Av4jB97IhGeM6pX+WxCMLOsIGvHOnmKFTNnpuGwnvuYsmYpI1Obhp1NCdGY+woO3ZXLQmgYH3
 TwA6hdZsf3AA==
X-Received: by 2002:a05:6000:608:b0:460:70ae:f196 with SMTP id
 ffacd0b85a97d-46070aef211mr26903640f8f.7.1781601781475; 
 Tue, 16 Jun 2026 02:23:01 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm40648016f8f.34.2026.06.16.02.23.01
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:23:01 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 11:22:59 +0200
Message-ID: <20260616092300.177787-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_security.sh: Fix bug in tst_disable_selinux()
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

  tst_disable_selinux() used "cat 0 > $f" which attempts to read a file
  named "0" instead of writing the value 0 to the enforce file. Replace
  with "echo 0 > $f" to correctly disable SELinux enforcing mode.

  Reported by ltp-agent [0]

[0] https://lore.kernel.org/ltp/20260615131754.3990-1-linuxtestproject.agent@gmail.com/

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/lib/tst_security.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 820736c72..ab1dff816 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -119,7 +119,7 @@ tst_disable_selinux()
 
 	local f="$(tst_get_enforce)"
 
-	[ -f "$f" ] && cat 0 > $f
+	[ -f "$f" ] && echo 0 > $f
 }
 
 # Get SELinux directory path
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
