Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA088C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 10:29:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CFE73C1966
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 11:29:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 637533C01FB
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:29:01 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=acarmina@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E627200ACD
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:29:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737368939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pUTgqjQX3ezwKJAQdR5i6zCitf326bUYwqjy28o/h1Y=;
 b=T3aC1YkXE7J93d2/l9ZRug2WA/hQg/uVM2VzWM5sUphqMK5BFfDWUQ04QsTXor0jpJ/Ry1
 1YCi+RwHCsWg8XZFgqb9hLjX97XJphpghU4sErDWKzRjX+8TFOJgnIW7eiCPDM8bfUfynS
 rGB7qfcMnryr5tiaFPRfFDf6Ih4dFL4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-mzBnIn2FMnS5HogFf9xznQ-1; Mon, 20 Jan 2025 05:28:57 -0500
X-MC-Unique: mzBnIn2FMnS5HogFf9xznQ-1
X-Mimecast-MFC-AGG-ID: mzBnIn2FMnS5HogFf9xznQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436723db6c4so32421275e9.3
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 02:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737368936; x=1737973736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pUTgqjQX3ezwKJAQdR5i6zCitf326bUYwqjy28o/h1Y=;
 b=hhR1khGcXaJgTH11Ey0AjPKcykYBs0t9c8vQL4ivpZntHrNSK/gPPGCDyjIaoa5S1n
 itdCVkoMIPhmskPjAnzQqa7L+aAWa64Pto389fdxHzu8Hj5dikQRBrBaKdyP55PDlSRP
 BIaRHrYfepfqJcsc7I5GBTitXMze/rK/uOkOEBIYY8LAJnYnkSCmCUoNEMQesT1xMHI4
 4HHOmi/MK/ZOAloinLxwNhZsuxCMdhslT121zZoJOZecZLzU7ny3jGJ7jgA85VqoWF32
 EdKco5UY0u2Iv7H6EVpuPm24AWjBiGWJ0kS3POBUJIH55GPFzOv5fzCWalYKZz46u3n+
 g8ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKcOpSX8xeItSqa4zQOEnu20qsrgW8Wgd0T78xCRSxwRp8lZbtbv5iOa1LfGLJzWfniR0=@lists.linux.it
X-Gm-Message-State: AOJu0YxK/Ae/ocubqw50dfBWK4bpUbny6Kb0bYzdnFTSIP2EQdcab8Dr
 2BtonW8Sc0DqbTTamDOvpmaJR51HTgSOb4lRdDDFBk1YOHuywLL9BgViSQqL7yIr0nHSu+/e071
 SAVzP/xpsRK882tME2m2H2105Xc6UhA7unX+XXq2jz0raNbv5
X-Gm-Gg: ASbGncvsrP1UXWh1sH1EaCqoIQ/xNdhXy9xE3PN/2fw8jX73NmAzd+IbXSMhzOSiQif
 1s1YSPRn3t3eqM1jDeneeWZVqHnSIkch74JVro4Mj2yi0m1cZy3gAX2OYJayoT0wUUrk+N2jb14
 VLwnAW7sQO66ZkpcVW5pNAnYq9nQaI2kLjgxccfYb7JrTU0YPhugcVFeI+iKi7fYIn7hpCtCPzs
 88U2vUWHmmO/PBDMDTWLCoo7SlpL5TZJ1lKjuZ3KklMuC8y06oFwtAZtFltAQkUl/AxZAEtjLo=
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id
 ffacd0b85a97d-38bf56555f4mr9876145f8f.5.1737368936321; 
 Mon, 20 Jan 2025 02:28:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxFFBGFx4D+AZx5VIYCzfD8Wpq5RM+pqhZmgTNs6PTFVl2ZafB0RthPt6P9ArRgfsFy+NorA==
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id
 ffacd0b85a97d-38bf56555f4mr9876131f8f.5.1737368935948; 
 Mon, 20 Jan 2025 02:28:55 -0800 (PST)
Received: from lab.hqhome163.com ([81.57.75.210])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4389041f610sm132966755e9.20.2025.01.20.02.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 02:28:55 -0800 (PST)
From: Alessandro Carminati <acarmina@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jan 2025 10:28:31 +0000
Message-Id: <20250120102831.63646-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fWBAC2oQG7tob79vyu3ibwRJcObH2jECS3_PnE7Ty1Y_1737368936
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] sched/starvation: Add disclaimer for
 virtualized/emulated environments
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
Cc: Alessandro Carminati <acarmina@redhat.com>,
 Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch adds a disclaimer message to the starvation test case, warning
users against running the test in virtualized or emulated environments.
The test produces expected results only on bare-metal systems and is prone
to failure when executed in non-bare-metal setups.

While detecting virtualization or emulation is possible in some cases,
the methods are unreliable.
Rather than attempting to prevent the test from running in such
environments, this patch provides a warning to inform users of the
limitations.

Change:
- Added a TINFO message to notify users that the test should be run
  on bare-metal systems for meaningful results.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 testcases/kernel/sched/cfs-scheduler/starvation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index c620c9c3e..b779a5f0a 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -115,6 +115,9 @@ static void setup(void)
 	if (tst_has_slow_kconfig())
 		tst_brk(TCONF, "Skip test due to slow kernel configuration");
 
+	tst_res(TINFO, "This test is designed to run on bare-metal systems. "
+		"Running it in a virtualized or emulated environment may produce unreliable results.");
+
 	tst_set_runtime(timeout);
 }
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
