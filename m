Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41482EB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 09:24:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B75363CF04B
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:24:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38F693CC040
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:24:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8EBBE1A00814
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:24:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D46A22664;
 Tue,  4 Jul 2023 09:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688462671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NImZjySR+eOvulujmy1NrpU6iXw3/Wge1Fwffw19Cf4=;
 b=FPG61jPeOQieRc0SBxcsE9I3vXW9rXs/Sx9O9fnqJehxgnwVL/HUyqCE98UPo77fxkwap2
 ZUCS/yOzN5hqtWp1andpZ/1q1X7j6YjDwPEAYslnbLBUtrQ1Apym8WvMQF9Bd3MwBJUZl9
 BhDwHWt+0287fZWrNTzoqAfxCIldJpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688462671;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NImZjySR+eOvulujmy1NrpU6iXw3/Wge1Fwffw19Cf4=;
 b=q2TbcgmBHhcGuz/ba+8/8D3gBUZAn+z9ASaAIbuqrsG5f1jf9oQ+aR99l9kP8KdzN5yjJG
 KdPEnHq+giaBx2Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AFBD133F7;
 Tue,  4 Jul 2023 09:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id heDaGE/lo2TvSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 09:24:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  4 Jul 2023 11:24:24 +0200
Message-Id: <20230704092424.497903-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 0/3] C API: print LTP version
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

NOTE this is a correct cover letter (I'm sorry for the confusion).
RFC is mainly due first patch.

Kind regards,
Petr

Petr Vorel (3):
  Makefile: Add C header with generated LTP version
  lib/C-API: Add option -V to print LTP version
  lib/C-API: Print LTP version at test start

 .gitignore     | 1 +
 lib/Makefile   | 4 ++++
 lib/tst_test.c | 8 ++++++++
 3 files changed, 13 insertions(+)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
