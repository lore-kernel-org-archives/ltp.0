Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18977CA9ED2
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:03:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6BE23EA838
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:03:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E60803EA820
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 784661400972
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3F2821F3F;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfxE1XdCCq5iRdKQ+WYzPb7znCaP4eYo4VJdlAq0b6k=;
 b=yLsahJBof01/09wJeOXig6pJ1J3thv8aSxsLKwDJwBvx6UdFuG9fPxdSnBW7tIxPH2EbvM
 GQmbFv/nrMZoSokbWr7/ddqKZ2w4l/qs0e5JC14bOQmzD1hAY1hXFvM/LUxd+pzdr92SfS
 os/JH3vmmMeSnyS/D3gmnAIaN7n+OyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfxE1XdCCq5iRdKQ+WYzPb7znCaP4eYo4VJdlAq0b6k=;
 b=r2PM/+PbicaFkKPUmd1kt0llA25sP8TW/k7VI6Xd5UBBk+Hy/VFXFhhXoaWzCFjvuaTSJZ
 QiiUSgoYZxF4bCDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yLsahJBo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="r2PM/+Pb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfxE1XdCCq5iRdKQ+WYzPb7znCaP4eYo4VJdlAq0b6k=;
 b=yLsahJBof01/09wJeOXig6pJ1J3thv8aSxsLKwDJwBvx6UdFuG9fPxdSnBW7tIxPH2EbvM
 GQmbFv/nrMZoSokbWr7/ddqKZ2w4l/qs0e5JC14bOQmzD1hAY1hXFvM/LUxd+pzdr92SfS
 os/JH3vmmMeSnyS/D3gmnAIaN7n+OyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfxE1XdCCq5iRdKQ+WYzPb7znCaP4eYo4VJdlAq0b6k=;
 b=r2PM/+PbicaFkKPUmd1kt0llA25sP8TW/k7VI6Xd5UBBk+Hy/VFXFhhXoaWzCFjvuaTSJZ
 QiiUSgoYZxF4bCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9B7513608;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T10
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:05 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-9-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=2318;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=oIuD8JtAS7MA42dxhR8IhSLxdwgpk3dMnshSh2Ee2GY=;
 b=1rGMkfDBqrxvCReKR7MzEuuNJoVfngrIgNEHWqBhtQhP2EBxa4Qd/MHtwkmmcGUSxrOEmin7u
 WF9UNV9LHbMAHj288YrSt0GuHfJRwd5x+QS6Iqaa2iHtFKbccO99GFF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A3F2821F3F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/15] ujson: writer: Check return value in
 esc_flush()
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

ESC_FLUSH ignored the return values of out() and out_str(). If an
output error occurred while flushing escaped characters, the error was
ignored and writing continued. Replace ESC_FLUSH with an esc_flush()
helper function, check its return value, and propagate errors.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_writer.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index c203ee079..7882a5ab5 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -97,12 +97,16 @@ static inline int out_ch(ujson_writer *self, char ch)
 	return out(self, &ch, 1);
 }
 
-#define ESC_FLUSH(esc_char) do {\
-	out(self, val, i); \
-	val += i + 1; \
-	i = 0; \
-	out_str(self, esc_char); \
-} while (0)
+static inline int esc_flush(ujson_writer *self, const char **val, size_t *i, const char *esc_char)
+{
+	if (out(self, *val, *i))
+		return 1;
+
+	*val += *i + 1;
+	*i = 0;
+
+	return out_str(self, esc_char);
+}
 
 static inline int out_esc_str(ujson_writer *self, const char *val)
 {
@@ -120,34 +124,39 @@ static inline int out_esc_str(ujson_writer *self, const char *val)
 		}
 
 		if (next_chsz == 1) {
+			int ret = 0;
+
 			switch (val[i]) {
 			case '\"':
-				ESC_FLUSH("\\\"");
+				ret = esc_flush(self, &val, &i, "\\\"");
 			break;
 			case '\\':
-				ESC_FLUSH("\\\\");
+				ret = esc_flush(self, &val, &i, "\\\\");
 			break;
 			case '/':
-				ESC_FLUSH("\\/");
+				ret = esc_flush(self, &val, &i, "\\/");
 			break;
 			case '\b':
-				ESC_FLUSH("\\b");
+				ret = esc_flush(self, &val, &i, "\\b");
 			break;
 			case '\f':
-				ESC_FLUSH("\\f");
+				ret = esc_flush(self, &val, &i, "\\f");
 			break;
 			case '\n':
-				ESC_FLUSH("\\n");
+				ret = esc_flush(self, &val, &i, "\\n");
 			break;
 			case '\r':
-				ESC_FLUSH("\\r");
+				ret = esc_flush(self, &val, &i, "\\r");
 			break;
 			case '\t':
-				ESC_FLUSH("\\t");
+				ret = esc_flush(self, &val, &i, "\\t");
 			break;
 			default:
 				i += next_chsz;
 			}
+
+			if (ret)
+				return 1;
 		} else {
 			i += next_chsz;
 		}

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
