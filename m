Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05FBCA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 06:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725433041; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=VFYib9u3aydq8i4eJUmNTgeUyQRSto9W4xyAP57lsTg=;
 b=NgZKNXD0HYaDHgRej+7pFKyBIhdOXFua/J7rwuFmbyrScgFBZt5ORtxiRsPactYJdwVnI
 iQyEYZjaaQnptOb8wYf6MLWoc4gIi8JjMCG/WT/Sez+hWKgGob63jYdRkZe303CR+xEHTRQ
 yQl+/i3n3+6YK3BSglElj51wNHaqiCk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 474873C0CCD
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 08:57:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F99C3C0092
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 08:57:00 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 775726233FD
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 08:56:59 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a866d3ae692so357390066b.0
 for <ltp@lists.linux.it>; Tue, 03 Sep 2024 23:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725433019; x=1726037819; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UC73SzuwSrO3vU6GYHYWY7jkv3dmJjIVaI9FEFOSi8=;
 b=YQJXQKvOq+TaQKSYyt2rhc4nnSRsFTKbfDAD+ACHNa8BmNlEDrReK4uU2SIAgV61tR
 6e+alcnSOIxnhyNPqGSm9DzHRM64FYaWV5Ug1U+El8cmvv4BJpr66ycW+A8bM9tFP+H/
 0bIZL8zKs+R8q46nw/IVT2vOz1d23LDaz270eYNioYwS4hwhX3b4h+sp72GfFrOIqpQ+
 Hpukb1QMVoWbWSAPFM4BTGZBkWLxexhx7u6rA72zqvmJTrjLuo4eAxh2ZqfxqHYVbT/e
 lR+/caqEdQaJqNtsFPbYyHoQTJriErk0Xuo1rDvS347ad2fY9s22tMw8ERkI90wW6wEJ
 S7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725433019; x=1726037819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UC73SzuwSrO3vU6GYHYWY7jkv3dmJjIVaI9FEFOSi8=;
 b=b4BTzHpsqBarZLF+4YWy7z1lqyhorRzOUYiuozIOylfigxYXqGKlYFyOInGNgAhCjy
 HxjIecqYj4JH15QquCyI41VAi6YP+7F+vRrKk4Mcb/02j2WyshzKl/WJyFtGJoKBEVcK
 7PVn1E9qQgzBQBRseuWIb/vr6ctyGzLQJXWwNKdFWmgVmdMUhSG6CSOVNlRh3zI1+SBT
 p0yzjoCkJHN9kapPrzffdi2fN696BBYarM0uBjObYCa+bkcQ38KhKGvPstRHOqsSnUSQ
 SC/Q82AZKLSSVstM1qSe8YABgyBwlzha7LbEGCEeCZubD7TWganTSJXvi0OLE2hfOk3d
 aZ2w==
X-Gm-Message-State: AOJu0Yyn40SYfUM4iJnBcKHk3+Hl4tGVUtH8yYc40mZNhiNakE4y64vo
 M8dTpBbCvYZTgejF5GKKmTmM7eUZRwhMS+hd/2gC7msO+3qxu9Uua5RYKb4+kU09FcuBra/QtFs
 =
X-Google-Smtp-Source: AGHT+IEG+gtDNEbhCDBXs99MKw8hGlMl1HVqxXeNo6H1icbGuzCHXzkwD8tbfau/8sPcddKowMMS3w==
X-Received: by 2002:a05:6402:847:b0:5c2:60ac:fdda with SMTP id
 4fb4d7f45d1cf-5c260acff39mr5450537a12.17.1725433018542; 
 Tue, 03 Sep 2024 23:56:58 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226cd4bcbsm7309277a12.74.2024.09.03.23.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 23:56:58 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  4 Sep 2024 02:56:53 -0400
Message-Id: <20240904065653.31086-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904064817.29813-1-wegao@suse.com>
References: <20240904064817.29813-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] mpls01: Add --allow-unsupported for
 modprobe(fixing all mpls cases)
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
 testcases/network/mpls/mpls_lib.sh | 12 +++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

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
index 380b568bb..3c63e16a7 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -33,11 +33,21 @@ mpls_virt_cleanup()
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
 
-	tst_net_run -s "modprobe -a $TST_NEEDS_DRIVERS"
+	mpls_setup_driver
 
 	ROD sysctl -q net.mpls.conf.$(tst_iface).input=1
 	tst_set_sysctl net.mpls.conf.lo.input 1 safe
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
