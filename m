Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ADD606A31C
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0IyE018G;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=N+JPwHwg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0IyE018G;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=N+JPwHwg
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B9623EB5C1
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 20:34:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1FF63C332C
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 20:33:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3A399200905
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 20:33:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0489F1F460;
 Mon,  9 Nov 2026 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794252827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6NgJ5o+sbEXC+9lR3W4jbo8I9wXFtD/AF3EZIqtmqMQ=;
 b=0IyE018GPEDXVprRYEEgqBbdlnN0c5GVP5Hz4W3w9OuAuuaWV9G1qX/HD6+ZRB3QIZEah8
 ipl1CH+ydFuB6ehwou+TC5MvRaIs1OPGlbVvZ21YV/Inqn+sOPwiPOyqRTxzVmPizlPH2Y
 jTStOAKrYufz8Nep2CnE/pxdVv6o2dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794252827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6NgJ5o+sbEXC+9lR3W4jbo8I9wXFtD/AF3EZIqtmqMQ=;
 b=N+JPwHwgg6iZQboWhGYxEdLfi5rUMbELF75KmQz7z+p77LtxfExKHYyV7YB7USIIRsy9Um
 xIMrdAtKzJAHAqBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794252827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6NgJ5o+sbEXC+9lR3W4jbo8I9wXFtD/AF3EZIqtmqMQ=;
 b=0IyE018GPEDXVprRYEEgqBbdlnN0c5GVP5Hz4W3w9OuAuuaWV9G1qX/HD6+ZRB3QIZEah8
 ipl1CH+ydFuB6ehwou+TC5MvRaIs1OPGlbVvZ21YV/Inqn+sOPwiPOyqRTxzVmPizlPH2Y
 jTStOAKrYufz8Nep2CnE/pxdVv6o2dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794252827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6NgJ5o+sbEXC+9lR3W4jbo8I9wXFtD/AF3EZIqtmqMQ=;
 b=N+JPwHwgg6iZQboWhGYxEdLfi5rUMbELF75KmQz7z+p77LtxfExKHYyV7YB7USIIRsy9Um
 xIMrdAtKzJAHAqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B7D913319;
 Mon,  9 Nov 2026 19:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l68yNxkg8mosJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Nov 2026 19:33:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  9 Nov 2026 20:33:44 +0100
Message-ID: <20261109193344.669217-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] zram01.sh: Fill the filesystem with a single dd
 call
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

zram_fill_fs() spawned a new dd process for every 1 KiB written. Filling
the 384 MiB Btrfs device alone takes up to ~390k process spawns, the four
smaller devices before it already needed 284k-350k. On slow process
creation (e.g. Xen PV dom0) the test then runs for hours: openQA jobs on
SLE12-SP5 and SLE15-SP6 were killed after 2h15m while still filling zram4
(Btrfs), with no kernel errors in the console log.

Write the whole file with a single dd using the same 1 KiB block size
until it fails with ENOSPC and take the written size from the file size.
The device is filled to the same level, the reported size and the
compression ratio calculation are unchanged.

This speedups the 7th test run rapidly, which avoids the timeout on
Btrfs.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hopefully this does not spoil the testcase itself by being too easy.

 testcases/kernel/device-drivers/zram/zram01.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 4b7f2a753f..f6dfb6f8aa 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -135,13 +135,11 @@ zram_fill_fs()
 
 	for i in $(seq $dev_start $dev_end); do
 		tst_res TINFO "filling zram$i (it can take long time)"
+		# dd is expected to fail with ENOSPC once the device is full
+		dd if=/dev/zero of="zram$i/file" bs=1024 status=none \
+			>/dev/null 2>err.txt
 		b=0
-		while true; do
-			dd conv=notrunc if=/dev/zero of=zram${i}/file \
-				oflag=append count=1 bs=1024 status=none \
-				>/dev/null 2>err.txt || break
-			b=$(($b + 1))
-		done
+		[ -f "zram$i/file" ] && b=$(($(wc -c < "zram$i/file") / 1024))
 		if [ $b -eq 0 ]; then
 			[ -s err.txt ] && tst_res TWARN "dd error: $(cat err.txt)"
 			tst_brk TBROK "cannot fill zram $i"
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
