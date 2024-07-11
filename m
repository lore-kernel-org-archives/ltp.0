Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50364C3DA47
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 10:44:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDB573CC598
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 12:44:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 780F43C21C7
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 12:44:09 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF5FA14010C2
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 12:44:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C36FE1F8BE;
 Thu, 11 Jul 2024 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720694647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lj8XuX46LdW2LurCCm6u3IaSAAlraAEQKWFQfzb5eKo=;
 b=ymd1XBaK2odRRhhdVcozD8ZbDBdmEcR9yDDtn4R8neDd9alfj+C+ryCb6l/xxq+zhmCt+r
 mCsEAOnUvrY/0f9rwZbsczWRs7tQPJIcU1yuzTa6JHZqNV/tKo4UfhHE9CmfOeaJ0HsW4+
 EDfnw6dqGzhHp6UD/aByOpw9tl+5uLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720694647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lj8XuX46LdW2LurCCm6u3IaSAAlraAEQKWFQfzb5eKo=;
 b=P1dDOHPdZ01S/kH6yOklkXROxu5roi69m3FZR8VSfUliF6IoJ1D7FUQuk5UmzlYWgP/fqD
 Fu2247BBx11zkcCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720694647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lj8XuX46LdW2LurCCm6u3IaSAAlraAEQKWFQfzb5eKo=;
 b=ymd1XBaK2odRRhhdVcozD8ZbDBdmEcR9yDDtn4R8neDd9alfj+C+ryCb6l/xxq+zhmCt+r
 mCsEAOnUvrY/0f9rwZbsczWRs7tQPJIcU1yuzTa6JHZqNV/tKo4UfhHE9CmfOeaJ0HsW4+
 EDfnw6dqGzhHp6UD/aByOpw9tl+5uLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720694647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lj8XuX46LdW2LurCCm6u3IaSAAlraAEQKWFQfzb5eKo=;
 b=P1dDOHPdZ01S/kH6yOklkXROxu5roi69m3FZR8VSfUliF6IoJ1D7FUQuk5UmzlYWgP/fqD
 Fu2247BBx11zkcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A94F3136AF;
 Thu, 11 Jul 2024 10:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9QOcKHe3j2bUSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jul 2024 10:44:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Jul 2024 12:43:57 +0200
Message-ID: <20240711104400.63355-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/2] realtime: Use offsetof() macro from <stddef.h>
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
Cc: John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

offsetof() macro from <stddef.h> which uses __builtin_offsetof() should
be equivalent to the LTP custom implementation.

The replacement is required due sched_football.c rewrite into new API
(LTP library uses <stddef.h>, thus there is a redefinition).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/realtime/include/list.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/realtime/include/list.h b/testcases/realtime/include/list.h
index f87d602e4a..01159e34fc 100644
--- a/testcases/realtime/include/list.h
+++ b/testcases/realtime/include/list.h
@@ -39,6 +39,8 @@
 #ifndef _LINUX_LIST_H
 #define _LINUX_LIST_H
 
+#include <stddef.h>
+
 /*
  * These are non-NULL pointers that will result in page faults
  * under normal circumstances, used to verify that nobody uses
@@ -241,7 +243,6 @@ static inline void list_splice_init(struct list_head *list,
 	}
 }
 
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 /**
  * container_of - cast a member of a structure out to the containing structure
  * @ptr:	the pointer to the member.
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
