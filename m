Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DE0C5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 02:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786330767; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9Nj5x/lqquw+CNpXNOnZeN4vwylEYvqTST6qRQebzTU=;
 b=e0/EMBhogQzXEgHRX6jsSWuDpfNybESUVSub2sru2RMKgoXMZlEQJTI9Px8DpWh2wvzfV
 O+e4mXaC9EzsnGehq2rcPJNAp3FFQddPx6ZJE1iNvdT/h84p006oy0b9sh3nC4C5yrnNsrJ
 MaGxNz82m5QNZNBm61P0nyNIgSfe9bI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D81163CB468
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 04:59:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 291C03CB432
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 04:58:26 +0200 (CEST)
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9E96F140017E
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 04:58:25 +0200 (CEST)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so38772905ad.1
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 19:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786330704; x=1786935504; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xAxfP2LO7h3ZVJKNrQjInKnmzngI2odAy1GTRe0cRiQ=;
 b=hRUnXzsb5YW+h1fp1kqUv7+IUVLzl+qV5s3bsJekWLrzCNPSR1+BWKyUqEXUvB+HQl
 ofwvJK732p4pRNddYPUcnMoggh9u+jIQy645yGJPrUTWOFC9ZAvlWDBys30y7kgPVKNq
 l+LmKoVPmqSsos1W2Aaiw8Mhkzyy99AOdkixWaILGhlFW4jm1MTF1s4VlombfAd7IqQN
 y6bMW1NfxvxzMNm7Tv+cJwfYJKUSEca0VTvfHNR40Aq/4k/zsRS3quKidnz7c/IhLVYT
 t9B6BDU0ci3qk/EQ7VmSBeH2pTE+3MIlfl8xa9xX//LqfauwxkkLp5NMPYvuAvNaVZCk
 ypaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330704; x=1786935504;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xAxfP2LO7h3ZVJKNrQjInKnmzngI2odAy1GTRe0cRiQ=;
 b=jqGZyDlB/EH2ivkjJrgOGzEX7mRCpDHhDMZxGmMPcg0CqW0kmcjMgyastaobjA7I4i
 yToFVrIz58z5U1sjhm6/VlGc7M8mE82x8tRvZsYm1Gp3uWgaxFfnmmOTHD9XXrkGkn9c
 77P/eJFSXakHcj1hzqJ57XyWp+gW4g3qhLKg3oq2QAkdKXGLvjImhT6sqCbSAZ0tulGC
 hZI1V363QlB4fxJyKsky6AP5ueMcEP5F28PkmzyS174qDSG83iQ/2CYiQz+98fpS+t8z
 OtDmL66S4O4CtoNBpheIj6Ek9XKtbXZmcDSvC0PERoiL1rXrexhap//zlbIoJWqjW8xC
 3LgA==
X-Gm-Message-State: AOJu0YxHoQ+0NZouMB8ZxkQefkmQxhP3H1nU54J441A6EUR4OSXHoRpn
 Nxf73AmkoytqIsxTNKanYuzZUkcXEUcHNYzfZkXwZbNjQniLjO662SS/Y2z5ybR0Yr+baRI/W6d
 GaiXx+iWDTkVY0JWCi784Y4ZjUJO8T3O6cEy98coo1tjtAd2luLmBEmuHAgfOoKwtjG5EViUyn8
 w/PF2X4jSTHbEFyMPgV2EEXxhjkg==
X-Received: from plfh17.prod.google.com ([2002:a17:902:f551:b0:2c7:f626:ec80])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b27:b0:2cf:4c0f:5127
 with SMTP id d9443c01a7336-2d0ca7512c6mr470043155ad.10.1786330703617; Sun, 09
 Aug 2026 19:58:23 -0700 (PDT)
Date: Mon, 10 Aug 2026 02:58:17 +0000
In-Reply-To: <20260810025817.1665141-1-wakel@google.com>
Mime-Version: 1.0
References: <20260807234935.3248935-1-wakel@google.com>
 <20260810025817.1665141-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810025817.1665141-3-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/2] lib: Use backoff polling to wait for loop
 device nodes
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
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On systems where loop device node creation is asynchronous (such as
Android containers or systems with slow udev startup), calling stat()
or open() immediately after LOOP_CTL_GET_FREE can transiently fail
because the device file (e.g. /dev/loopX) has not been fully populated
in time.

Introduce an exponential-backoff retry loop in both
tst_find_free_loopdev() and tst_attach_device() by reusing the LTP
native TST_RETRY_FN_EXP_BACKOFF() macro (starting at 1us delay,
doubling each try, with a base timeout limit of 1 second that scales
automatically with LTP_TIMEOUT_MUL) to wait for the device node to be
successfully populated.

This improves the robustness of loop device allocations on asynchronous
virtualized environments while minimizing unnecessary delays on responsive
systems.

Signed-off-by: Wake Liu <wakel@google.com>
---
 lib/tst_device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 744173ffe..00304711b 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -82,7 +82,7 @@ static int set_dev_path(char *dev, char *path, size_t path_len)
 
 int tst_find_free_loopdev(char *path, size_t path_len)
 {
-	int ctl_fd, dev_fd, rc, i;
+	int ctl_fd, dev_fd, rc, i, path_set;
 	struct loop_info loopinfo;
 	char buf[PATH_MAX];
 
@@ -93,8 +93,13 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
 		close(ctl_fd);
 		if (rc >= 0) {
-			if (path && set_dev_loop_path(rc, path, path_len))
-				tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
+			if (path) {
+				path_set = TST_RETRY_FN_EXP_BACKOFF(
+					set_dev_loop_path(rc, path, path_len),
+					TST_RETVAL_EQ0, 1);
+				if (path_set)
+					tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
+			}
 			tst_resm(TINFO, "Found free device %d '%s'",
 				rc, path ?: "");
 			return rc;
@@ -161,7 +166,7 @@ int tst_attach_device(const char *dev, const char *file)
 			 LO_NAME_SIZE);
 	}
 
-	dev_fd = open(dev, O_RDWR);
+	dev_fd = TST_RETRY_FN_EXP_BACKOFF(open(dev, O_RDWR), TST_RETVAL_GE0, 1);
 	if (dev_fd < 0) {
 		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
 		return 1;
-- 
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
