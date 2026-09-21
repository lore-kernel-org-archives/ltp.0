Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A46C982E1
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 08:46:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87FED3C6135
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 10:46:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0216F3C6135
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 10:45:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73AA51A00807
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 10:45:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3101821BF8;
 Mon, 21 Sep 2026 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789980345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lDbymNSsG/Dvr4KwSpLP7TquE9wxhCR3P4/2x98DKoc=;
 b=MlIIYydBeKbdbpF6eDneAQcCC0W28Jd3K2x99BGoBtnlSN77uXdwC8gMITOJ/k6XBpQ4IB
 hCRJvjReZZ5i+nr1iNVb5RLyUnzO0pupo/bV2gWoRAJjtg58zkYqdpMgtvax26UyPbHHUf
 FNSrOj32BNlMQ9ZQZw/Nv7gWtBulYGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789980345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lDbymNSsG/Dvr4KwSpLP7TquE9wxhCR3P4/2x98DKoc=;
 b=c8WOxRmOxf+9xlLV+RnR+ILB9ZU/Z2mbj25bCQG2uPj/lGAWkeWJz0TCAJJRGTgE8zXwR8
 Oebu7GAOvVDaYJDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=S7pndUL2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ay7qaQS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789980341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lDbymNSsG/Dvr4KwSpLP7TquE9wxhCR3P4/2x98DKoc=;
 b=S7pndUL2hMoRUdaT+0JX2YM/NnY+C0de1N6qWKN7GiFDgx7eVv037MhjE260AaWt02TvjW
 m7eT+G2JL6ELR6gZKlhdH2ehm4HwKly5nb1cvdnpWPY5KP9VlIaPuxo7K8+PC859vdSWfY
 Pqk0KxusZcJUhWHtgX88/7a3nHfrulk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789980341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lDbymNSsG/Dvr4KwSpLP7TquE9wxhCR3P4/2x98DKoc=;
 b=ay7qaQS/SkiKjQ08h50VnyoHNc1SWIi/ysaO1wBVD0jMfgwvUlulW/kR8VjNPmsRELJXNC
 tD/usfd2KCJhxdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C97B413793;
 Mon, 21 Sep 2026 08:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XFpEJrTusGoVSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 21 Sep 2026 08:45:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 21 Sep 2026 10:45:38 +0200
Message-ID: <20260921084538.2051219-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3101821BF8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test: Fix test regression on -i
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

50745a2918 correctly changed iterations from int to unsigned int.
But UINT_MAX SAFE_STRTOUL() needs to be used, otherwise simple -i2
fails due UINT_MAX overflowed:

    tst_test.c:836: TBROK: strtol(2): 2 is out of range 0 - -1

Fixes: 50745a2918 ("lib: tst_test: Move the iterations to struct tst_test")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2b38d0063d..ed3d26cad0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -833,7 +833,7 @@ static void parse_opts(int argc, char *argv[])
 			print_test_tags();
 			exit(0);
 		case 'i':
-			tst_test->iterations = SAFE_STRTOL(optarg, 0, UINT_MAX);
+			tst_test->iterations = SAFE_STRTOUL(optarg, 0, UINT_MAX);
 		break;
 		case 'I':
 			if (tst_test->runtime > 0)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
