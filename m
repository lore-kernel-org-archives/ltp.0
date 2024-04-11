Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB16BC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:34:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 289CD3CF856
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:34:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6B923CF820
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7F25B1A027C2
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8A08375AE;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XvfmR4pZ/WY+PMoWcqB+3fDXVXuSjFtOek/0LzSzFw=;
 b=C5b4IsgT0YCBmZ44NzsMCJL8oqAV46bBqOc5+cTpHp4pOcH8RvJNJftqStNG4P8hB0qFcM
 oab2uHh8pUqeCmsXt2cN0ByyYln2sjOI4OwsfstNd8pteS+WjHvDiRj+PeEijkyhVFDMKR
 fBcrYxTm/iYnFZjSbJMtRlaG3ff/TYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XvfmR4pZ/WY+PMoWcqB+3fDXVXuSjFtOek/0LzSzFw=;
 b=7NEpnIkjyBMC7rDPKBMxdXvWfsprCSLmqZMDJulted8CEQUrXQYKCtKfthTX7oFcc4Tk/0
 GjqQg7CmAIjjf7DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C5b4IsgT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7NEpnIkj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XvfmR4pZ/WY+PMoWcqB+3fDXVXuSjFtOek/0LzSzFw=;
 b=C5b4IsgT0YCBmZ44NzsMCJL8oqAV46bBqOc5+cTpHp4pOcH8RvJNJftqStNG4P8hB0qFcM
 oab2uHh8pUqeCmsXt2cN0ByyYln2sjOI4OwsfstNd8pteS+WjHvDiRj+PeEijkyhVFDMKR
 fBcrYxTm/iYnFZjSbJMtRlaG3ff/TYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XvfmR4pZ/WY+PMoWcqB+3fDXVXuSjFtOek/0LzSzFw=;
 b=7NEpnIkjyBMC7rDPKBMxdXvWfsprCSLmqZMDJulted8CEQUrXQYKCtKfthTX7oFcc4Tk/0
 GjqQg7CmAIjjf7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8773A1386D;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yCtQIAf0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:06 +0200
Message-ID: <20240411143025.352507-13-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.51 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; BAYES_HAM(-0.50)[80.00%];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: A8A08375AE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 12/31] semctl06: Remove UCLINUX
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ipc/semctl/semctl06.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl06.c b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
index b00ee89d2..b8734c2fa 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl06.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
@@ -44,11 +44,6 @@
 
 #define DEBUG 0
 
-#ifdef UCLINUX
-#define _GNU_SOURCE
-#include <stdio.h>
-#endif
-
 #include <sys/types.h>
 #include <sys/ipc.h>
 #include <sys/sem.h>
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
