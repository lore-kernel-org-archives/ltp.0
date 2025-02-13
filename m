Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663C4C0219D
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 13:37:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4F6A3C9AB2
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 14:37:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 027FB3C974A
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 14:37:35 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 747591017E20
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 14:37:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 762A71FB6C;
 Thu, 13 Feb 2025 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739453854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGqtSH6kHnTchjFqLLn9OvB6tnQyzxkJThg+DlJLX5k=;
 b=aIt2Ci7ifnEjRTGhT/KaeCZkGDXiw4pGBvHag2D+mPAkeLmKX/83OGVVeaDz71p7rAu+Zf
 TlxATupo/2fqGzghuYyZc80XpzTT5QYnxf7MGdMLKSr5Z0j3ngVKgroNiHMiI7gsK98ob4
 cM0s7escGUQPmUx1iK2KifqY0kTZF/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739453854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGqtSH6kHnTchjFqLLn9OvB6tnQyzxkJThg+DlJLX5k=;
 b=khYj3rjhzHxQ6w2xqy+vRcyGmuodBfAwLv+g6G3bhEW87SkYLYCr/STbuPW1lYsj8kEKCe
 Jkhq4FWzcK7iExBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aIt2Ci7i;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=khYj3rjh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739453854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGqtSH6kHnTchjFqLLn9OvB6tnQyzxkJThg+DlJLX5k=;
 b=aIt2Ci7ifnEjRTGhT/KaeCZkGDXiw4pGBvHag2D+mPAkeLmKX/83OGVVeaDz71p7rAu+Zf
 TlxATupo/2fqGzghuYyZc80XpzTT5QYnxf7MGdMLKSr5Z0j3ngVKgroNiHMiI7gsK98ob4
 cM0s7escGUQPmUx1iK2KifqY0kTZF/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739453854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGqtSH6kHnTchjFqLLn9OvB6tnQyzxkJThg+DlJLX5k=;
 b=khYj3rjhzHxQ6w2xqy+vRcyGmuodBfAwLv+g6G3bhEW87SkYLYCr/STbuPW1lYsj8kEKCe
 Jkhq4FWzcK7iExBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B4BC13874;
 Thu, 13 Feb 2025 13:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8IPsCJ71rWdSVgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 13 Feb 2025 13:37:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 13 Feb 2025 14:37:28 +0100
Message-ID: <20250213133730.27999-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213133730.27999-1-andrea.cervesato@suse.de>
References: <20250213133730.27999-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 762A71FB6C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.58 / 50.00]; BAYES_HAM(-1.57)[92.23%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] ci: test linting only with python 3.9
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

Remove all python versions but the 3.9 from all liting commands.
The reason is that there's no need to run pylint on multiple python
versions if we check for the same issues.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .github/workflows/linting.yml | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/.github/workflows/linting.yml b/.github/workflows/linting.yml
index 66746ec..7df63b7 100644
--- a/.github/workflows/linting.yml
+++ b/.github/workflows/linting.yml
@@ -10,16 +10,7 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
-        python-version: [
-          "3.6",
-          "3.7",
-          "3.8",
-          "3.9",
-          "3.10",
-          "3.11",
-          "3.12",
-          "3.13"
-        ]
+        python-version: ["3.9"]
 
     steps:
     - name: Show OS
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
