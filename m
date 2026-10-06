Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55437CA5FED
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 13:03:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E284D3E4E58
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 15:03:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E78903E4B17
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 15:02:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 60F33600845
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 15:02:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0911B22005;
 Tue,  6 Oct 2026 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791291764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAyN8J5vJbb5JLIYoT9d3ZswhNjUwz+V+z7AnKre31A=;
 b=zdV+bmNNw/04xxl1cqJTdHVbWlfL/+p3+Vagpb2y+m9r9cX0FHnR3g5RP2PbbojIGU6nb2
 fwN6kt1Cv1L+oHTNTP/w9H/iO1EgtxDj2WcUSBugH4Y+E467Jk76xpu2e7VX0vTzUVNfX7
 k1fBTOEBBVn1p7Isd9j/RcOP8tS4+TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791291764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAyN8J5vJbb5JLIYoT9d3ZswhNjUwz+V+z7AnKre31A=;
 b=WC1kowwBzEtUyE4p7GxKmFT9CqAidYMRv1Y/yaqxGul31nkoTPNzhHI1JB/HbAsJv4uWjT
 dF6sb49CZlJinjDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791291760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAyN8J5vJbb5JLIYoT9d3ZswhNjUwz+V+z7AnKre31A=;
 b=GuUAYVc3ghBs+Ffcm6cx4o2uDdu6MFS62RLLFjqZ75gbAqTUDYsN6E9eaVrT+FQjTm7Oqv
 ybD2E+hyVQ3Tj2IFjqJOefB75UPU62bFAbRv/JqTFD18rSU2ejxxcPZNwlCa/A3q5OY13R
 bKjF4eve03HYTUbTAsljXMiTkXAzKv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791291760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAyN8J5vJbb5JLIYoT9d3ZswhNjUwz+V+z7AnKre31A=;
 b=Iwz5NZre6WtMLBTvMYK+3trR3M4P3YQq2GcF4dMIyxFsxYv+vWwuu0mk24zNAgHNvpSwvt
 xMAUv9rcXbhHZuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9108B13C7D;
 Tue,  6 Oct 2026 13:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGTTAG/xxGqLRQAAD6G6ig:T4
 (envelope-from <andrea.cervesato@suse.de>); Tue, 06 Oct 2026 13:02:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 06 Oct 2026 15:02:39 +0200
MIME-Version: 1.0
Message-Id: <20261006-fix_simple_bugs_core_lib-v1-3-c94199a46ec5@suse.com>
References: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
In-Reply-To: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791291759; l=751;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=HvA/oPFsXubRP4Bu6G42loNABsY22gcpXMqn3R/gHLQ=;
 b=4w+OzrjYbeBzz39Zc0wC/lQr57ALOkes8qgelHyyrL93EXe13nuwpM+B2BpY/vyisk+29bUkV
 pBsXmkTLSZYDjAZY8klb8z60ThGb8SZS6DXZgOnbzL05GGBhQ/cJczy
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] tst_kconfig: Prevent stack buffer overread
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

kconfig_parse_line() stops scanning value characters only at
whitespace. Because isspace('\0') is false, lines without trailing
whitespace cause an out-of-bounds stack read past the terminating
NUL byte.

Stop scanning when reaching NUL or whitespace.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_kconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 49957e28d..f055c2e5f 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -255,7 +255,7 @@ out:
 		while (isspace(*val))
 			val++;
 
-		while (!isspace(val[val_len]))
+		while (val[val_len] && !isspace(val[val_len]))
 			val_len++;
 
 		if (val_len == 1) {

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
