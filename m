Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E1DC47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 20:47:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD25A3D013D
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:47:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C3E63CBA58
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97D99600E42
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21EC821E1D;
 Thu,  4 Jan 2024 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btsf7xnwa0VDPwE7+iQCvAQqt8tE3zJ7o//bXBs4OzQ=;
 b=ASgzF/wI/ghz6qZ4skrQNgZOKoQkocvPXsolPtX/D3JrCDn0eVISXcLcRwBoFb4nJErSbZ
 fNl2N8+VTO1Kr76jD2zRCykwgZe9cUNbKskRKZFJW8BgzKEuY4TwyIMI3WqkYQ//a7yL62
 vds0zPPmpK2oK4lwOIkdkJrPR+l7XLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btsf7xnwa0VDPwE7+iQCvAQqt8tE3zJ7o//bXBs4OzQ=;
 b=89lgKfZ4b1MssZAAvmbVSamdQpxYjeItZO79Q3wdkgAWAqBXEeJxpPuJv66RZroo86QjJq
 2Y2OHRRERnCCJICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btsf7xnwa0VDPwE7+iQCvAQqt8tE3zJ7o//bXBs4OzQ=;
 b=ASgzF/wI/ghz6qZ4skrQNgZOKoQkocvPXsolPtX/D3JrCDn0eVISXcLcRwBoFb4nJErSbZ
 fNl2N8+VTO1Kr76jD2zRCykwgZe9cUNbKskRKZFJW8BgzKEuY4TwyIMI3WqkYQ//a7yL62
 vds0zPPmpK2oK4lwOIkdkJrPR+l7XLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btsf7xnwa0VDPwE7+iQCvAQqt8tE3zJ7o//bXBs4OzQ=;
 b=89lgKfZ4b1MssZAAvmbVSamdQpxYjeItZO79Q3wdkgAWAqBXEeJxpPuJv66RZroo86QjJq
 2Y2OHRRERnCCJICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05AA813C99;
 Thu,  4 Jan 2024 20:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aNlPAB4Zl2WsIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 20:46:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 21:46:12 +0100
Message-ID: <20240104204614.1426027-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104204614.1426027-1-pvorel@suse.cz>
References: <20240104204614.1426027-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 21EC821E1D
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ASgzF/wI";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=89lgKfZ4
X-Spamd-Bar: ++++
X-Spamd-Result: default: False [4.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[19.28%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/9] metadata: Add test for missing blank line in list
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

This is a test for a fix in previous commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 metadata/tests/list_missing_blank_line.c      | 14 ++++++++++++++
 metadata/tests/list_missing_blank_line.c.json | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 metadata/tests/list_missing_blank_line.c
 create mode 100644 metadata/tests/list_missing_blank_line.c.json

diff --git a/metadata/tests/list_missing_blank_line.c b/metadata/tests/list_missing_blank_line.c
new file mode 100644
index 000000000..9d88d6aac
--- /dev/null
+++ b/metadata/tests/list_missing_blank_line.c
@@ -0,0 +1,14 @@
+/*\
+ * [Description]
+ *
+ * Some description.
+ *
+ * My BROKEN list (missing blank line before first item):
+ * * foo
+ * * bar
+ *
+ * My CORRECT list (with extra blank line before first item):
+ *
+ * * foo2
+ * * bar2
+ */
diff --git a/metadata/tests/list_missing_blank_line.c.json b/metadata/tests/list_missing_blank_line.c.json
new file mode 100644
index 000000000..6ad326fb6
--- /dev/null
+++ b/metadata/tests/list_missing_blank_line.c.json
@@ -0,0 +1,18 @@
+  "list_missing_blank_line": {
+   "doc": [
+     "[Description]",
+     "",
+     "Some description.",
+     "",
+     "My BROKEN list (missing blank line before first item):",
+     "",
+     "* foo",
+     "* bar",
+     "",
+     "My CORRECT list (with extra blank line before first item):",
+     "",
+     "* foo2",
+     "* bar2"
+    ],
+   "fname": "list_missing_blank_line.c"
+  }
\ No newline at end of file
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
