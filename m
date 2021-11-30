Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B585EC433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:44:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0E8A3C6BD8
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 12:44:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77FAE3C5DF0
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 12:44:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0AB5B1400BDA
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 12:44:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B2521FD54
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638272656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ngokI/jYJMiC5FqYQ+N9P1Df3VlTr8US/sLqwtiwSRI=;
 b=AyBQKgZfcjbrTAlMWfXRANS4aCuxhafbalAPD37BRZHvlQAqPX0/a6ZYWDdTmrR/ESE80b
 e4DmtNNeIca8CwjUjH4gpVoJXaxTSNFi/dp68O0vaU8+DW+3Y+uvPNADDiVtHdNOu4Fwuh
 B/jxiFcJttBO4FAKWTdHqxgvUQ42C10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638272656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ngokI/jYJMiC5FqYQ+N9P1Df3VlTr8US/sLqwtiwSRI=;
 b=9Kv/OWG4zsGmW6zlOmYSjiF/A0tBjNbHH297Iu8LgOucSeWcspe5S5n1OEU1TqFKY8k/BR
 4zkV5kd4ctDo+ICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF3CD13C98
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:44:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y5nJNI8OpmGsXQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:44:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Nov 2021 12:45:27 +0100
Message-Id: <20211130114527.5942-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sparse: Skip TCID and TST_TOTAL
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

Since these are part of the old library API.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 tools/sparse/sparse-ltp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index b1677d336..1a3b4089a 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -98,6 +98,9 @@ static void check_symbol_visibility(const struct symbol *const sym)
 	if (!(mod & MOD_TOPLEVEL))
 		return;
 
+	if (!strcmp(name, "TCID") || !strcmp(name, "TST_TOTAL"))
+		return;
+
 	if (has_lib_prefix && (mod & MOD_STATIC) && !(mod & MOD_INLINE)) {
 		warning(sym->pos,
 			"LTP-003: Symbol '%s' has the LTP public library prefix, but is static (private).",
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
