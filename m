Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982CEC61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 23:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787958588; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=1KK/pcFq/yn9aP39hJmTpDqE/FOA0FtdyEcGvAG4Q90=;
 b=Xy4xADylKepD9zin9WEoIfEyk1ATzBXnKCHLjH7482n4WG5CW3B6GV6OMGfcBmobM4FKO
 /V2lAsPqH7tZoXUuD1F2vKEYgk2K2x2pJs9AJnryfS5useJe/ZLs+YRsrgiMmAyPaaJflEW
 QcoAYNG/4lCMpzdOYm2ilKis4wkPFmE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DF7D3E9A76
	for <ltp@archiver.kernel.org>; Sat, 29 Aug 2026 01:09:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8083A3DAFF6
 for <ltp@lists.linux.it>; Sat, 29 Aug 2026 01:09:28 +0200 (CEST)
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F0CE960093F
 for <ltp@lists.linux.it>; Sat, 29 Aug 2026 01:09:27 +0200 (CEST)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so28948555ad.3
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787958566; x=1788563366; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMY+dejJfm1fzNFEaaLTi3QXBYmRJFbUtR4aiOVV6AQ=;
 b=vqXbRcMEifLHv5K5btrbh0ScOcbRpW0Ofu4galU6di4CqukgU/3RrYcop2DgDNNId1
 adcFSelM7h/AYf+PtXsP32gD7exBtW0rS/xdkfxa3L2Kfb/0jsyAhkc68k12i+jSniBr
 78EvcjH/LF26f6OC7WCifG+lE/a7ja/YGBUyVP1guTl6NkJBfyLoBTvtWMQI948oLvT8
 CEsoTR01l8CvRFhIeQUqt3an/Sp1qXVpI5LeTZ/D709DN8ZIOucE5w5o+rByYnp1Z35X
 6FMEJq6/55//2BRWSkanzSEb5i1oL7/I86THdXrEN9/Tk19gXve2I5dLXhJhi6W/WLDY
 wLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958566; x=1788563366;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fMY+dejJfm1fzNFEaaLTi3QXBYmRJFbUtR4aiOVV6AQ=;
 b=lQf7VmzmHy2PDBzYAMirbiPeAaXlaSKTq8Bra5wjEPcivKTWab5yk9EpJ4bOYubc55
 kogsppYG7gFUWCAIhyG+l1qFuW06srym6n1vV+ofxg4buWxQtZcHw7bTFvI8FS/VDuyB
 hK4imnaT79nePTz3+ck7EkmUatF5/SWOUqfl/wD0QdCt2uUo9FA8ZSVshLrqUUNHvW/B
 W/IZ6bmN90soel+0oUb8psR7SGP7ntIGojGVX5+ZoA+EbFrqtrlh1PUHPombionx6C1y
 SCS0pvT8mdWN56ltTEfA20PEyC6SU1bwf/Gjwm4fkASwmOTJTfNSu05UeDoRLr7UWkJd
 i46A==
X-Gm-Message-State: AFuF++l3R5SSWXzziA3NbzwNJUKGmv/Q4m6sX7O49kvsJoY8a83ZsSt6
 7g9BlCBFono+ikCdEedPfBEX1vYIop0oPj+F/7czI0AO57W9nLdtsOBZcKEcP4pT6aPcqzIPYoo
 Pvjc7Lzm/jOSUU7lKcPeSia5kaj/NC6RurtLd/K43AdzGsWQupWwVDyXT6UFUncewKDd29mjUlR
 PHnM141x92Hstx37zhliXxhu9+/A==
X-Received: from plba2.prod.google.com ([2002:a17:903:1002:b0:2cc:8c60:d947])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:234d:b0:2ca:660:b1d
 with SMTP id d9443c01a7336-2d74ddc6daemr167972915ad.11.1787958566035; Fri, 28
 Aug 2026 16:09:26 -0700 (PDT)
Date: Fri, 28 Aug 2026 23:09:24 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828230924.2635548-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cpufreq_intel: Check for per-CPU online file presence
 before reading
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, Grzegorz Jaszczyk <jaszczyk@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Grzegorz Jaszczyk <jaszczyk@google.com>

In setup(), the test assumes that all secondary CPUs (cpu1..cpuN-1)
expose '/sys/devices/system/cpu/cpu<N>/online' and attempts to read
their status using SAFE_FILE_SCANF().

However, on systems where CPU hotplugging is disabled (e.g. kernels
built without CONFIG_HOTPLUG_CPU or platforms where CPUs are not
hotpluggable), the per-CPU 'online' sysfs attributes are not created.
Calling SAFE_FILE_SCANF() on a non-existent file results in ENOENT
and breaks test setup with TBROK.

Check for the existence of the per-CPU 'online' file with access()
first. If the file exists, read the status via SAFE_FILE_SCANF(); if
it does not exist, assume the CPU is not hotpluggable and is
permanently online.

Signed-off-by: Grzegorz Jaszczyk <jaszczyk@google.com>
Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/power_management/cpufreq_intel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/power_management/cpufreq_intel.c b/testcases/kernel/power_management/cpufreq_intel.c
index 11896258e..a2a3f3475 100644
--- a/testcases/kernel/power_management/cpufreq_intel.c
+++ b/testcases/kernel/power_management/cpufreq_intel.c
@@ -94,8 +94,16 @@ static void setup(void)
 		int tmp;
 
 		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", i);
-		SAFE_FILE_SCANF(path, "%d", &tmp);
-		online[i] = (bool)tmp;
+		if (access(path, F_OK) == 0) {
+			SAFE_FILE_SCANF(path, "%d", &tmp);
+			online[i] = (bool)tmp;
+		} else {
+			/*
+			 * If the 'online' file is missing, the CPU is not
+			 * hotpluggable and is permanently online.
+			 */
+			online[i] = true;
+		}
 	}
 
 	SAFE_FILE_PRINTF("/sys/devices/system/cpu/intel_pstate/status", "active");
-- 
2.55.0.897.gb25b4bd76c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
