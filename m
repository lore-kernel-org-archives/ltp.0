Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13161C6FD1F
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 08:27:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 686863C1A0C
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 10:27:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E25CD3C0FDE
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 10:27:19 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 09C57601B0F
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 10:27:18 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FF4D350F4
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712132837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHGldmcLqF3ziv/ajOaVKb/wQgeU/b+qQa3E/+Zb8dI=;
 b=kbk3O+GuiofkwsmBv+D9BzUUYqGkxoKy6TpXMx2IkcZvX1/7B05+79RrN8h9Wv/KrUZs7G
 p0VMccv0EGeU4SEKnrzWogEqyG6qDgFprc2sVxj77WI/Va1QoaeDmsMWVVV+MSReBS0xLG
 7bL2l0g3AufL+rWT7stoO33Kmb/vrJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712132837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHGldmcLqF3ziv/ajOaVKb/wQgeU/b+qQa3E/+Zb8dI=;
 b=fuJlX80KbsMErbbYlHSf/t8O9iueWE3PusEOGHSovgAiM0kzXw3bXt54wp06D6+iFVr8tJ
 YPvrhWY4SPnWaaBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 515E913357
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 08:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id VvP6EuUSDWaaLwAAn2gu4w
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 03 Apr 2024 08:27:17 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Apr 2024 10:26:17 +0200
Message-ID: <20240403082618.5829-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403082618.5829-1-chrubis@suse.cz>
References: <20240403082618.5829-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: ++++++
X-Spamd-Result: default: False [6.11 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.08)[-0.420];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.00)[33.75%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-0.89)[-0.893];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5FF4D350F4
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] doc: Add more to spelling_wordlist
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

+ Computer jargon
+ LTP variable and constant names

Not everything has been added. E.g. I've avoided adding filesystems used
in variable names because it's supposed to be two words in text.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc_new/spelling_wordlist | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/doc_new/spelling_wordlist b/doc_new/spelling_wordlist
index 0c016e615..de1e3721e 100644
--- a/doc_new/spelling_wordlist
+++ b/doc_new/spelling_wordlist
@@ -118,3 +118,43 @@ vCPUs
 vendoring
 vger
 wallclock
+pid
+TBROK
+mkfs
+hugepages
+hugetlbfs
+printf
+scanf
+argv
+argc
+pthread
+futex
+hdr
+brk
+iovec
+iov
+strdup
+aprintf
+alloc
+hexd
+tcases
+strsig
+strstatus
+strerrno
+libcap
+capset
+capget
+musl
+setrlimit
+rlim
+optstr
+tmpfs
+nodev
+sys
+proc
+arg
+ver
+bitwise
+dereferenced
+allocator
+ptr
-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
