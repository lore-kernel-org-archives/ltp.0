Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA63C6379F
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 15:11:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAC313CBE79
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 16:11:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 563943CBE0D
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 16:10:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F9811000D0D
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 16:10:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 621BE22461;
 Fri, 17 Feb 2023 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676646642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+ZLG2hdvjDLe96GWS/U2zoglBW4309W9TUqaRRdKj8Q=;
 b=o9qNdiawzY7gBhz/tK1NcNUFWhF2YwSXwUiAGm2C34umwQ5RimWGYlZzytXvfrN8JraMx/
 yOcB1xH9pyC5QUvFxQRr4AHJOzip9hP0Rw8cjj7iEqA+wDqc4gix8sMe1SWKU1NQALiG9C
 quLGvpEB4JdjwW93GhPrkND09cVFNy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676646642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+ZLG2hdvjDLe96GWS/U2zoglBW4309W9TUqaRRdKj8Q=;
 b=AZRncG6M1MzE61GfKYWZFIYpzVbZUj50a4f77fCOV6nm+rfz+FE9xZHULAJhI1dtGgSrC+
 ziEHTMj57bG48yCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6F2D138E3;
 Fri, 17 Feb 2023 15:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IKL2NfGY72MSMQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Feb 2023 15:10:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Feb 2023 16:10:34 +0100
Message-Id: <20230217151036.10295-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] tst_net.sh IPv6 sysctl fixes
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

NOTE: previous version:
[PATCH 8/9] tst_net.sh: Harden on disabled IPv6 via sysctl
https://lore.kernel.org/ltp/20230126215401.29101-9-pvorel@suse.cz/

Changes v1->v2:
* add check for net.ipv6.conf.all.disable_ipv6=1 (first commit)
* add net.ipv6.conf.$iface.disable_ipv6=1 check also to tst_add_ipaddr

Petr Vorel (2):
  tst_net.sh: Detect IPv6 disabled via sysct
  tst_net.sh: Detect IPv6 disabled on interface via sysctl

 testcases/lib/tst_net.sh | 72 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 5 deletions(-)

-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
