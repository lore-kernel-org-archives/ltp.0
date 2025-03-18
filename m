Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB37C282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 11:46:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F8A73CABD3
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 12:46:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4F7E3CAB21
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:46:28 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B78341000944
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:46:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5AD691F807;
 Tue, 18 Mar 2025 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742298386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I1sA42YqNZIZbPcc1d/yDTNTP6HPovlnj+0CNo5imoo=;
 b=Tayq1NrT6CpY4Dfh4NNuash+9CDlpz/snsLVMfamWnFUmri8XuHUBUuzkoIjFS7jj8M2P6
 vs4SlirkZaASkKaJiuo1XbxxYk5vxEsowVbuouMzUfbIVvCNpnNHApw6f55jaD+xG4Ml4y
 eY1a7moPJkU2ojCKVpb40guzZCS8Zgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742298386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I1sA42YqNZIZbPcc1d/yDTNTP6HPovlnj+0CNo5imoo=;
 b=B0wP6yBpM/+HYl4aS2mVifbL28yapF185vNAEGaRVWR4VRXFJHnEosY8LRMfEyN/CCGJG9
 OT8o5eMQ/OiheODA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Tayq1NrT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B0wP6yBp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742298386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I1sA42YqNZIZbPcc1d/yDTNTP6HPovlnj+0CNo5imoo=;
 b=Tayq1NrT6CpY4Dfh4NNuash+9CDlpz/snsLVMfamWnFUmri8XuHUBUuzkoIjFS7jj8M2P6
 vs4SlirkZaASkKaJiuo1XbxxYk5vxEsowVbuouMzUfbIVvCNpnNHApw6f55jaD+xG4Ml4y
 eY1a7moPJkU2ojCKVpb40guzZCS8Zgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742298386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I1sA42YqNZIZbPcc1d/yDTNTP6HPovlnj+0CNo5imoo=;
 b=B0wP6yBpM/+HYl4aS2mVifbL28yapF185vNAEGaRVWR4VRXFJHnEosY8LRMfEyN/CCGJG9
 OT8o5eMQ/OiheODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F69A139D2;
 Tue, 18 Mar 2025 11:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vznWChJd2We8UAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 18 Mar 2025 11:46:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 18 Mar 2025 12:46:18 +0100
MIME-Version: 1.0
Message-Id: <20250318-fix_mmap_build-v1-1-648618f1df95@suse.com>
X-B4-Tracking: v=1; b=H4sIAAld2WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0ML3bTMivjc3MSC+KTSzJwUXRNjEzNDA9NU4yRzMyWgpoKiVKAKsIH
 RsbW1AJwV4O1gAAAA
X-Change-ID: 20250318-fix_mmap_build-4346105e3b76
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742298386; l=846;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=tG46KKaDje5XVni24peBzb2JM5IFxPPgqpatOYt9JgU=;
 b=478tmBY7su4feaWrlbe3XEwRUPmbhto9VpX1Q9PqzaMBczGoO1T7v6WoJ5p/tZiWuksje/L0O
 OfVszpG/ihiDMDThxWMV62zqqeduGd44xQdRXLAk3imBCFQkAbNOoMP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 5AD691F807
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix mmap17 build in older distros
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Import lapi/mmap.h in mmap17 to define MAP_FIXED_NOREPLACE.

Fixes: ac2f330fa ("Cleanup mmap17 test")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap17.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/mmap/mmap17.c b/testcases/kernel/syscalls/mmap/mmap17.c
index 1d10676379a102750ab7dbb73dd3ccd398112129..84e738d644a974ff26bb7954ac100e8e8cfe31d8 100644
--- a/testcases/kernel/syscalls/mmap/mmap17.c
+++ b/testcases/kernel/syscalls/mmap/mmap17.c
@@ -11,6 +11,7 @@
  */
 
 #include "tst_test.h"
+#include "lapi/mmap.h"
 
 static int fd_file1;
 static int fd_file2;

---
base-commit: 6a1154fbb4ce9cd465a6585da305f9a98a73174c
change-id: 20250318-fix_mmap_build-4346105e3b76

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
