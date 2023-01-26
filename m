Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D2AC61DA7
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:54:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A9703CD352
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:54:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E63393CC75C
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 677F0601237
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D5301F8A8;
 Thu, 26 Jan 2023 21:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fv2+XztDO3Hqb3sxx427w56QMbGSoQoC4gwWrgl6sNg=;
 b=Bl1WgkxTLYKO/4gdDdY1U/5SJYGf3+qwshakFuDh2QMwl1uhxLASDsjzfkVl6cTjQeapcU
 oxKtJJcOoZSEE6DyE+oHN+uNAHXlGu8hBcy+N2eIffgIStlSdRbhTconHnFqzIuN7Yyn9j
 Fd4C/uCozWOXzmgHG5VPs0zbxKKUurQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fv2+XztDO3Hqb3sxx427w56QMbGSoQoC4gwWrgl6sNg=;
 b=VlUKIF3L7voDQBXjJU5TLUOXHlGnsc7N20Dy0jCeeuqMZ5laiAEfhsvy24ccUp62kv+LxU
 Ac8La992GTs3pRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4ADBA139B3;
 Thu, 26 Jan 2023 21:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WUCYDn720mOcYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 21:54:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 22:53:52 +0100
Message-Id: <20230126215401.29101-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] tst_net.sh fixes + cleanup
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

Hi,

first two commits should be merged before release (simple fixes),
the rest can wait after the release.

Kind regards,
Petr

Petr Vorel (8):
  tst_net.sh: Use tst_res_()
  tst_net.sh: Check for disabled IPv6 in legacy tests
  tst_net.sh: Remove unneeded $_tst_net_parse_variables
  tst_net.sh: Remove unneeded $TST_INIT_NETNS variable
  tst_net.sh: Rename function + add doc
  tst_net.sh: Remove unused variable ret
  tst_net.sh: Harden on disabled IPv6 via sysctl
  tst_net.sh: Move net setup into separate function

Wei Gao (1):
  tst_net.sh: Add more tst_require_cmds check

 testcases/lib/tst_net.sh | 148 ++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 55 deletions(-)

-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
