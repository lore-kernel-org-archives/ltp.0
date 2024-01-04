Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B43C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 20:46:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED13D3CE729
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:46:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B0983CB9D4
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E457E6009CF
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B0C021E10;
 Thu,  4 Jan 2024 20:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXSg5yVZN75WP6JEmkDmoIa26xwYEPbM4XORarzQOVU=;
 b=sFgwMdjaZGLN/aOpA+cMb8gyiwCYN9jQbFwvxYHB3aiCWd9cnYi94y/m91dlWrv701Ok2/
 JX7dI0reaOyGLIHy7edEGdylsk13Ij8Gp5ibl64F9I4f5JpapYHY1JVEYHonUl1FQYSQkY
 FR3YJT1i9kOwUR2BVq1oDPPfPA09nKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXSg5yVZN75WP6JEmkDmoIa26xwYEPbM4XORarzQOVU=;
 b=XA/6jpZ2vapY/wuR9DqJBW88tVwysf3cdWWDoNnl91mWk2ascZkWzUQkfGq1lFkhIO4eWN
 GPkwZIT+jw+VuhBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXSg5yVZN75WP6JEmkDmoIa26xwYEPbM4XORarzQOVU=;
 b=sFgwMdjaZGLN/aOpA+cMb8gyiwCYN9jQbFwvxYHB3aiCWd9cnYi94y/m91dlWrv701Ok2/
 JX7dI0reaOyGLIHy7edEGdylsk13Ij8Gp5ibl64F9I4f5JpapYHY1JVEYHonUl1FQYSQkY
 FR3YJT1i9kOwUR2BVq1oDPPfPA09nKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXSg5yVZN75WP6JEmkDmoIa26xwYEPbM4XORarzQOVU=;
 b=XA/6jpZ2vapY/wuR9DqJBW88tVwysf3cdWWDoNnl91mWk2ascZkWzUQkfGq1lFkhIO4eWN
 GPkwZIT+jw+VuhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F62D13C99;
 Thu,  4 Jan 2024 20:46:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qOJqCh0Zl2WsIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 20:46:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 21:46:07 +0100
Message-ID: <20240104204614.1426027-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104204614.1426027-1-pvorel@suse.cz>
References: <20240104204614.1426027-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sFgwMdja;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="XA/6jpZ2"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[23.43%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 4B0C021E10
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/9] metadata: parse.sh: Allow to pass list of files
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 metadata/parse.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/metadata/parse.sh b/metadata/parse.sh
index 69bf5db65..9dd097153 100755
--- a/metadata/parse.sh
+++ b/metadata/parse.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
 # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) Linux Test Project, 2022-2024
 set -e
 
 top_builddir=$PWD/..
@@ -29,7 +30,13 @@ echo ' "tests": {'
 
 first=1
 
-for test in `find testcases/ -name '*.c'|sort`; do
+if [ $# -gt 0 ]; then
+	tests=$*
+else
+	tests=$(find testcases/ -name '*.c' | sort)
+fi
+
+for test in $tests; do
 	a=$($top_builddir/metadata/metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
 	if [ -n "$a" ]; then
 		if [ -z "$first" ]; then
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
