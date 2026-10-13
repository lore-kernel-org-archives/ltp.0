Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D83CC6B08
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:03:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 784493EA82B
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:03:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E48CF3EA81B
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5D02F140012D
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D43C1F745;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNnEa5yw4A6Qb82c4Z0DmxlRoyLxui+wnboena6Y37Q=;
 b=QXEN8p2PJOyR0gvsLCPkPF2JrYLZZzqjBAun4jdG1YywD6JJzdxdDQIWVZeF3RpcKYaqul
 xsB6VHtNAwThR3nyBnmhwCYp/DJZRSbLI/7yPG21rrfIWNJqwKVYTVYtWPBmgjiuT72cVq
 wRh5dEVoAffpZySLDdlrqv6MdNdEhK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNnEa5yw4A6Qb82c4Z0DmxlRoyLxui+wnboena6Y37Q=;
 b=XZXZxyO9OPYpuMqqLdufNneQVEmHvKMCpMZCI0idLjs4KXMPhzLd+0p9xuMkv+Re0Px0HS
 qPkbOxDYUKPQR5Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNnEa5yw4A6Qb82c4Z0DmxlRoyLxui+wnboena6Y37Q=;
 b=QXEN8p2PJOyR0gvsLCPkPF2JrYLZZzqjBAun4jdG1YywD6JJzdxdDQIWVZeF3RpcKYaqul
 xsB6VHtNAwThR3nyBnmhwCYp/DJZRSbLI/7yPG21rrfIWNJqwKVYTVYtWPBmgjiuT72cVq
 wRh5dEVoAffpZySLDdlrqv6MdNdEhK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNnEa5yw4A6Qb82c4Z0DmxlRoyLxui+wnboena6Y37Q=;
 b=XZXZxyO9OPYpuMqqLdufNneQVEmHvKMCpMZCI0idLjs4KXMPhzLd+0p9xuMkv+Re0Px0HS
 qPkbOxDYUKPQR5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBC0D1368A;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T11
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:06 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-10-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=2348;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=XJw4uQVE/L4D5czvxRKcb24mU9Kwmsthuhn36VX8EqY=;
 b=0Y5dLQuAE3UaXMMq4AWVG2Q8Gb20yL58a5V0VXom2HcovNYCsR7DsUck7hggEVqDY57ln1a8y
 RKkDP0Ezix2D57mDTtGYdp7WQKIRdJGTBECIAa2Jjxi0X4PfpmkKhcN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 10/15] ujson: reader: Parse escape sequences in
 object IDs
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

copy_id_str() copied characters verbatim without handling escape
sequences, which caused escaped quotes \" to prematurely terminate
the key and left other escape sequences such as \uXXXX unparsed.
Reuse copy_str() to parse object ID strings with full escape support.

As a side effect, too long and unterminated IDs now report the generic
copy_str() errors ("String buffer too short!", "Unterminated string")
instead of the ID-specific ones. Also set res->type to UJSON_VOID on
ID-parsing errors to prevent iterating with stale values on failure.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_reader.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index 890d07b35..21425f848 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -258,32 +258,14 @@ static int copy_str(ujson_reader *buf, char *str, size_t len)
 
 static int copy_id_str(ujson_reader *buf, char *str, size_t len)
 {
-	size_t pos = 0;
-
 	if (eatws(buf))
 		goto err0;
 
-	if (!eatb(buf, '"'))
+	if (peekb(buf) != '"')
 		goto err0;
 
-	for (;;) {
-		if (buf_empty(buf)) {
-			ujson_err(buf, "Unterminated ID string");
-			return 1;
-		}
-
-		if (eatb(buf, '"')) {
-			str[pos] = 0;
-			break;
-		}
-
-		if (pos >= len-1) {
-			ujson_err(buf, "ID string too long");
-			return 1;
-		}
-
-		str[pos++] = getb(buf);
-	}
+	if (copy_str(buf, str, len))
+		return 1;
 
 	if (eatws(buf))
 		goto err1;
@@ -706,8 +688,10 @@ static int skip_obj_val(ujson_reader *buf)
 
 static int obj_next(ujson_reader *buf, struct ujson_val *res)
 {
-	if (copy_id_str(buf, res->id, sizeof(res->id)))
+	if (copy_id_str(buf, res->id, sizeof(res->id))) {
+		res->type = UJSON_VOID;
 		return 0;
+	}
 
 	return get_value(buf, res);
 }
@@ -732,8 +716,10 @@ static int obj_next_filter(ujson_reader *buf, struct ujson_val *res,
 	const struct ujson_obj_attr *attr;
 
 	for (;;) {
-		if (copy_id_str(buf, res->id, sizeof(res->id)))
+		if (copy_id_str(buf, res->id, sizeof(res->id))) {
+			res->type = UJSON_VOID;
 			return 0;
+		}
 
 		res->idx = obj ? ujson_obj_lookup(obj, res->id) : (size_t)-1;
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
