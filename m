Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A8EC5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:01:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 764633D03B0
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:01:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E87E3CCDB8
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 37556600157
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8244480E2B;
 Mon, 10 Aug 2026 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uU9q1URfJzy4BOKxuGX2uD+8rOv+vknVvoYqmH1ywig=;
 b=olxXEFiglZIot8EaXRfOIVNoCEyTK+rQldGH7/W/oALEBxzjn5nOqpecVRAdSB9w7xtvE7
 Bn5HKEwTpzlSkiNqLR+Yg2TCM6ic8h/KVBxNeMeKTuLTZ2mBUjYYwc7voJDD05qMyuaijc
 LOYKXxMl0In7Vm7htgYaUv1aG2/mU2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uU9q1URfJzy4BOKxuGX2uD+8rOv+vknVvoYqmH1ywig=;
 b=5IzfB6cOWkBsiyGtrumW+SsLTEAR5MPwwwDU1HmZ09mOwslUptVGMOwFTdsGF3zVigQEIF
 2dUbpFKrPXkahtCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uU9q1URfJzy4BOKxuGX2uD+8rOv+vknVvoYqmH1ywig=;
 b=y7F9ZBNzFp5/uSTs4iiX9ToLdWbOowJrx4JZ69MYi2l6dy8B5LC+estxusDYxYblhlKNSc
 i8nmjPAJE3Am3GUKOuKBT0KWBkAuZKp2HGusYq0TiAXDD1OOSEuCp0DMCespfwlVzQySy1
 T759eLqMurmjraMqMeQ43c0KOx0LrKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uU9q1URfJzy4BOKxuGX2uD+8rOv+vknVvoYqmH1ywig=;
 b=VxJ/8npyO58/RdvNAQk7CVGoimYNCnMWdvJ2OUOPQubh8HQdKek6toEBzJ1+ZHH3XpZsXi
 QS8rSVylIFl76WDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 542B5779C0;
 Mon, 10 Aug 2026 16:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8PqrE7P1eWquLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 16:00:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Aug 2026 18:00:45 +0200
Message-ID: <20260810160048.1040517-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810160048.1040517-1-pvorel@suse.cz>
References: <20260810160048.1040517-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,suse.com,gmail.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/7] creat07: Avoid timeout on the test failure
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
Cc: linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test always needs to run kill() and waitpid() to avoid timeout.
This was not true when creat07_child.c unexpectedly succeeded (a test
failure).

Fixes: da3105af69 ("syscalls/creat07: Cleanup && Convert to new API")
Reported-by: linuxtestproject.agent@gmail.com
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.

 testcases/kernel/syscalls/creat/creat07.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index c7b85ee694..1de1b46621 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -35,7 +35,7 @@ static void verify_creat(void)
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "creat() succeeded unexpectedly");
-		return;
+		goto kill;
 	}
 
 	if (TST_ERR == ETXTBSY)
@@ -43,6 +43,7 @@ static void verify_creat(void)
 	else
 		tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
 
+kill:
 	SAFE_KILL(pid, SIGKILL);
 	SAFE_WAITPID(pid, NULL, 0);
 }
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
