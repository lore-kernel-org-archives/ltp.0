Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E703C83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:01:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3D8D3CCD37
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:01:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAF073CCD0A
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C10B600B24
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF5D9219D2;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vynwfAl7NKFae8EUEF6zcHJ5tfPiyJHUXstRSfZjqdI=;
 b=p4lWVjx+g7b5pE/FBOAQDI+XawRBWbk4qwD4GBYzuhtQi8edXengxaSTAgu0QNjpBaW2yc
 wDI943ElN02o2IQOZn7s70hzPTcQIx8zrEPzcSYiWhVkEmXItGqT0KAA/7U3N9E0VuBNOO
 w4VNMveBON7Ga1s/+/gkT90AjcpJmHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vynwfAl7NKFae8EUEF6zcHJ5tfPiyJHUXstRSfZjqdI=;
 b=w8aL8daglaQWPBhbbVI5Qzvtszb9sbDUXcr+qvNX7/VliQJZJPMBtRjYZ83kn7oQfKRlzP
 AuU6wIhLt/s36gBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p4lWVjx+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w8aL8dag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vynwfAl7NKFae8EUEF6zcHJ5tfPiyJHUXstRSfZjqdI=;
 b=p4lWVjx+g7b5pE/FBOAQDI+XawRBWbk4qwD4GBYzuhtQi8edXengxaSTAgu0QNjpBaW2yc
 wDI943ElN02o2IQOZn7s70hzPTcQIx8zrEPzcSYiWhVkEmXItGqT0KAA/7U3N9E0VuBNOO
 w4VNMveBON7Ga1s/+/gkT90AjcpJmHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vynwfAl7NKFae8EUEF6zcHJ5tfPiyJHUXstRSfZjqdI=;
 b=w8aL8daglaQWPBhbbVI5Qzvtszb9sbDUXcr+qvNX7/VliQJZJPMBtRjYZ83kn7oQfKRlzP
 AuU6wIhLt/s36gBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D07013A73;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EKjgIDCLf2igZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 12:59:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Jul 2025 14:59:14 +0200
Message-ID: <20250722125916.74967-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722125916.74967-1-pvorel@suse.cz>
References: <20250722125916.74967-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: AF5D9219D2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/6] tst_res_: Print error to stderr,
 with filename and lineno
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

Printing to stderr, tst_res_ filename and lineno helps debugging wrong
code. Best would be if it prints either code which invoked it or the
original message, but at least this is an improvement.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
* New in v4

 testcases/lib/tst_res_.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_res_.c b/testcases/lib/tst_res_.c
index c09d689ee5..5b255d4d54 100644
--- a/testcases/lib/tst_res_.c
+++ b/testcases/lib/tst_res_.c
@@ -16,7 +16,7 @@ int main(int argc, char *argv[])
 	int type, i;
 
 	if (argc < 5) {
-		printf("argc = %i expected 5\n", argc);
+		fprintf(stderr, "%s:%d: argc = %i expected 5\n", __FILE__, __LINE__, argc);
 		goto help;
 	}
 
@@ -35,7 +35,7 @@ int main(int argc, char *argv[])
 	} else if (!strcmp(argv[3], "TBROK")) {
 		type = TBROK;
 	} else {
-		printf("Wrong type '%s'\n", argv[3]);
+		fprintf(stderr, "%s:%d: Wrong type '%s'\n", __FILE__, __LINE__, argv[3]);
 		goto help;
 	}
 
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
