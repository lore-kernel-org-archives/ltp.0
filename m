Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C633AD2F024
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 13:14:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B4363CACA8
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 14:14:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 045153CAC2E
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 14:14:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 696E610009B6
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 14:14:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8BC25BCC2;
 Tue, 27 Jan 2026 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769519677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGUa67E37/IbP/DdZGCmNducjr5ArOxWMrq5MAclV/o=;
 b=m1BhqRtx28gc0ys0hJcIN9aKYOVA7UxbPLrR8aQ4C5++znGZhmoDPByZo58q2nXeaAcwUt
 jvJKjQdCotU+l4ObfcpMUaAD5PHBxk4hmShW/LQMlwxgHKhIyyOt/DGzqjL+zKQ9efxfIh
 crRL7Ijr6/PP6gUC9dvfWb31VHljpZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769519677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGUa67E37/IbP/DdZGCmNducjr5ArOxWMrq5MAclV/o=;
 b=Ps63FXTlafAtVRVnQT8Ye6nufJxK6g1+PayWFxTJhP4qjq17/qhZbfBWF4V5d3KN49RgTp
 ySLmAO6nQcdmY/Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769519676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGUa67E37/IbP/DdZGCmNducjr5ArOxWMrq5MAclV/o=;
 b=TlJZveBpncLV85b2m76+HRWsT7wBXXiWrtA/5x8d7y9mFfpktshM2DDY3p76mzG2VIiqJ1
 /SyMRy5JN0YgibRcX+tQ7WyBlzyIhmmYuyJZg/i+QjbanabOyF3klmWs7fLFH9d2Q028Ag
 zlkPdwA+P/hTj544I9jQ3b9Ulu9ylqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769519676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGUa67E37/IbP/DdZGCmNducjr5ArOxWMrq5MAclV/o=;
 b=haquyeXaL/vGJ4cppD+pxsmVufUX2UVP3Z4KmMEvvMbDlShsgXLXjpE2jxlEcLeL6pMmvq
 sp/RWKLpOVz0caBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B3273EA62;
 Tue, 27 Jan 2026 13:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0Dj/JDy6eGnbewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jan 2026 13:14:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 27 Jan 2026 14:14:26 +0100
Message-ID: <20260127131427.146592-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127131427.146592-1-pvorel@suse.cz>
References: <20260127131427.146592-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_net.sh: Fix tst_brk() use in tst_netload_brk()
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

Since 1878502f63 ("tst_test.sh/tst_brk(): Allow only TBROK and TCONF")
it's not possible to use tst_brk() with TFAIL. Call tst_res() followed
by tst_brk() for TFAIL/TWARN.

Also convert failure on missing file to TBROK.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Alternative would be to revert 1878502f63.

 testcases/lib/tst_net.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 20f669f56e..76f6b20e31 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -741,7 +741,12 @@ tst_netload_print_log()
 tst_netload_brk()
 {
 	tst_netload_print_log
-	tst_brk_ $1 $2
+	if [ "$1" != TBROK -a "$1" != TCONF ]; then
+		tst_res_ $1 $2
+		tst_brk_ TBROK "quit due previous failures"
+	else
+		tst_brk_ $1 $2
+	fi
 }
 
 # Run network load test, see 'netstress -h' for option description
@@ -863,8 +868,7 @@ tst_netload()
 			continue
 		fi
 
-		[ ! -f $rfile ] && \
-			tst_netload_brk TFAIL "can't read $rfile"
+		[ ! -f $rfile ] && tst_netload_brk TBROK "can't read $rfile"
 
 		results="$results $(cat $rfile)"
 		passed=$((passed + 1))
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
