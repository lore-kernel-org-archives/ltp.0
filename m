Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427DED29FF8
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:26:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A68093C7624
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 13:26:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A6213C01E9
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:26:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C8831A008A9
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:26:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9015D5C571;
 Wed, 14 Jan 2026 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768393574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tip/WOGrhzs3Jd9zye4r8pxbFmlsXL1EKGiplw/xeTo=;
 b=cG+PsjOLZnJWrQCKjEaqYwhQQ+qF7izImhX5SvmpQgStFpbKeXqgzJltlKJFPZlSSorDZg
 jEZZb+IInXi3QzvgQFFnr3Zq0T6QoMjbq4hVmN1VYDSyBFt3AQvXR8V7hfU0c9qkiyi0ha
 ecD+jrPtKfv0cNtTJ8uxZSREi4lZ2zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768393574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tip/WOGrhzs3Jd9zye4r8pxbFmlsXL1EKGiplw/xeTo=;
 b=RoG5CIyCbX7BG31Ae+ytM9NrZ5Y1Hue9ie8VE0aw3XBmifn3BA26yNHm4cVY3PeAiCJnb+
 hcULOHiCmbH/r7DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768393574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tip/WOGrhzs3Jd9zye4r8pxbFmlsXL1EKGiplw/xeTo=;
 b=cG+PsjOLZnJWrQCKjEaqYwhQQ+qF7izImhX5SvmpQgStFpbKeXqgzJltlKJFPZlSSorDZg
 jEZZb+IInXi3QzvgQFFnr3Zq0T6QoMjbq4hVmN1VYDSyBFt3AQvXR8V7hfU0c9qkiyi0ha
 ecD+jrPtKfv0cNtTJ8uxZSREi4lZ2zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768393574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tip/WOGrhzs3Jd9zye4r8pxbFmlsXL1EKGiplw/xeTo=;
 b=RoG5CIyCbX7BG31Ae+ytM9NrZ5Y1Hue9ie8VE0aw3XBmifn3BA26yNHm4cVY3PeAiCJnb+
 hcULOHiCmbH/r7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D8E23EA66;
 Wed, 14 Jan 2026 12:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q+NfE2aLZ2mMSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Jan 2026 12:26:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Jan 2026 13:26:11 +0100
Message-ID: <20260114122611.372930-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.47 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MIME_HTML_ONLY(1.20)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-0.97)[-0.970]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:~];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: css: Add style for C code,
 files and man pages
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

Use monospace and disable italic for various C code, files and man
pages. For is used as the default for sphinx
(sphinx/themes/basic/static/basic.css.jinja).

Examples of code where it is used:

    <a class="reference internal"
    href="api_c_tests.html#struct-tst-test"><span class="std std-ref">struct
    tst_test</span></a>p

    <a class="extlink-master reference external"
    href="https://github.com/linux-test-project/ltp/blob/master/include/tst_test.h">include/tst_test.h</a>

    <a class="extlink-kernel_tree reference external"
    href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/stat.h">include/uapi/linux/stat.h</a>

    <a class="manpage reference external"
    href="https://man7.org/linux/man-pages/man2/setrlimit.2.html">setrlimit(2)</a>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/_static/custom.css | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/_static/custom.css b/doc/_static/custom.css
index e918b0e609..5017fda2e1 100644
--- a/doc/_static/custom.css
+++ b/doc/_static/custom.css
@@ -8,3 +8,9 @@
 .rst-content table td ul {
     margin-bottom: 0;
 }
+
+/* monospace and disable italic for C code, files and man pages */
+a.extlink-master, a.extlink-kernel_tree, a.extlink-kselftest, a.extlink-shell_lib, a.manpage, .std.std-ref {
+    font-style: normal;
+    font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", Courier, monospace;
+}
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
