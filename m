Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0D1C5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 03:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786333186; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=lzqbNuV0f2z2f/s2oTpXvPv5AisDTRWfA828e2EX7Ow=;
 b=n+dyvHMUIaZhFpDDvvMi0lY01VToOklYfYYRtyopZUpD+ap1eHMitkMf2suZEPLtRCP3w
 rD71fhZh0kZYLF0prFj/8Ey3WSROZ9E56Yg87pt+/yd7IldLKNpiPJDD5tbbllf7IUG+Ojb
 3okiHUD5Dd1wTO481H/cF4msO8g56A4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C2D53CB3D1
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 05:39:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 727C93CAE6D
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:39:25 +0200 (CEST)
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55FEA1000485
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:39:25 +0200 (CEST)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so28223255ad.3
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 20:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786333164; x=1786937964; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aCeGNklGf/ca7cDLVo7CpJHbCCHAYPDiyE+iBFoyz6w=;
 b=XNWjjH0FmF2CQgy7/gY9Pntr/+cuGf3HkKVkkoEyarlFsW+pFdhiTyWa+88jadw+74
 sJHqWfgHoURJNst2bYj5z6Bm0WRNNxqB3WFdhew0heJ+vFuofcEp4vSLJrBtwJzYJDct
 uSNmHOvV/Ydqh7xw8lsIPrNUDkYG0xySu7JmwLI+wH0x4iZJs/IXBVRkMx3mXeCJ7QZ3
 y+3r17Z6L01lbV8YPqtLr4RQu6cRYk9BpVCCRatCkn0Axt7+vGqmv2cOoMAAuJ208xyn
 vRxxLEXCP+cQAP0d55ExzwuAeSIKXmjYdtwIyQNRlMECMcOeBLsoKyZ8TAAxdjQpFnIE
 l0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786333164; x=1786937964;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aCeGNklGf/ca7cDLVo7CpJHbCCHAYPDiyE+iBFoyz6w=;
 b=lnw5HE++Y+HDO60JXfGNwYOGGSuOeBLO9MdmCWzIDqZ7NKADg+szlcF3D3Rtw29XrX
 L7QHrqYnJzevOeQWoLXWLtACIfIpnjnBu6m1KFCF3ywUloWPm+CDNSYoj1B/MH/+3unq
 z2iQJxsicCIiaEJQqVzNtK7Anst46Bv4JiKZ4wRIuEieN52RqRfn8DhwjoEfXl4bH4wx
 QcqYf+iqVponbgJFwIXZhEIqxbrcNrceX2toM4IPY/WSqv+bd2f9VJiMgrDYKF8ZMq2Z
 RL5LrdbxzB0HDT4VJusatbVSPMjmDg7UHIoucI6P5Vu4/+3jYMdcxXT4fcdeGEb36R8l
 Mmeg==
X-Gm-Message-State: AOJu0YzKwYPCQiNX5uiEpPEFTsyo8jNOfLj8YeYAkiWQ/+nwz01aiZbZ
 yjuM5zkceyr6hY4pRwouC/OULYTFs+gQSiRQGzbXZFbPJOyFsUNDwYeAlUPr+BGc43Q2HIF6ZHP
 OjY1olwYDj6UkomZXDkKhIOSuXmR60TLiegCtlHSPC5rIzURe+ZK/R5GTHP1UGeVVq4hVP4MQey
 TFQoXcF0u1MwlBwtYKvgwnnqPvCQ==
X-Received: from pjli2.prod.google.com ([2002:a17:90a:7e02:b0:38e:6573:9389])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e46:b0:38d:b36e:9813
 with SMTP id 98e67ed59e1d1-39282430494mr17796316a91.11.1786333163337; Sun, 09
 Aug 2026 20:39:23 -0700 (PDT)
Date: Mon, 10 Aug 2026 03:39:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810033921.1694744-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] controllers/cpuacct_task: Increase execution time to
 100ms
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
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test helper cpuacct_task currently runs for 10ms (virtual time)
before exiting. On some systems (e.g. fast virtual machines or under
heavy load), this short duration can lead to 0 usage being recorded in
cpuacct.usage cgroup file due to timing resolution or scheduling delay.

Increase the execution time to 100ms to ensure that the process runs
long enough to register a non-zero CPU usage, reducing flakiness of the
test.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/controllers/cpuacct/cpuacct_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_task.c b/testcases/kernel/controllers/cpuacct/cpuacct_task.c
index 677d6d401..9519bd9b3 100644
--- a/testcases/kernel/controllers/cpuacct/cpuacct_task.c
+++ b/testcases/kernel/controllers/cpuacct/cpuacct_task.c
@@ -62,7 +62,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	struct itimerval it = {.it_value = {.tv_sec = 0, .tv_usec = 10000}};
+	struct itimerval it = {.it_value = {.tv_sec = 0, .tv_usec = 100000}};
 
 	setitimer(ITIMER_VIRTUAL, &it, NULL);
 	for (;;);
-- 
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
