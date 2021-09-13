Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3152C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:40:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B21860F6C
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B21860F6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell-sw.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 028EE3C9271
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:40:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 516733C57F9
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:40:38 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE577200C70
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:40:37 +0200 (CEST)
Received: by mail-lj1-x234.google.com with SMTP id o11so9538984ljp.8
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LHob2xLgOtHSJf5nHiEAESL2t6edjqfwsBFjHlaHrmk=;
 b=FAoK2W3mT+3jegHpryAOsAnCru7P6HmFleyp3nQpjRnEK/ybDJkZ5hoVVVDVgvy+PP
 gRHQokqZ2N8n9mjwnmbFhqhsqMhlskhI43S3ofsi/ekE0PibZUbW2iHV08gIAyBA4JjB
 D80nwWCIAm8jBlCRJqOILcDxSi1DY2UWNyxflERvykPNVcfIuhEKKAXCGCwsrdip5T6z
 rZyTRFzWkutXXc01+krT+SMWM8ga6tMUhKbJdJ0qzmtOy2IIkpoXK2h+V118KYVa8iEW
 81KS0BShH2zOAy0J3zubh6teJwtxaKbAOR1X9F9Db5YJdRxWMGIQrYgnIoKRU5DvD69d
 Ekkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LHob2xLgOtHSJf5nHiEAESL2t6edjqfwsBFjHlaHrmk=;
 b=tg3nc+bodqk58q0mvDrfSeo5xTZg50WP94ImXI5K7P/1x3coa/w7JG6RJylotbd692
 wiL0P4d9Dq91ExOHNK05EFOUlmPVJBpCs4uL75Q+jYjcSnsUSFXTUQwHfYtBaVD0GChJ
 psSi7Vu+UtVypTL3qFLQKgI1ee7M7g9VWyHhyke4NJeJnW3TW3D5XxaWyXPwvQ5nrFTv
 1A9Or6mkzotaqDaLBZfMBxtt/O0G2CUBTlhUDZbqBVc8zwjrFA0j14+pTR48pmuXNWr6
 fyLtztJ/HjFh/AiOkRGartpyZpW9z0D0purhz1HfTqzXWgmO4N9C5ue/gxSILyr4pePa
 9Xig==
X-Gm-Message-State: AOAM533UaVSuU04YCXuP+aaVDktc220woeYhh4rcVegeAtfvZpLKV4f5
 50EVN+/qvTAgHnp98gdlUPOysqXBe0je
X-Google-Smtp-Source: ABdhPJwaQFdI5gCkMuS5Q2olaqwkzgPtciw3pKz5CwxHzvT94xEcv7kE86SHn5d593p6ASNDfHOkyA==
X-Received: by 2002:a2e:88d0:: with SMTP id a16mr10340464ljk.81.1631536837192; 
 Mon, 13 Sep 2021 05:40:37 -0700 (PDT)
Received: from localhost.localdomain ([95.161.221.177])
 by smtp.gmail.com with ESMTPSA id z4sm814560lfd.298.2021.09.13.05.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 05:40:36 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: ltp@lists.linux.it
Date: Mon, 13 Sep 2021 15:39:35 +0300
Message-ID: <20210913123935.10761-2-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
References: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] lib/tst_net.sh: disable ipv6_dad work on test
 interfaces
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
Cc: Su Yue <suy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913123935.XRYODRdVtGoNZ21Nfd8gzAZlJW4wsm6kF4ZoSY9Acj0@z>

To fix intermittent issues with ping (in flood mode) [1] tests
after initial test interfaces setup.

We're already adding IPv6 addresses with nodad option, but it
should disable ipv6_dad for link-local addresses too, so that
they are fully functional when tests start to use them.

It could also be tst_wait_ipv6_dad(), but it slows down a test
setup.

[1]: https://github.com/iputils/iputils/issues/300

Tested-by: Su Yue <suy.fnst@fujitsu.com>
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/lib/tst_net.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 7f2a1bab3..89d4c79ec 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -517,6 +517,7 @@ tst_init_iface()
 		ip link set $iface down || return $?
 		ip route flush dev $iface || return $?
 		ip addr flush dev $iface || return $?
+		sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
 		ip link set $iface up
 		return $?
 	fi
@@ -528,6 +529,7 @@ tst_init_iface()
 	tst_rhost_run -c "ip link set $iface down" || return $?
 	tst_rhost_run -c "ip route flush dev $iface" || return $?
 	tst_rhost_run -c "ip addr flush dev $iface" || return $?
+	tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
 	tst_rhost_run -c "ip link set $iface up"
 }
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
