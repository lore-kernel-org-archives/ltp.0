Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79429C7EE31
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 10:30:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3BE43C7FCC
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 12:29:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CFFC3C7B3E
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:29:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7CE2B6001A7
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:29:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4D41F395;
 Fri, 27 Jun 2025 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751020157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RbLbSzAHVpygOQGd1jyBTx2cTo7vehu0ML1bqVj9keg=;
 b=Prxf1hbTXuL6eMEfYZ/O2CEEw+LA5KQIHdX0nVSUWR83C2cmuePhUuGJB1YgcDCbL6kPGW
 a+HVW60AABvlkX6mV2AUFWGdUSb+z1JaFD5gq/bGoZognOuG6Mo02G8r3NA/wMxJ0B2FXq
 T2WH693D091rB+9hEpHFpTtKcVc4gMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751020157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RbLbSzAHVpygOQGd1jyBTx2cTo7vehu0ML1bqVj9keg=;
 b=GqE/yHtEQ8HPcsqIHjq4/LcfjjCzJDPm6Tvg24mmLiIQ/2qG9JK38ehQwHIXGwkkWfkv83
 ORByoDZlPM6pTIBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751020157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RbLbSzAHVpygOQGd1jyBTx2cTo7vehu0ML1bqVj9keg=;
 b=Prxf1hbTXuL6eMEfYZ/O2CEEw+LA5KQIHdX0nVSUWR83C2cmuePhUuGJB1YgcDCbL6kPGW
 a+HVW60AABvlkX6mV2AUFWGdUSb+z1JaFD5gq/bGoZognOuG6Mo02G8r3NA/wMxJ0B2FXq
 T2WH693D091rB+9hEpHFpTtKcVc4gMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751020157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RbLbSzAHVpygOQGd1jyBTx2cTo7vehu0ML1bqVj9keg=;
 b=GqE/yHtEQ8HPcsqIHjq4/LcfjjCzJDPm6Tvg24mmLiIQ/2qG9JK38ehQwHIXGwkkWfkv83
 ORByoDZlPM6pTIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49B2213AAC;
 Fri, 27 Jun 2025 10:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zHxdEX1yXmgWAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Jun 2025 10:29:17 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Jun 2025 12:29:57 +0200
Message-ID: <20250627102957.4165-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627102957.4165-1-chrubis@suse.cz>
References: <20250627102957.4165-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tst_test.sh:url,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_test.sh: Fix IPC init for checkpoints
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

The introduction of magic at the start of the LTP IPC region did break
the checkpoints for the tst_test.sh shell library. The reason is that
the library creates the IPC backing file with dd and the magic wasn't
present there.

This introduced failures in the pec testcases:

  cn_pec 1 TINFO: Test process events connector
  cn_pec 1 TINFO: Testing fork event (nevents=10)
  tst_test.c:203: TBROK: Invalid shared memory region (bad magic)
  cn_pec 1 TBROK: tst_checkpoint wait 10000 0 failed

This patch fixes the tst_test.sh library so that the IPC region is
created with a correct magic.

Follow-up: bf9589d5bd ("lib: moves test infrastructure states into a shared context structure")
Reported-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c32bd8b19..4be10a4f9 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -627,6 +627,7 @@ _tst_init_checkpoints()
 		tst_brk TBROK "tst_getconf PAGESIZE failed"
 	fi
 	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize" count=1
+	ROD_SILENT "printf LTPM | dd of="$LTP_IPC_PATH" bs=1 seek=0 conv=notrunc"
 	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
 	export LTP_IPC_PATH
 }
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
