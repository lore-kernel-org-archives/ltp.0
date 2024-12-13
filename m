Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DBCE7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 22:20:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E89973EB896
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 23:20:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07EC03E9757
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:19 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 67D216008AF
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC4801F46E;
 Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGrabM/RTjYOWG32YCic41PKnBU/k6Nk5QL41lBHGqo=;
 b=WsKHDXunr0pGwiyfDdN0I4Ti56Hhc13TAIfOXhcdDYLqHVb51u9/zyIreO3tc2sa50BWJV
 sHRrDKZUoR72+rf0+gfID0jnXOLscrhpLMXphs1CoQZ2kSf2X/g6qeyL9MkCmzDp2SNaT5
 tg9pLvl0vYMWBVUDQSqf00IhtX1RH0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGrabM/RTjYOWG32YCic41PKnBU/k6Nk5QL41lBHGqo=;
 b=tUHW+Ko4a97J70ValSNk573aKzzga3AjwGdje4o0at3r9RwJYxnixb+xUcbt2UurTma68L
 MpXy0p4ANYDR1JAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGrabM/RTjYOWG32YCic41PKnBU/k6Nk5QL41lBHGqo=;
 b=WsKHDXunr0pGwiyfDdN0I4Ti56Hhc13TAIfOXhcdDYLqHVb51u9/zyIreO3tc2sa50BWJV
 sHRrDKZUoR72+rf0+gfID0jnXOLscrhpLMXphs1CoQZ2kSf2X/g6qeyL9MkCmzDp2SNaT5
 tg9pLvl0vYMWBVUDQSqf00IhtX1RH0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGrabM/RTjYOWG32YCic41PKnBU/k6Nk5QL41lBHGqo=;
 b=tUHW+Ko4a97J70ValSNk573aKzzga3AjwGdje4o0at3r9RwJYxnixb+xUcbt2UurTma68L
 MpXy0p4ANYDR1JAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 992F7137CF;
 Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WJp7IyKzXGf5QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Dec 2024 23:20:12 +0100
Message-ID: <20241213222014.1580991-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213222014.1580991-1-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/8] IMA: Add example policy for ima_violations.sh
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/datafiles/ima_violations/violations.policy     | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy

diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
new file mode 100644
index 0000000000..5734c7617f
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
@@ -0,0 +1 @@
+func=FILE_CHECK
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
