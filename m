Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936CEC982F1
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 12:21:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 209053E6CF2
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 14:21:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8041B3E6C73
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 14:21:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 14C01601DA2
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 14:21:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AED2A1FEFB
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790079655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s0hk6aP7qeZ9YkCEI4Nadmmr+VsyFUKdhoYtNwlnIXg=;
 b=hrQKhMCwa/yGhHTbw0EYW9hNMGf9nk2AoR45sCivME2WGxYvVQRszEBPCI3/uc62G0f3Yw
 1ROECMt32by1pJQlsK5gPKbi80AC9j8263u4GiKoWsZuQHgweUZaIsuddznSpZPEMBIOVs
 3K9R65Pz3Y2FxFFAW0dC06Jxnb5PRag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790079655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s0hk6aP7qeZ9YkCEI4Nadmmr+VsyFUKdhoYtNwlnIXg=;
 b=8R9KbGGthvwyFTdGIBAgTkkZHMPndzT2FRYzFaXYhKhja7CQeKu5+o93eYCPTd6SevgIFN
 Gn7ky1DHSYVpzdCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790079651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s0hk6aP7qeZ9YkCEI4Nadmmr+VsyFUKdhoYtNwlnIXg=;
 b=BHipuCsnOlpMK1GfC4lKDjGrIiy/ed5HvPkilO9Uwi2lrVey0pq0nTaHiXwN0Oe3AJT3m5
 gBqmEEm+mcA1xduSpNN42Eurka3yOr3YuBi7YtSCP8JXia1NrQKv34mwtZSVMxjNkSJatP
 pzi8oXh8ggZguNcZLSGW41nd4sBntxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790079651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s0hk6aP7qeZ9YkCEI4Nadmmr+VsyFUKdhoYtNwlnIXg=;
 b=2Drw7uq06UMTtuf/Hzkw3L/WA0JHq7eRBroP5JifhEQ3WCmeRuwMkzQbUwhY0PvM9fsu67
 OLE9djOs6k0lMsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B21C13A01
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 12:20:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id psguOqJysmqaKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 12:20:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Sep 2026 14:20:59 +0200
Message-ID: <20260922122059.4087109-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_kconfig: Add CONFIG_* mappings for keyctl tests
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

- keyctl23, keyctl29 need x509_key_parser
- keyctl30 needs pkcs8_key_parser

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_kconfig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 277ac6068..46eeb8ec0 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -165,6 +165,8 @@ static struct config_module_map {
 	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
 	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
 	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
+	{"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser"},
+	{"CONFIG_X509_CERTIFICATE_PARSER", "x509_key_parser"},
 	{}
 };
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
