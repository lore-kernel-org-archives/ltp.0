Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB59ACDB47C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:21:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 395FF3E6203
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:21:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 721C13E5335
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CADED600903
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0410E71038
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ic0pSGm/6BiEktbmlWoNcBvuot+56mycf0Q6cfApHX0=;
 b=nFYbgCbhuzfT7IjOMSpNd83/d5yraqZyicu0hZWkrhrdO78P19LKdGDvacghBpMD7bsQcE
 kFK+qjjyt2v5iCb3uSIJvkGoUqoenQ6zvxhgRm3adw0/+cwNMi6SDHbK6wpHvSjIc2vyKJ
 9Vyhu5+xaeQBLpwWaURKEFdKRiOMIJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ic0pSGm/6BiEktbmlWoNcBvuot+56mycf0Q6cfApHX0=;
 b=7fo2h3O1Wornmc6BSJFOLhkz2mL8/1jMpmRwBKAgmpZ419dSn2yYu7/3DyP8o9oUNAgBUq
 t1vA7/TzB94kwbAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ic0pSGm/6BiEktbmlWoNcBvuot+56mycf0Q6cfApHX0=;
 b=r1y3lJ6bur9tS+BB48k2R5RKsRuLyy0bRtTPq4FqcuwT/r4bKkUpGlZ86q6jt9OBH+h1Ja
 1lRP7yHotjiTpK4SLtsnoYofAJVRJMFc2ka4ahsXICL71e+yLcFC6eyw8+KOT5gUjeLHfZ
 6sVV+NyrtKj7qfjoS9Uskxn4bbsH7E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ic0pSGm/6BiEktbmlWoNcBvuot+56mycf0Q6cfApHX0=;
 b=n+fCalhSe1av768VbYPxEGI57fa6GCtgJvFFVxGG76ONrtKfVKU1YKFiotlFZQjfcxZbuZ
 1rA0oSgVxTyBGBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E525B779AD
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1e4YNwWhO2pJAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:50 +0200
Message-ID: <20260624091900.4107041-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/13] keyctl01.sh: Remove the keyctl subcommand check
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

The test was introduced 10 years ago and the functionality is now
present on all supported distributions.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/keyctl/keyctl01.sh | 31 ---------------------------
 1 file changed, 31 deletions(-)

diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index cdbb8bf8b..514b6b8bf 100755
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -33,39 +33,8 @@
 
 TST_SETUP=setup
 
-check_keyctl()
-{
-	local nosup
-	for op in $@; do
-		nosup=0
-
-		if ! keyctl 2>&1 | grep -q "keyctl $op"; then
-			nosup=1
-		fi
-
-		if [ "$op" = "request2" ]; then
-			local key=`keyctl request2 user debug:foo bar`
-			if [ $? -ne 0 ]; then
-				nosup=1
-			fi
-		fi
-
-		if [ "$op" = "unlink" ]; then
-			if ! keyctl unlink $key @s; then
-				nosup=1
-			fi
-		fi
-
-		if [ $nosup -ne 0 ]; then
-			tst_brk TCONF "keyctl operation $op not supported"
-		fi
-	done
-}
-
 setup()
 {
-	check_keyctl negate request2 show unlink
-
 	PATH_KEYSTAT="/proc/key-users"
 
 	if [ ! -f "$PATH_KEYSTAT" ]; then
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
