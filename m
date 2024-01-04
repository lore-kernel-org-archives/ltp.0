Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DB8C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 12:23:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F18D3CE724
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 13:23:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A1AC3CE6E2
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:23:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DCB8A601B26
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:23:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2E0521EF5;
 Thu,  4 Jan 2024 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wojqmzRJT1viwni2OK/9uXj24KfMOAWYOd9snjW4mI=;
 b=1J2y/UYaemS4AgywiOt4dzBt7u84n6blTHapNiK3Fnedo1eckNBgiX9pxRs7v43nR5Wq1C
 HmyxPKkb9jLBB1QkO4mTCL1PsoZfaW5yKC2G+BGpsjoRFyJWq5rrcMlvOvMBEz4I/3w9FS
 Esq6T5qmMyhgvQCtMP4U8ZiOoo9n2oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wojqmzRJT1viwni2OK/9uXj24KfMOAWYOd9snjW4mI=;
 b=jNpmZ4B7c7wIU0knpYZ0w1QXv4D/duRXPW1yr/Ntw8CMeCo1q6TPrSJiyOImfvVN99cZM+
 oL6rwfTZe3/Fa8CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wojqmzRJT1viwni2OK/9uXj24KfMOAWYOd9snjW4mI=;
 b=1J2y/UYaemS4AgywiOt4dzBt7u84n6blTHapNiK3Fnedo1eckNBgiX9pxRs7v43nR5Wq1C
 HmyxPKkb9jLBB1QkO4mTCL1PsoZfaW5yKC2G+BGpsjoRFyJWq5rrcMlvOvMBEz4I/3w9FS
 Esq6T5qmMyhgvQCtMP4U8ZiOoo9n2oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wojqmzRJT1viwni2OK/9uXj24KfMOAWYOd9snjW4mI=;
 b=jNpmZ4B7c7wIU0knpYZ0w1QXv4D/duRXPW1yr/Ntw8CMeCo1q6TPrSJiyOImfvVN99cZM+
 oL6rwfTZe3/Fa8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52686137E8;
 Thu,  4 Jan 2024 12:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KDyBEDKjlmUVFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 12:23:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 13:23:07 +0100
Message-ID: <20240104122308.1158487-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104122308.1158487-1-pvorel@suse.cz>
References: <20240104122308.1158487-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="1J2y/UYa";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jNpmZ4B7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[37.47%]
X-Rspamd-Queue-Id: A2E0521EF5
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] lib: Use LTP_ prefix for LTP_NO_CLEANUP variable
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

Variables which are supposed to be user defined should use LTP_ prefix
instead of TST_ prefix.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/User-Guidelines.asciidoc | 3 ++-
 testcases/lib/test.sh        | 2 +-
 testcases/lib/tst_test.sh    | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/User-Guidelines.asciidoc b/doc/User-Guidelines.asciidoc
index cff2e83c8..63081fdea 100644
--- a/doc/User-Guidelines.asciidoc
+++ b/doc/User-Guidelines.asciidoc
@@ -40,7 +40,8 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'TMPDIR'              | Base directory for template directory (C: '.needs_tmpdir = 1'
                           and others, which imply it, shell: 'TST_NEEDS_TMPDIR=1').
                           Must be an absolute path (default: '/tmp').
-| 'TST_NO_CLEANUP'      | Disable running test cleanup (defined in 'TST_CLEANUP').
+| 'LTP_NO_CLEANUP'      | Disable running test cleanup (defined in 'TST_CLEANUP').
+                          Shell API only.
 | 'LTP_ENABLE_DEBUG'    | Enable debug info (value '1' or 'y').
 |==============================================================================
 
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 8947f47c1..d26cf5df0 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -108,7 +108,7 @@ tst_require_root()
 
 tst_exit()
 {
-	if [ -n "${TST_CLEANUP:-}" -a -z "${TST_NO_CLEANUP:-}" ]; then
+	if [ -n "${TST_CLEANUP:-}" -a -z "${LTP_NO_CLEANUP:-}" ]; then
 		$TST_CLEANUP
 	fi
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 5f178a1be..98bc13b2c 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -26,7 +26,7 @@ trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
 
 _tst_do_cleanup()
 {
-	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
+	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$LTP_NO_CLEANUP" ]; then
 		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
 			TST_DO_CLEANUP=
 			$TST_CLEANUP
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
