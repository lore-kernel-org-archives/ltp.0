Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1214DC44520
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 21:36:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7C763E965E
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 23:36:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F19133C2697
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 23:36:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4285B1000741
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 23:36:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6E553E7D;
 Mon, 20 Jul 2026 21:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784583373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KWFckv+5f3YJeCapK+8kVEWC/MKGH1X5qdSQwZw8G8A=;
 b=Cai6TrslbZtydT3qFURhg1JhMSL/PJvRtghoNHLl7vCB5Q7IHb2+WO7Z8J2GDsjUKwWEbN
 nSXE4EO32QRr7bBfo48hTZn39LiyHc0IcYXoUgiTwnX6pqtvvcv6lFCL4nJiQ3U5pYg28K
 v90T3u8hK8ZiBsd1r9VbGWH+6uFlbtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784583373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KWFckv+5f3YJeCapK+8kVEWC/MKGH1X5qdSQwZw8G8A=;
 b=JVX7H8h57jS4I4/VQnGcnKddy3LFsrOmQ3X4+jEq036t7pJP3v9v94zJc0/ET+ibsoNCx9
 O0f3ehwW19VrySCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cai6Trsl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JVX7H8h5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784583373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KWFckv+5f3YJeCapK+8kVEWC/MKGH1X5qdSQwZw8G8A=;
 b=Cai6TrslbZtydT3qFURhg1JhMSL/PJvRtghoNHLl7vCB5Q7IHb2+WO7Z8J2GDsjUKwWEbN
 nSXE4EO32QRr7bBfo48hTZn39LiyHc0IcYXoUgiTwnX6pqtvvcv6lFCL4nJiQ3U5pYg28K
 v90T3u8hK8ZiBsd1r9VbGWH+6uFlbtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784583373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KWFckv+5f3YJeCapK+8kVEWC/MKGH1X5qdSQwZw8G8A=;
 b=JVX7H8h57jS4I4/VQnGcnKddy3LFsrOmQ3X4+jEq036t7pJP3v9v94zJc0/ET+ibsoNCx9
 O0f3ehwW19VrySCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7140B779AA;
 Mon, 20 Jul 2026 21:36:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Zc70Gc2UXmoLbAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Jul 2026 21:36:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jul 2026 23:36:10 +0200
Message-ID: <20260720213610.627213-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_TRACE(0.00)[suse.cz:+]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B6E553E7D
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] setsockopt10: Fix running with more iterations
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

Do proper cleanup SAFE_CLOSE(tcp1_sk) before return to fix test when
running with more iterations:

    # ./setsockopt10  -i1022
    ...
    setsockopt10.c:165: TPASS: parent: tls disallows disconnect: EOPNOTSUPP (95)
    setsockopt10.c:116: TINFO: child: connect for tcp2 connection
    setsockopt10.c:120: TINFO: child: could not connect to tcp1: ECONNREFUSED (111)
    setsockopt10.c:134: TBROK: socket(2, 1, 0) failed: EMFILE (24)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/setsockopt/setsockopt10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt10.c b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
index 76c977d2eb..b12f7bf166 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt10.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
@@ -167,6 +167,7 @@ static void run(void)
 			tst_res(TFAIL | TTERRNO, "parent: unexpected errno from connect");
 		TST_CHECKPOINT_WAKE(2);
 		tst_reap_children();
+		SAFE_CLOSE(tcp1_sk);
 		return;
 	}
 
@@ -183,6 +184,7 @@ static void run(void)
 
 		TST_CHECKPOINT_WAKE(2);
 		tst_reap_children();
+		SAFE_CLOSE(tcp1_sk);
 		return;
 	}
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
