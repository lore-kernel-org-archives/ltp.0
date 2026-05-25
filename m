Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CD2CD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 15:15:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3F363E62EA
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 17:15:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69E933E62E6
 for <ltp@lists.linux.it>; Mon, 25 May 2026 17:15:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EDCFE600709
 for <ltp@lists.linux.it>; Mon, 25 May 2026 17:15:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82E316B0EC
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779722101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg5f+JbijVPe497KgwTntZYtNfzxWpf1hQMZeDUcADA=;
 b=2vCCztfdypi0YkqZtIXao673q1dpZ1iBC1yD3KDj2b77mh4e/Soa5j+ypFOOQdUqlDW9xj
 2Tnm7r/sOQX/jaHdHGwaoHjuRcDovMOg0dyb9+8p7MeyoeBZsMCo25mU6yl+PBTl8ZHgrh
 XItZufpmnyrxuyzb0fFyd+WZ4YXyqpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779722101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg5f+JbijVPe497KgwTntZYtNfzxWpf1hQMZeDUcADA=;
 b=U3F5S/Va3f1ALqM0Yw0wuHj8Pfi44IRX6Y9N8dzxE5CgePHNojUY6Fbpr32BiKu/msAgcu
 mfmTlKQ66JlrMYDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2vCCztfd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="U3F5S/Va"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779722101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg5f+JbijVPe497KgwTntZYtNfzxWpf1hQMZeDUcADA=;
 b=2vCCztfdypi0YkqZtIXao673q1dpZ1iBC1yD3KDj2b77mh4e/Soa5j+ypFOOQdUqlDW9xj
 2Tnm7r/sOQX/jaHdHGwaoHjuRcDovMOg0dyb9+8p7MeyoeBZsMCo25mU6yl+PBTl8ZHgrh
 XItZufpmnyrxuyzb0fFyd+WZ4YXyqpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779722101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg5f+JbijVPe497KgwTntZYtNfzxWpf1hQMZeDUcADA=;
 b=U3F5S/Va3f1ALqM0Yw0wuHj8Pfi44IRX6Y9N8dzxE5CgePHNojUY6Fbpr32BiKu/msAgcu
 mfmTlKQ66JlrMYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7123259CE8
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cpC4GnVnFGpNYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:15:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 17:14:48 +0200
Message-ID: <20260525151449.203586-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525151449.203586-1-chrubis@suse.cz>
References: <20260525151449.203586-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 82E316B0EC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] safe_macros: Add SAFE_READ_ANY_EAGAIN
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

Similarily to the safe_write() this turns the len_strict into three way
switch with the new value SAFE_READ_ANY_EAGAIN=2 that turns EAGAIN into
a read with a zero lenght.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/safe_macros_fn.h | 10 ++++++++++
 lib/safe_macros.c        |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 9a09c4922..031b1ff98 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -36,6 +36,16 @@ enum safe_write_opts {
 	SAFE_WRITE_RETRY = 2,
 };
 
+
+enum safe_read_opts {
+	/* no lenght strictness, short reads are ok */
+	SAFE_READ_ANY = 0,
+	/* strict lenght, short reads trigger TBROK */
+	SAFE_READ_ALL = 1,
+	/* converts EAGAIN to read that returns 0 */
+	SAFE_READ_ANY_EAGAIN = 2,
+};
+
 char* safe_basename(const char *file, const int lineno,
                     void (*cleanup_fn)(void), char *path);
 
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 68b8747b4..f838ede66 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -294,6 +294,9 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 	rval = read(fildes, buf, nbyte);
 
 	if (rval == -1) {
+		if (len_strict == SAFE_READ_ANY_EAGAIN && errno == EAGAIN)
+			return 0;
+
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"read(%d,%p,%zu) failed, returned %zd", fildes, buf,
 			nbyte, rval);
@@ -301,7 +304,7 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid read(%d,%p,%zu) return value %zd", fildes,
 			buf, nbyte, rval);
-	} else if (len_strict && (size_t)rval != nbyte) {
+	} else if (len_strict == SAFE_READ_ALL && (size_t)rval != nbyte) {
 		tst_brkm_(file, lineno, TBROK, cleanup_fn,
 			  "Short read(%d,%p,%zu) returned only %zd",
 			  fildes, buf, nbyte, rval);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
