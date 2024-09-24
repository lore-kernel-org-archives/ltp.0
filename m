Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07850CF9C6F
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 16:00:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03AB03C4C7F
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 18:00:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E05053C02E4
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 18:00:37 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 152F81A01071
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 18:00:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAF7D218EE
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727193635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LP/nac/Dxlr27Eeei7/8xqXVZdtOPKLDy0KeeL/RjBM=;
 b=MXEZMzPV9BKOdQBakaS41Dr9Xa9gDfEv5a9z71WbDvIC9FqippdLDcwSygLJvi8Z4Hv2hB
 J0NGtM7kykJ/B50jvEXMcfDhU/H+HVEM18gFCVsQQni6GCqt226SwSJYsKhMrYF1aXj3sS
 G0K99F5ADqx4tfgbPKjuBJXzgNQXR1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727193635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LP/nac/Dxlr27Eeei7/8xqXVZdtOPKLDy0KeeL/RjBM=;
 b=Q4mxgDzGIXV5C28MB29aIPGkmeI9KQjeXXkKNEE8rdG6UV9oiJ0oa+v2sHieZ8CqEU04+7
 FOgXwuqEPIIg5uCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727193635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LP/nac/Dxlr27Eeei7/8xqXVZdtOPKLDy0KeeL/RjBM=;
 b=MXEZMzPV9BKOdQBakaS41Dr9Xa9gDfEv5a9z71WbDvIC9FqippdLDcwSygLJvi8Z4Hv2hB
 J0NGtM7kykJ/B50jvEXMcfDhU/H+HVEM18gFCVsQQni6GCqt226SwSJYsKhMrYF1aXj3sS
 G0K99F5ADqx4tfgbPKjuBJXzgNQXR1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727193635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LP/nac/Dxlr27Eeei7/8xqXVZdtOPKLDy0KeeL/RjBM=;
 b=Q4mxgDzGIXV5C28MB29aIPGkmeI9KQjeXXkKNEE8rdG6UV9oiJ0oa+v2sHieZ8CqEU04+7
 FOgXwuqEPIIg5uCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2EA413AA8
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 16:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EK9XLyPi8mZgBQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 16:00:35 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Sep 2024 18:00:27 +0200
Message-ID: <20240924160028.67124-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fallocate05: Allow ENXIO error from lseek(SEEK_DATA)
 on empty file
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

Some filesystems release deallocated blocks in larger chunks.
On these filesystems, the whole test file needs to be deallocated
to allow the final write to pass. However, lseek(SEEK_DATA) may
return ENXIO error if the entire file range from offset to end of file
is one large hole. Allow ENXIO error in this special case.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/fallocate/fallocate05.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 732a2f15d..b4350c865 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -154,6 +154,10 @@ static void run(void)
 
 	if (TST_RET == holesize) {
 		tst_res(TPASS, "Test file data start at offset %ld", TST_RET);
+	} else if (TST_RET == -1 && holesize >= bufsize + extsize &&
+		TST_ERR == ENXIO) {
+		tst_res(TPASS | TTERRNO,
+			"lseek(SEEK_DATA) failed on empty file");
 	} else if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "lseek(SEEK_DATA) failed");
 	} else {
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
