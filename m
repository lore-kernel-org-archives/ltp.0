Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646E7D2F027
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 13:15:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01B973CB234
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 14:15:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC4BF3CB23A
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 14:14:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5711C140027B
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 14:14:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EF5A3372E;
 Tue, 27 Jan 2026 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769519677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RUTL0N7s6eAxEt9wyIgTQuWS7PlI8PNNelec0tThRMk=;
 b=YGL09SUC72Xkal9ywt1kdaGAKTZIOLV3iYT9XO+o3Duj1TZFAmy8zvJ/OUobxOGL/yTqXE
 Q5dRxSyms6orMglVC4SxUdJtR9W3GAmiOw4Dp8VCiHCEzqwQTPmU+sg9R53Q3fCMXSqpAi
 LUAzPoK+vr4nSiC5eQt1a0H1b6qCcBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769519677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RUTL0N7s6eAxEt9wyIgTQuWS7PlI8PNNelec0tThRMk=;
 b=ts3pVVvcrQgHYtACs4uI6vpBdmF42tabKrqn4SE+rqRf/BwI/lJrrBJH1dKlxIqwq+cuXC
 30tWb/dGsxL1ytAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769519676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RUTL0N7s6eAxEt9wyIgTQuWS7PlI8PNNelec0tThRMk=;
 b=MB5y6jRPJObDLGp3G2azFA+BnLgLZh8FjxwcTFPFEU+n4ChEfwsBoVegCqubYv4jscbx9f
 hr7eJ9+FC/o1tQEcaFYMS7LMNXHlShIACcvt2eBep0xhvmfSX0UezuDO4YrmPLtFwQeAtO
 36QxfLr7bPJHfl0METrKuLDIOKEWums=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769519676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RUTL0N7s6eAxEt9wyIgTQuWS7PlI8PNNelec0tThRMk=;
 b=UGuC+sb44EL2SS5ATtYupr2qAVUTjNP8LI49ueVLZutEk186iaoNpZe1k8BL2/KzQ67mmH
 V+MRe5wxeN8DuPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7042C3EA61;
 Tue, 27 Jan 2026 13:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Um90Gjy6eGnbewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jan 2026 13:14:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 27 Jan 2026 14:14:25 +0100
Message-ID: <20260127131427.146592-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_net.sh: Print netstress.c logs on unexpected
 error
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

When there is an unexpected error, logs should be printed as well to
know the reason:

    tcp_fastopen_run 1 TINFO: run server 'netstress -t 0 -d ltp_ns_veth1 -R 3 \
	-B /tmp/LTP_tcp_fastopen_run.TpwSlSogBJ'
    tcp_fastopen_run 1 TINFO: run client 'netstress -l -t 0 -H 10.0.0.1 -d ltp_ns_veth2 \
	-a 2 -r 2000 -c /tmp/LTP_tcp_fastopen_run.TpwSlSogBJ/tst_netload.res' 5 times
    tcp_fastopen_run 1 TWARN: netstress failed, ret: 6
    tcp_fastopen_run 1 TPASS: netstress passed, median time 123 ms, data: 118 124 122 125

While at it, factor out logging code into new function
tst_netload_print_log().

Fixes: da16b664e7 ("lib/tst_net: calc mean in tst_netload()")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ec49f5fab9..20f669f56e 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -732,10 +732,15 @@ tst_wait_ipv6_dad()
 	done
 }
 
-tst_netload_brk()
+tst_netload_print_log()
 {
 	tst_rhost_run -c "cat $TST_TMPDIR/netstress.log"
 	cat tst_netload.log
+}
+
+tst_netload_brk()
+{
+	tst_netload_print_log
 	tst_brk_ $1 $2
 }
 
@@ -853,6 +858,7 @@ tst_netload()
 				tst_netload_brk TFAIL "expected '$expect_res' but ret: '$ret'"
 
 			tst_res_ TWARN "netstress failed, ret: $ret"
+			tst_netload_print_log
 			was_failure=1
 			continue
 		fi
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
