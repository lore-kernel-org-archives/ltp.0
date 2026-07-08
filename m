Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFB7C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783501974; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=rBpsHUQ/BY9ZVRBG2Ae0EhFcYllAQ17sNK2RygVI1as=;
 b=eDFDYyfig9P932ILBK8uyiqJn8qUHpvAAiMP2CzggiC2xJsB0sKIfnzpppuwMPEn1gALQ
 a6LEYXbDYaWzdvPN2iBo63VUxF/+b33j/3qxOUmTZ+MricHTooDYdzAJaXAMmwrzCGnAh2u
 ZFj/pi+nMOu0NPRRLC/XdIHO80jOG1g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E07303E2A0F
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 11:12:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55EEF3E29AF
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:11:58 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF6ED6002F4
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:11:57 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so1496105e9.3
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783501917; x=1784106717; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F5/5IgIFcxTJ8C2rGDfm9J8pjHPIe+EYyzg/2HnWDrc=;
 b=Ns2KNRsW4Mg7GV3D0AdlGLNFMPQR3rfy2/Y67FtioBOvmfR/pMggJ4/b3wOaT07GO+
 iO9nZtHzEA8eVMXYon+o4VlvdDJh/eohGqOSCCYehcjpZ5NT2U4la03LqWAk8i9X6VID
 Uzx2ekXcJEFFoVTgHqoP8gzbCPY962HLGZ2wjS7pY+5veRAJWOH2OdyqVnUVI/fyOv6h
 paZgkyApGnB/cWRUfML3UggsalGIkBB0e9PmbykNsTPkt44O/IdbDNEMXldplDXjLaWl
 YuGlRixu119RW1+fB8GI8Xd2aCMTTBD9fsjiggKOvUjaBxvGGLRImyKPm7JwIei3wASt
 K9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783501917; x=1784106717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F5/5IgIFcxTJ8C2rGDfm9J8pjHPIe+EYyzg/2HnWDrc=;
 b=o/wAdO2fjdHuUazgYecs5WwX13QBkjeQEeBQlawxJaBpQUC+TJjEwYUBFLCrtEYbCg
 9VhuW2Ue7Cw/0GKXWZ0k4huzkm5Oaxd4Kz2byuvClIx3nLD2Srfr2TifpW15ZKX9T2sQ
 6ZQ4QpcZa5FtSlChAzTaruHF91wdDxy/mEPHuIgvov1mywIRrD3IgcJOe9+m5ZGwQNco
 nJ9YfA7XsZ5eIOITRFzR1FVwKbOQTtaG50vDpiqSXYk0WaHCwQj8js325r4tdOx7czSH
 3T3d3s1RstMCJ44WDBGMkU/os+eoLjhmXtKuJYJNiIc7BJp86hHpIP9keX25IODQ6rRZ
 8njw==
X-Gm-Message-State: AOJu0Yw8TkxM6zWUcigDQ85FYWqqOSqIpkcb8G7XfNZLz18Q4cy3fVqA
 8SEca81bfo/7qMFc3Nv9zHkpSxjyMFZVNpVyPNQVrUtzzy6Kr7TPuZ5YPYvMLHXXB1U2E/ZoAcR
 mTOTA3sw=
X-Gm-Gg: AfdE7clIsA9aGCsax5K4StKSHmj466xIv8cDwwXlcJZIdKHEC2PECdNgpeuuEtgN6/k
 GWC0ZL+hlopLWhMbY6XHYUaMtW3XCzoSn4pOzlVJm98FM9ukwp6t732RLX7OYHrVc/puY2/wRls
 zlpHSOkZS+eIED7U+DHQwPCKjOVsf8Pm28a1F2iHwZSeAK+hz/Ox5J8VbNutV3r3z0S6PJPN5bE
 2enHmTUOSfvLyMdMCLQ5t1ADwZurdTe3yV0C+tO2nOPMzk8lQ5SwGsKpdC+86WclB54Kg4JrgE2
 s2gfgZYsCw9KVVaQe/7siQ5f9BwZ+5pq979MuyzddRNjr542Syp+VBHQUVa2c/yWxErjxW9VxXO
 +NqGNW0F2+h+RXUBPq2evTWLN2zvwsSy5pSrzvxZy477oJVqb0IzXJuK6bbPJikoinpi1asP8kD
 8=
X-Received: by 2002:a05:600c:548f:b0:493:df44:2342 with SMTP id
 5b1f17b1804b1-493e6831661mr17625105e9.5.1783501917267; 
 Wed, 08 Jul 2026 02:11:57 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f4e3afsm143637515e9.7.2026.07.08.02.11.56
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 02:11:56 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 11:11:52 +0200
Message-ID: <20260708091154.999385-3-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708091154.999385-1-avinesh.kumar@suse.com>
References: <20260708091154.999385-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] syscalls/cachestat01: Drop stray newline in
 tst_res() message
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

tst_res() appends its own newline, so this prints a blank line.

tst_test.c:1303: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_cacmJmF9g/mntpoint fstyp=ext2 flags=0
cachestat01.c:78: TINFO: Limiting num_shift to 3

cachestat01.c:36: TINFO: Disable file synchronization
cachestat01.c:37: TINFO: Number of pages: 1

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/cachestat/cachestat01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index ca2c2864a1d1..7cc72cc1bf21 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -73,7 +73,7 @@ static void setup(void)
 
 	for (num_shift = 0; num_shift <= 15; num_shift++) {
 		if ((1lu<<num_shift) * page_size / 1024 >= tst_device->size) {
-			tst_res(TINFO, "Limiting num_shift to %i\n", num_shift);
+			tst_res(TINFO, "Limiting num_shift to %i", num_shift);
 			break;
 		}
 	}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
