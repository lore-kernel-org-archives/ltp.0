Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D0DC46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 08:55:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79C4B3CE4E4
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 10:55:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 346AC3CB08C
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 10:55:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 72E3B1400F93
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 10:55:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B2D31F892;
 Mon, 18 Sep 2023 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695027305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LVkC9Z4Msl9PxMkjfupu0Kgacy6XV1++Aj/NlBj+/Ss=;
 b=iZHhbcQWm2/lgGJV8lGRt5+d+6ysLbYOZ33Ew/sgNW75obdszuh/NJu4QgsD5zkTqsyShF
 HbZNxOl4l8AWqQajJ7ontF6DD5ZOyOcswC++siY4vxgwIafjoYAK2Q6rLQ8kgWmJtBnabt
 xPt4cjCxAHi+/MWYBJ9rn3C3zAB9O2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695027305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LVkC9Z4Msl9PxMkjfupu0Kgacy6XV1++Aj/NlBj+/Ss=;
 b=7ToBoqkMF4mi7EAqGj/XaWlYpzayqaMqFZ5yda0mrJjVlSUp21r5hgMbW3XJpjHJd4GXAM
 lPveXBCZRLt+J0BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4757313480;
 Mon, 18 Sep 2023 08:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JpgPEGkQCGXlBQAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 18 Sep 2023 08:55:05 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 10:55:00 +0200
Message-ID: <20230918085502.17091-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Improve ioctl02.c
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

Improve ioctl02.c

Marius Kittler (2):
  Refactor ioctl02.c to use the new test API
  Make checks for termio flags more strict

 testcases/kernel/syscalls/ioctl/ioctl02.c | 394 ++++++----------------
 1 file changed, 94 insertions(+), 300 deletions(-)

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
