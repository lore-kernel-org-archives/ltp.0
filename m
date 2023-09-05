Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C52C83F2C
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 11:56:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 444493CDF34
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 13:56:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D6EF3CB1B7
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 13:56:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 72E046008FA
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 13:56:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B9E4A21987;
 Tue,  5 Sep 2023 11:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693914970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6jevUJqg+J3Vx1n+FKbsUXuE8TFWEco3zn4Yr+yaNT0=;
 b=OfO2QBeE9FzQkT9qK19HiXKTMxjePsfjE9j5XqZEorZ10JYxxCOCg3sByPta3GhWGQc8OT
 8BgzA7iq3J/3JVBBxekU4Nvp7r8lBmWm6gk4xMEQ8YD3vUGBfo+QiTjoNciYqtv0Xv90fE
 UMCYFprNlJutb3UZlkAIqKbIP6iNnx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693914970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6jevUJqg+J3Vx1n+FKbsUXuE8TFWEco3zn4Yr+yaNT0=;
 b=BULuZSe3vq0ciocMTOih+ZSTuRsq05ERNNwpTgp8uQAYc9TiGoyneJNF2KGM9B/iuFm21H
 SZEnwaAVf5Vf3XCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AE3713911;
 Tue,  5 Sep 2023 11:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KNvGJFoX92QlAwAAMHmgww
 (envelope-from <mkittler@suse.de>); Tue, 05 Sep 2023 11:56:10 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 13:56:06 +0200
Message-ID: <20230905115608.31192-1-mkittler@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Improve ioctl02.c
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
  Use correct binary operand in ioctl02.c

 testcases/kernel/syscalls/ioctl/ioctl02.c | 227 +++++++++-------------
 1 file changed, 95 insertions(+), 132 deletions(-)

-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
