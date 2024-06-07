Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DAEC27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 11:53:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1D9B3D0A86
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 13:53:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFE623D0A65
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 13:53:14 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB7DD100023D
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 13:53:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 90EA521B68;
 Fri,  7 Jun 2024 11:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717761192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O9LpJucpaFIZI+PI/uVKIYXidSPBJrPhx7VgfBA61kU=;
 b=nTpCMGSfM3RBmHm7c3eFscdft88mOPK+xRuBtZq+5y7c2snbK16Vwv1HDMM56Y+uxW1fxD
 YAT2swF/86NtnwtDSsDwqXTjMSoZE0fQppok7mq0kLPGXyLjhebJoz3nj2giH5TmnvLV9P
 kTDhaoX2j1CLz1y+mt08jcAzP3n1XsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717761192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O9LpJucpaFIZI+PI/uVKIYXidSPBJrPhx7VgfBA61kU=;
 b=B+14AqsrvV3TtPjnBReuARa4LlRgNMkkyLKrXUEhamk7dz82qolC+YMFV4u3PqdMMARIRw
 JD4Jp9ZmdthX1uAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qAEMBeYP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HO2a63Uu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717761191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O9LpJucpaFIZI+PI/uVKIYXidSPBJrPhx7VgfBA61kU=;
 b=qAEMBeYPvdjqDLleNVFFO2Ff5wH8V/+jMbIsHIGL/HEHvRUcOqUoR8d6Z/70maT2iw2sCR
 aHl1tTzNgYQrBxcDSggWw0cYRE0FBfG1L+s8xZNdc5L8+QdNt9QTD5yvgQ5pHirTmb+7Qd
 8/XcHG/KSKNp/pbACA57mKTOLTkWSPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717761191;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O9LpJucpaFIZI+PI/uVKIYXidSPBJrPhx7VgfBA61kU=;
 b=HO2a63Uu3cBGFKM+nsZioNYXCqnpotB7H4AVIBzDd66JjzVieOuqszLZVs8qgrfW6NSnUY
 4hOqbxFrUep6INDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62918133F3;
 Fri,  7 Jun 2024 11:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UOjBFqf0YmaZUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 11:53:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Jun 2024 13:53:04 +0200
Message-ID: <20240607115304.86028-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.07 / 50.00]; SEM_URIBL(3.50)[readme.md:url];
 BAYES_HAM(-2.72)[98.76%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 BAD_REP_POLICIES(0.10)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, readme.md:url, suse.cz:dkim, suse.cz:email]
X-Rspamd-Queue-Id: 90EA521B68
X-Spamd-Bar: +
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [KIRK PATCH 1/1] README: Document passing environment
 variables
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
 README.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README.md b/README.md
index 72e5c56..cb69049 100644
--- a/README.md
+++ b/README.md
@@ -104,6 +104,10 @@ Some basic commands are the following:
         --sut ssh:host=myhost.com:user=root:key_file=myhost_id_rsa \
         --run-suite syscalls --workers 16
 
+    # pass environment variables (list of key=value separated by ':')
+    ./kirk --framework ltp --run-suite net.features \
+        --env 'VIRT_PERF_THRESHOLD=180:LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1'
+
 It's possible to run a single command before running testing suites using
 `--run-command` option as following:
 
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
