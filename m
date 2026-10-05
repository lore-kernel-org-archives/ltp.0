Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8FBCA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:28:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA4BB3E527B
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:28:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82BB53E4E35
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D10E21000416
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 920FE1F7B8;
 Mon,  5 Oct 2026 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ul0Pl+/Tkjra0Ok4xOHi3+UMc7BwZFhY8ywtzZ0d7fY=;
 b=skr4MdNJe5k7eOmBq+1JmcJWvun+WJItwlvkBdGbJcqIn1Fwzi2BooAWpHIwm9M4SAYp28
 WZekXjDfOtwDbUthUznqMTmA8ceZsdPhmSZE/4rnnOBdfihFOlJhACQBzXW9dXnd2ICkgo
 00kgClAhztSJgPR5TgDdz/69y23JvPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ul0Pl+/Tkjra0Ok4xOHi3+UMc7BwZFhY8ywtzZ0d7fY=;
 b=CBmIN08wk6ysGtGcEFljTvgX/Xqcu9RQTFdi9WR1UjB9lzo7duUOiGbSLBqrCGbm/PrviX
 GjhOOw+IivdxgMAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ul0Pl+/Tkjra0Ok4xOHi3+UMc7BwZFhY8ywtzZ0d7fY=;
 b=lDJ2qg67rDGPPcld5yS39chO/E7q1GzpIDxpVHiUt4Zpd0iWjNAVxwtis+a5g3lot/22gQ
 mxzzmLEfa+1/obQ62RTpMI1IunOxYM3VojWEo6vgWh+1R5QMbEdMUu/BybEeE3WyLf23jM
 NH7GhZ0yAraTiDglWNt6gPXnsllexMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ul0Pl+/Tkjra0Ok4xOHi3+UMc7BwZFhY8ywtzZ0d7fY=;
 b=maW/mDxkZy2Ud4DXmrRA2JNCbxH8y2QsQwbeEe2sr36MfjUUaif5ioVPorgdh4uTJyIR9n
 2sd+H4TkdORSf+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DF3413AEF;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T8
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:35 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-7-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1273;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=WWwaHR+iketUQbfKWlM/Xr2xemM+gwGb1MO6+jtjBkQ=;
 b=qncfwrPsntv2lBHKrDd6O4WBPhJvduhD4FNGld7N0CNb4JotoQ3rJ5fzouREhpasV71UK9fyv
 GI4wgERgpvuBaAjcFkdGudz7W7Sa03SJjjXEEC7fMl5Z718jf9nGTpb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.11)[-0.549]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 07/15] ujson: writer: Return error when newline() fails
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

When out_ch(self, '\n') fails, newline() returns 0 instead of 1,
masking output write errors from the caller. ujson_obj_finish() and
ujson_arr_finish() also ignore the newline() return value. Return 1
on write failure and propagate it to the caller.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_writer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index 040ae680e..c203ee079 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -179,7 +179,7 @@ static int do_padd(ujson_writer *self)
 static int newline(ujson_writer *self)
 {
 	if (out_ch(self, '\n'))
-		return 0;
+		return 1;
 
 	if (do_padd(self))
 		return 1;
@@ -261,8 +261,8 @@ int ujson_obj_finish(ujson_writer *self)
 
 	clear_depth_bit(self);
 
-	if (!first)
-		newline(self);
+	if (!first && newline(self))
+		return 1;
 
 	return out_ch(self, '}');
 }
@@ -304,8 +304,8 @@ int ujson_arr_finish(ujson_writer *self)
 
 	clear_depth_bit(self);
 
-	if (!first)
-		newline(self);
+	if (!first && newline(self))
+		return 1;
 
 	return out_ch(self, ']');
 }

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
