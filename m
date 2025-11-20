Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6D6CF8875
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 16:36:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E1283D0105
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 17:36:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D9613D00EF
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 17:35:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 030D0200DC0
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 17:35:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34FFF2124E;
 Thu, 20 Nov 2025 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763656555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3KBXTG/MCLwQCIsWRustCUe2KmOowHsZaziHtDjxdsU=;
 b=eGuEYN40YI37W8JRZ6Os9aLqf1HW0g/GZYlzuJ1DFhyw5GKFMQgpJqbKqGnGODr8x6z4rs
 fRdWyfiRlnpIjpCyEYJ65MVnbV5L7H0vrehj4QyV3g0LEQ71oBRBCVtfQHlDmYH2/WYwVi
 hAupxiXfmHv4LTnBzY5aUkEdnf0UY9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763656555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3KBXTG/MCLwQCIsWRustCUe2KmOowHsZaziHtDjxdsU=;
 b=ele6cFZz0DOIpAXw0+k71W6ZCXjEiJmVzVxdHRzkUmN75N1zAP7083i6VEgjJSiS4uiZxv
 TVjy6wL3IX8HouDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763656555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3KBXTG/MCLwQCIsWRustCUe2KmOowHsZaziHtDjxdsU=;
 b=eGuEYN40YI37W8JRZ6Os9aLqf1HW0g/GZYlzuJ1DFhyw5GKFMQgpJqbKqGnGODr8x6z4rs
 fRdWyfiRlnpIjpCyEYJ65MVnbV5L7H0vrehj4QyV3g0LEQ71oBRBCVtfQHlDmYH2/WYwVi
 hAupxiXfmHv4LTnBzY5aUkEdnf0UY9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763656555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3KBXTG/MCLwQCIsWRustCUe2KmOowHsZaziHtDjxdsU=;
 b=ele6cFZz0DOIpAXw0+k71W6ZCXjEiJmVzVxdHRzkUmN75N1zAP7083i6VEgjJSiS4uiZxv
 TVjy6wL3IX8HouDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03FED3EA61;
 Thu, 20 Nov 2025 16:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bdQ1O2pDH2mRRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Nov 2025 16:35:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Nov 2025 17:35:50 +0100
Message-ID: <20251120163550.333241-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] readahead02: Sleep 1.5 msec to fix problem on
 bare metal
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

This fixes ppc64le bare metal. It looks like kernel needs some time to
update counters.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index f007db187e..05537ca991 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -173,6 +173,7 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 
 			i++;
 			offset += readahead_length;
+			usleep(1500);
 		} while ((size_t)offset < fsize);
 		tst_res(TINFO, "readahead calls made: %zu", i);
 		*cached = get_cached_size();
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
