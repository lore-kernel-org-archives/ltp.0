Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C10E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:03:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 626A33ED61E
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:03:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF5AB3ED62D
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:54 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 48136640698
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACF5D21167;
 Wed, 18 Dec 2024 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsSXiNBNxZiBcXdy2P7Tr2O4weR8llPcW3Q9ppguVMs=;
 b=w2v6VclvzkePj2Cg9yfF56lMu7LVb0w3xyXKLbABilxr6CrTm5z3gL9zHcMX8DNEDUVzaB
 i2qmXXNhKbd/2cbxbtVQZUmU5cCPTBe6YtEyo174jZlq3NCAaXKqXS5cpDwV2NU2mdvQzv
 tv02p48274ANGK5b4dpLiXJ70gi2TYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsSXiNBNxZiBcXdy2P7Tr2O4weR8llPcW3Q9ppguVMs=;
 b=XFGGmf7A4FYoJ73jtbqQy0j99E/PLE3bg/lO3DaPkZrGbc2ec6TxrYHY2yrTsKE5BTdUsu
 POgyElnnangbTdCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w2v6Vclv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XFGGmf7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsSXiNBNxZiBcXdy2P7Tr2O4weR8llPcW3Q9ppguVMs=;
 b=w2v6VclvzkePj2Cg9yfF56lMu7LVb0w3xyXKLbABilxr6CrTm5z3gL9zHcMX8DNEDUVzaB
 i2qmXXNhKbd/2cbxbtVQZUmU5cCPTBe6YtEyo174jZlq3NCAaXKqXS5cpDwV2NU2mdvQzv
 tv02p48274ANGK5b4dpLiXJ70gi2TYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsSXiNBNxZiBcXdy2P7Tr2O4weR8llPcW3Q9ppguVMs=;
 b=XFGGmf7A4FYoJ73jtbqQy0j99E/PLE3bg/lO3DaPkZrGbc2ec6TxrYHY2yrTsKE5BTdUsu
 POgyElnnangbTdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99CEB132EA;
 Wed, 18 Dec 2024 19:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LJgCJOUbY2fzdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:53 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:29 +0100
Message-ID: <20241218190029.15015-10-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218190029.15015-1-chrubis@suse.cz>
References: <20241218190029.15015-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: ACF5D21167
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 9/9] metadata: parse.sh: Add -Itestcases/kernel/include
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

This does not completely fix macro expansions without the patchset I've
send that removes the mess in testcases/kernel/mem/{lib,include}/
library because before the patchset some headers e.g. the ksm_helper.h
was included indirectly from the testcases/kernel/mem/include/mem.h
header.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/parse.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/metadata/parse.sh b/metadata/parse.sh
index 69bf5db65..7db2e2415 100755
--- a/metadata/parse.sh
+++ b/metadata/parse.sh
@@ -30,7 +30,7 @@ echo ' "tests": {'
 first=1
 
 for test in `find testcases/ -name '*.c'|sort`; do
-	a=$($top_builddir/metadata/metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
+	a=$($top_builddir/metadata/metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ -Itestcases/kernel/include "$test")
 	if [ -n "$a" ]; then
 		if [ -z "$first" ]; then
 			echo ','
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
