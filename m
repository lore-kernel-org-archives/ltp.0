Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFC3CA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 03:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725422318; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Ex4sr9J4H7bnfbjdcXH4Ef8KhdNUHuIAV2s2GvG9PUc=;
 b=JAc7AbZCZ/wtRvqs16ticFeSrU6mjVs42K0FyFaBeJ8uEZckpSnvkEdIJH8iRvaiYk/zN
 dRjE5pgu25OSOCO/CyOspeYGcMTUMRxKECnOeewxtjFRFIsE8CJHJ1qdDbxDeDkCtp3833v
 Jphggr0qr/5MNpn21/geg8lJ/OmF5p4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48B273C1840
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 05:58:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E593E3C0BA7
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 05:58:17 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3D208602BDC
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 05:58:16 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a86b46c4831so693410166b.1
 for <ltp@lists.linux.it>; Tue, 03 Sep 2024 20:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725422295; x=1726027095; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPAyUILuhINWNznvsZ1IZK3edjHuHbIR9ngBLtcTXj0=;
 b=FEBZpWA7/hiSuxFtcFAns8Dn/thZfLPibFPsCimeDJQZyS5TsGGXW23H61hMEa+nXX
 YxlXXfMPukslPh0vfVV1oUlVNGRGl3tjg6eEra9uun3olqt8TuQ9hblbMCGAFafpk4CQ
 NU9xvbVIbWT7uXBaL+CfZ7FaP7Iu+Th/2C6wL4M6sQwTlZxtcOD1yVp7srPf7ta8tzUb
 KB/Fd+gALhKVWWcCkRYiurn74FIjaaXIFyMXOS7bi8Ckk3RWtUUgesbHoE7tK4NdMDhH
 /uHOqVV7gytz1K5fzSg5pcSTw8wQK4G3Cd+2xCQdjZz4uxZoOxBe88FTfwtcmmC92mNq
 gWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725422295; x=1726027095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPAyUILuhINWNznvsZ1IZK3edjHuHbIR9ngBLtcTXj0=;
 b=DUYqGdkznst01ZNWEoyercnfRhLeaboN6oXfKDbWu5pYm0bGs5sKkiLUgW11QUhSB+
 grMMlRDHlwpSef5WEWzJqD7FqImKB5opq6+fCQMr/YLAjRaAOXwsijFnJA4KQe03VhQM
 pWDHv4ubA1Y+ES3DrfXpV/xh/8fTyLjAQE1/2UR3xEqCH+F/PMAhBjlwWYUo5aENWvi7
 bXrX4r7S2t+TMRBYxQSGQhGyzRzQbpmksBqJcwuN+eSa/WjVk26Obv3vWUW0sZa7TeSS
 crJ1ooT3yF6vVd+d/blHCE47IHHVQuIAdOSb1D9B0DlOTEIFHzJdvfJIHyxNz54rZo10
 niRA==
X-Gm-Message-State: AOJu0Yzp+3lX7JYrc+sTzXic1HAOLT9ZWaV5qHaTMhCz3tq/Oi+IPKng
 LQ3acR1RILcvyGMyLbzvJ2f5O+wy8RERi81JWyzt9zow3Lu5PgMUNhHMZOr4XPp7/ZkmgF2j43Y
 =
X-Google-Smtp-Source: AGHT+IH18PX6p2/TGEYi1iYwiMJSMUMJuAHhl/+MbxNrZyCSzuk0kTjQmu4pzuHtmNwazJ6Kdc++Cw==
X-Received: by 2002:a17:907:3684:b0:a77:b5c2:399 with SMTP id
 a640c23a62f3a-a89d879c0a9mr921669566b.31.1725422294861; 
 Tue, 03 Sep 2024 20:58:14 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989196b89sm754293566b.114.2024.09.03.20.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 20:58:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  3 Sep 2024 23:58:08 -0400
Message-Id: <20240904035808.5891-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240903081916.27033-1-wegao@suse.com>
References: <20240903081916.27033-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] mpls01.sh: Add --allow-unsupported for modprobe
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/mpls/mpls01.sh   |  4 ++--
 testcases/network/mpls/mpls_lib.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
index 196b5b2f9..e453f8130 100755
--- a/testcases/network/mpls/mpls01.sh
+++ b/testcases/network/mpls/mpls01.sh
@@ -21,7 +21,7 @@ cleanup()
 
 setup()
 {
-	ROD modprobe mpls_router
+	mpls_setup_driver
 }
 
 test1()
@@ -66,5 +66,5 @@ test3()
 	tst_res TPASS "created and removed mpls routes"
 }
 
-. tst_net.sh
+. mpls_lib.sh
 tst_run
diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
index 380b568bb..2ded31ee9 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -33,6 +33,16 @@ mpls_virt_cleanup()
 	mpls_cleanup
 }
 
+mpls_setup_driver()
+{
+	local args
+
+	grep -q 'sl-micro' /etc/os-release && args='--allow-unsupported'
+	if [ "$TST_NEEDS_DRIVERS" ]; then
+		tst_net_run -s "modprobe $args -a $TST_NEEDS_DRIVERS"
+	fi
+}
+
 mpls_setup()
 {
 	local label="$1"
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
