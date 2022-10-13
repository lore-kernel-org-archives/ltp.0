Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCA9C4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 05:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11F663CAF08
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 07:59:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E95DB3CA9BC
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 07:58:59 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 65987200C2C
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 07:58:59 +0200 (CEST)
Received: by mail-pl1-x629.google.com with SMTP id h10so931548plb.2
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MIgpUP/eFFZLHbTgOgv6KuMJ6rKYj+CCk7iA8I7BUDw=;
 b=BqhH7aeiArweGKs/jsChV/1QuZQRmQJvzRv156DpN2/cvklf+eFyxyaBBcE+/0xZiq
 62SOjHnWeNCL8vGcAXizVFClvm8An0NwMD4Y9Jufev1AY7X3N8ee4+1mV9xFtFPuOqMI
 P6AxXVuinYAtvQr0ksL9pBy0JqFm6kqROM0HG0ilen1Xj5cnbTNmgkCvltbUf2fQhbl9
 AUO8/bW3tRcJtDquTzN2ej06sD3CvoYoZqJONcNVQKyVXfbc91M6XlrZsoyddbTgopd6
 WQTgUOXJnDGdwmfa1tOMCw+pm4DAprygbV7OPEzyHMenTexh46YhEO3mk+PtVb/FXHpj
 Jo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MIgpUP/eFFZLHbTgOgv6KuMJ6rKYj+CCk7iA8I7BUDw=;
 b=mab4i/bUzwW0aZuCdZ4zzXt4Js8eU0Ub+Wn5WkUajKJN53pOshLXaMGtO1btItLVKo
 JqXGhcQn/6HhQpb9BNbg7eITxCgZcoo8agQdEVxWUlN7WtNku9w3/X6CLRGAeMW7qqU/
 VmBlnjtAqO/crsXfE8EZNFFZsdV6CGCicWs6q7keMtYRH4mD+j3UN1CYy17ipv+JYOS1
 yL4/UM/EwGQOFahpo1XgncfeXK/h+3nrmIUmxha/53miELbHYxPR8H+DUK/eXSPb7WOT
 7z5ssMwuzpdHF4QfSMoHGBm3VWsPtFV5dZ8yEYX78gPNjXeKRsvkYXJAvdYWhz/qraHV
 g9Cw==
X-Gm-Message-State: ACrzQf0aj+aYIDcfLwUwpAVCPf4T1VFRc1Pk9QAUbULdwjw5SzWWhUp7
 oGYhumdbElOdwXxipwNT1KSpACKJdziamg==
X-Google-Smtp-Source: AMsMyM4zMGowG/Xuuo7QkR46PxP4GiujB7itiKVq5PUf7CMIV1fafK6rFASRnFTqgCRS5OiXRMEA+A==
X-Received: by 2002:a17:90b:4ac9:b0:20d:56c4:a8b2 with SMTP id
 mh9-20020a17090b4ac900b0020d56c4a8b2mr9163504pjb.174.1665640737671; 
 Wed, 12 Oct 2022 22:58:57 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b0017534ffd491sm5215719pln.163.2022.10.12.22.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 22:58:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: ltp@lists.linux.it
Date: Thu, 13 Oct 2022 14:58:45 +0900
Message-Id: <20221013055845.28904-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_test.sh: Unset the locale concerned variables
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

network/tcp_cmds/tracepath/tracepath01.sh fails with LANG=ja_JP.UTF-8
because it parses localized output.

To avoid such a problem, we can always unset the locale concerned
variables. network/stress/ns-tools/check_envval does that, but it is
limited to the network stress test. Add similar code to tst_test.sh
so that it can cover more tests.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 testcases/lib/tst_test.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 28b7d12ba..9a8b62f1e 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -831,3 +831,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 		fi
 	fi
 fi
+
+# Unset the locale cocerned variables
+for env in $(locale | cut -f 1 -d =); do
+	unset $env
+done
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
