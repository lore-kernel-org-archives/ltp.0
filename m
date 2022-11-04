Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904E5C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:09:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFE4D3CB32F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:09:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FEC93CB475
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:12 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 77FE710009FC
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 05:47:11 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 n39-20020a05600c3ba700b003cf71011cddso4631668wms.1
 for <ltp@lists.linux.it>; Thu, 03 Nov 2022 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBEQIbfLD+aSX7lPWENOsKWDrVUCkB+RxRmDXWsk2/g=;
 b=G+XYjVaFSWiI/C/rgC2TK51LsLYX4sjUcNZHvRy/hVeBTUQ5KZybokQ9SFJVYkdON5
 WburcnJCx+/L69EvbEmr5fjSmHvLJMeW9zuIa4w1ezRjNPjmktQHRmhU+gDX+H34+yPU
 ac6QPkTMRaxeynY/3RO7+31tgTzFzhvU1lwgFn57+r/4YhdILA/up0ORlGXpqg9Yimb+
 ssjpyeaNJkmGBqBGREbDwwc7wj/IPoXu5xAZ6tSFsdK6nwm501kplqRhkNQ7mp5mdY4x
 6RxJVTfZcJJwjvqavmoeyUR9mq2fU6BYy7mhhBMJ8fhQHCG15a3wouIokUwDTwb2PWhR
 7OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBEQIbfLD+aSX7lPWENOsKWDrVUCkB+RxRmDXWsk2/g=;
 b=i/jcKkA2CEYtD2Akp8bffp1VFMapO4M9ppm5ZcqI9Ma31SvsHRqPYG8TKNAqwjQKYY
 sFq/7z2Cw67ccFBMj89QxMSvjHlCmyai22TEq3Gyldfs/fjRVlQFWM9riZ7Ba9Qr8ft/
 XyD9SH7mp0El19e0m99VXyTWGjCnf+uQhfLmi2Bs0M5+EB125A7YCiZWb6kP0E6pAwyH
 ZbuteO8itSKTAJpxEqs9OLPYmMW2j0HTrNY5RnbwEROoZhNzkprCR99ln1F0fzH0cuD8
 KWFVf7MPOsJn4+kJlGjkNFsOKMXyJoO8Aq2DiQrwYTpWvwrf2ZR3ij/BSRDFF1I0sfmO
 9q3A==
X-Gm-Message-State: ACrzQf1NA+14VypSRCPnhcPO8Xs4qouiPf8tmNZEjcYe28O5GsAoCKYS
 LZ3AZqjZ94ObWcG/2uupDMgHwn/5i1VfQg==
X-Google-Smtp-Source: AMsMyM677Svr3W/A9eqtISP4/k+XiyLoAxEXAYrM8a0E1SGaqIZgZFWot9CoxekEuk2msou6U2P5FA==
X-Received: by 2002:a05:600c:1c1e:b0:3c6:fa3c:32a9 with SMTP id
 j30-20020a05600c1c1e00b003c6fa3c32a9mr31911535wms.203.1667537230482; 
 Thu, 03 Nov 2022 21:47:10 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 h19-20020a05600c351300b003b4ff30e566sm9583599wmq.3.2022.11.03.21.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 21:47:09 -0700 (PDT)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 04:41:47 +0000
Message-Id: <20221104044149.655317-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8735b0jos5.fsf@suse.de>
References: <8735b0jos5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fix tst_find_backing_dev adding BTRFS support and
 /dev/root missing case
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, rpalethorpe@suse.com,
 acarmina@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Richard,

Thanks for the detailed review.
If in the future I want to contribute more to the LTP project, I need
to provide myself with a CI pipeline like yours.
I appreciated the review that was very detailed, but I couldn't address
a single comment.

>> +		if (!ioctl(fd, BTRFS_IOC_FS_INFO, &args)) {
>What happens if the test author allows this function to be called on
tmpfs, rootfs, etc.? Or if the FS is valid, but has the same issue as
BTRFS.

I have gone thorough all the file systems supported by LTP at this stage,
and I noticed that BTRFS is the only file system that owns this
singularity.
In addition to this, I also dared to assume that if device major number
is == 0 then the test is facing the BTRFS.
This assumption might not be true in general, but I tested it to be
true in the test supported file system.
Is your comment referring to this?


Alessandro Carminati (2):
  tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent
  c-test-api: Documentation updated

 doc/c-test-api.txt |  7 ++--
 lib/tst_device.c   | 87 ++++++++++++++++++++++++++++++----------------
 2 files changed, 63 insertions(+), 31 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
