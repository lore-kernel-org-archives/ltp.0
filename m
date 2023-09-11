Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF9CEE7FF4
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 11:32:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61A373CC14D
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 13:32:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 757493CB3AE
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 13:22:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E3ED2001B1
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 13:22:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694431367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=uyE1eip6C/Xy3OnNfClWFuPgCpowCl/hguga/One22Y=;
 b=d9XbKz1F9XbSIu+N9BZDbNqVFqUtc15ENbwLfspyRZeqCUb140Ix+ZycJQpNdLjufnzou6
 5dwJTDHUmbnDWcjgjMlTWOOHQd/NDFjhY6LrEEMCAQnGwMe5K7tucsCp2KYrXY9lvuqyPT
 LillRqQFKr7ZbV7UfJMZlwNPdQYVr2o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-JTUc4N7EMemwvkzy6PC7Mw-1; Mon, 11 Sep 2023 07:22:44 -0400
X-MC-Unique: JTUc4N7EMemwvkzy6PC7Mw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-500b5dbf113so4357102e87.0
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 04:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694431358; x=1695036158;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uyE1eip6C/Xy3OnNfClWFuPgCpowCl/hguga/One22Y=;
 b=t5yl/18Kv3y5rMtPawx7/IZ/LV7hg2ktfwvTsPYUw35YGiWloKvJEW/qZVNP45Lqeh
 NevWY/Js4cjXyMc4jxLydQ2oYNbqCuc6i7HFOkIB3vawKGxzmrYQBa5AU0xUIUor23Nm
 9P8Z+/L8dUGg/i9p0EPlMN8ZGI8GRX1yk2pwb457kzlF2C5zpgfsVAmUk4LSSlvo1sf9
 zpiLSHTjWsRyEp4BaliBGyxh33E8hHK+UBKmy45pfqt2Fq6wZlyg6vZPvVaDRGVVY/oa
 qte2RK7l0EhWv5vsuBM8CjHRXmNyzg6pmDAgK1gMsUwuiEKnec16PIGtb1d7SIi4QUW8
 qPPA==
X-Gm-Message-State: AOJu0YzGeTmO0xJRDKocGQiVuWNbuT0sWCGj4POW1NJdeHgvEs0zft9f
 waYEPByHmQONmFwSD6fMq8dBhx1gD+mxcFbTVMu1cB2k+bC0Q4hs+JoFpZoCbEBVtPUdU8v2ROX
 4Yww4WZTQ2mymz3Qg0+1puoSaJU8coRxrMFy2g3Bg3fg=
X-Received: by 2002:a05:6512:2809:b0:4fb:7675:1c16 with SMTP id
 cf9-20020a056512280900b004fb76751c16mr8414378lfb.49.1694431358297; 
 Mon, 11 Sep 2023 04:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/6PNm6kgKFTXFbTLufh/UieCru5CEJ/v2fk6UaXiJBi+k792bHBj0vLhNleAyv2sf0CA4jxPdfmMCPqFopoE=
X-Received: by 2002:a05:6512:2809:b0:4fb:7675:1c16 with SMTP id
 cf9-20020a056512280900b004fb76751c16mr8414366lfb.49.1694431358014; Mon, 11
 Sep 2023 04:22:38 -0700 (PDT)
MIME-Version: 1.0
From: Shizhao Chen <shichen@redhat.com>
Date: Mon, 11 Sep 2023 19:22:27 +0800
Message-ID: <CADm5pWf=W7vAiLFt4Gx4qGC1qd6WgryUY299yBoFABdKHzec4w@mail.gmail.com>
To: ltp@lists.linux.it, Ping Fang <pifang@redhat.com>,
 Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 11 Sep 2023 13:32:05 +0200
Subject: [LTP] [PATCH] numa01.sh: unset default cpuset awareness before
 verify physcpubind
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On systems with cpu isolation configured (a very common technique used in the
real time kernel), $run_on_cpu may happen to be an isolated core and hence
unaccessible to numactl.

Unset default cpuset awareness with --all, so numactl can use all possible
CPUs/nodes for following physcpubind settings.

Signed-off-by: Shizhao Chen <shichen@redhat.com>
---
 testcases/kernel/numa/numa01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 367813ce9..0181cd8f5 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -183,7 +183,7 @@ test4()
     no_of_cpus=$(tst_ncpus)
     # not sure whether cpu's can't be in odd number
     run_on_cpu=$(($((no_of_cpus+1))/2))
-    numactl --physcpubind=$run_on_cpu support_numa pause & #just
waits for sigint
+    numactl --all --physcpubind=$run_on_cpu support_numa pause &
#just waits for sigint
     pid=$!
     var=`awk '{ print $2 }' /proc/$pid/stat`
     while [ $var = '(numactl)' ]; do
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
