Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E98C433FE
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 19:43:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEB423CD753
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 20:43:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B1703C8F97
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 20:43:32 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 85E53100053B
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 20:43:32 +0100 (CET)
Received: by mail-ej1-x631.google.com with SMTP id kt23so49671462ejc.7
 for <ltp@lists.linux.it>; Wed, 09 Nov 2022 11:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqAyRYap1IuifDigw8meOGBNMOcGR0/+k5/fsEgHuG0=;
 b=iu7UpojlNdSFhTCJbC4mNNcNdxcKxfQJcBMCgj6rU+F/hI7GL7cKkpxOXktgOYt4e3
 2+/GjcZDVzBmG/8aATSJJCcU4TiAJV5h+OZkAOxLuP/Kvn4uNxpAMhTdv/L7ZA6Tpiou
 ++ng8Ai4QrWxKaHgX19L0onHxIXTVekCoVR1a4CrRPvhKpdofK11EboKT8PmwEU5+ygD
 XJbE0Z1Q0JUazcJIBOrALmxa2y6j/wHZ9Zy+z4wrAoTxeLcU2xGdi5b3ouycp1phAdTJ
 hjEYeR8dBiZDNaKS186+wm6CXegwg9l+8KJTVguHELfhbNtOrLHMGGhrvNZU6L1op/oC
 rbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqAyRYap1IuifDigw8meOGBNMOcGR0/+k5/fsEgHuG0=;
 b=6PJ0FiL1OFiqjSmuCjvHsi08r2lhfQqXcLrOYEaDEx23xcI5Y6ozBGvq+6QlIwRBw7
 sEgidbcpkXCpRt7OPPlk0kzL2O9qVGkFH4yuOCEjFiEjrvWejCdEY9ijll1Nz2y+Lo1n
 mKx6FlFS1cjMFPSgWOS2hJzOAskUIopDtCerUoVPaBG5uS8OktN+lUrev5BqmE3b+jyi
 tEetchOgQThrTP3+z0g94GTLOG2Rjesx+uFw17IF9b6nk/BW3dgzqzvkKhN0WZff+gyM
 zeaQ/2/CLVzi41vCx+7Wh6NYVsgEVlZqJKqAAneZ1EXqUUzimgmNrJb6SFwDF7d1qRE6
 DKwg==
X-Gm-Message-State: ACrzQf2bfXcjpTSgqz9z+TvRVpeLJ2LYzjjjSsGXUrHFDS1y91SP8PHx
 Y3ehtvl01Ak0p+SZlGtr4BbLa3g6Lmbs4g==
X-Google-Smtp-Source: AMsMyM7ezmbYC0qD/si8g61RI5U4SWMpdNReSTFGFYZ1JpL+Qb2f3W3YzZH67/LW340S620PPXAvBQ==
X-Received: by 2002:a17:907:2c44:b0:7a9:6e50:4c42 with SMTP id
 hf4-20020a1709072c4400b007a96e504c42mr57234936ejc.768.1668023011625; 
 Wed, 09 Nov 2022 11:43:31 -0800 (PST)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 z23-20020a170906075700b00780b1979adesm6170126ejb.218.2022.11.09.11.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 11:43:31 -0800 (PST)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  9 Nov 2022 19:38:17 +0000
Message-Id: <20221109193819.875478-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <877d05wxwe.fsf@suse.de>
References: <877d05wxwe.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/2] tst_find_backing_dev: fix stat fails /dev/root
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

This version fixes:
* dirname can modify path: as suggested in the review a new buffer is
reserved in the stack and the path string is copied there.
* Secondly ioctl_loop05 passes the path to an image, but the self
test in /lib/newlib_tests/tst_device.c passes the mount point. I
didn't notice this in the test, however I fixed this case. In place
of trying open the file as suggested I preferred to use
S_ISREG(buf.st_mode) using the stat data already present.
As side note, since the /lib/newlib_tests/tst_device.c depends on
mkfs.ex2 external executable, its results depends on the mkfs.ext2
implementation. Using the busybox mkfs.ext2 implementation the test
fails out of the box since a problem with the loop block size.
* TERRNO flag missing in the error messages fixed.
* formatting errors fixed .
* else statement bracket indentation have been adjusted.




Alessandro Carminati (2):
  tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent
  c-test-api: Documentation updated

 doc/c-test-api.txt |  7 +++-
 lib/tst_device.c   | 95 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 71 insertions(+), 31 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
