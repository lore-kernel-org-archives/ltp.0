Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAB2C369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 13:36:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB4533C0229
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 15:35:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFAB63C0229
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:35:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 18F5A600199
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:35:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E49121859;
 Wed, 30 Apr 2025 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746020141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lGnIsrA+3yislY7dMOdo/BX8hLoUb3pPRygH1vP3h9s=;
 b=Wp17+OsJJagZKWvZWnYwhx9s1eQXeriV/G6XaMpMiLHYKEraHJc9bossi5/AXPuFHJJk/a
 lK7sa02BH+0WSoEvq879TJE+TUOBPaUtax3R90G9XZE+ZkMqZUJb/Uj3ZZeR7RcfzLcePv
 wsZM8EY7MMjrv6dwUjTx2EcYbRdCQ7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746020141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lGnIsrA+3yislY7dMOdo/BX8hLoUb3pPRygH1vP3h9s=;
 b=ufmBQFsPkUp3yhZuYMrr2o5RbgDd/5jVbkxOoxMQfj1X168gSf467dRU/DMXHSfuLGvkH0
 8BrWzaOYLYArwTDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Wp17+OsJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ufmBQFsP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746020141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lGnIsrA+3yislY7dMOdo/BX8hLoUb3pPRygH1vP3h9s=;
 b=Wp17+OsJJagZKWvZWnYwhx9s1eQXeriV/G6XaMpMiLHYKEraHJc9bossi5/AXPuFHJJk/a
 lK7sa02BH+0WSoEvq879TJE+TUOBPaUtax3R90G9XZE+ZkMqZUJb/Uj3ZZeR7RcfzLcePv
 wsZM8EY7MMjrv6dwUjTx2EcYbRdCQ7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746020141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lGnIsrA+3yislY7dMOdo/BX8hLoUb3pPRygH1vP3h9s=;
 b=ufmBQFsPkUp3yhZuYMrr2o5RbgDd/5jVbkxOoxMQfj1X168gSf467dRU/DMXHSfuLGvkH0
 8BrWzaOYLYArwTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C6F213A25;
 Wed, 30 Apr 2025 13:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OiwiHS0nEmiPdgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Apr 2025 13:35:41 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 30 Apr 2025 15:36:15 +0200
Message-ID: <20250430133615.15571-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8E49121859
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tlibio.c: Restore LIO_IO_SYNCV
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

There was a single case of "#ifndef CRAY" in all the "#ifdef CRAY"
macros that got removed accidentally. This patch restores that piece.

Fixes: fed3e3ee6399 ('lib/tlibio: Get rid of support for old UNIXes')
Reported-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tlibio.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index 451244525..b3e723aa7 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -767,6 +767,34 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 			return -errno;
 		}
 	}
+	else if (method & LIO_IO_SYNCV) {
+		io_type = "writev(2)";
+
+		sprintf(Lio_SysCall, "writev(%d, &iov, 1) nbyte:%d", fd, size);
+
+		if (Debug_level) {
+			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
+			       Lio_SysCall);
+		}
+		if ((ret = writev(fd, &iov, 1)) == -1) {
+			sprintf(Errormsg,
+				"%s/%d writev(%d, iov, 1) nbyte:%d ret:-1, errno=%d %s",
+				__FILE__, __LINE__, fd, size, errno,
+				strerror(errno));
+			return -errno;
+		}
+
+		if (ret != size) {
+			sprintf(Errormsg,
+				"%s/%d writev(%d, iov, 1) nbyte:%d returned=%d",
+				__FILE__, __LINE__, fd, size, ret);
+		} else if (Debug_level > 1)
+			printf
+			    ("DEBUG %s/%d: writev completed without error (ret %d)\n",
+			     __FILE__, __LINE__, ret);
+
+		return ret;
+	}			/* LIO_IO_SYNCV */
 	/* LIO_IO_ALISTIO */
 	else if (method & LIO_IO_SYNCP) {
 		io_type = "pwrite(2)";
@@ -1150,6 +1178,34 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		}
 	}
 	/* LIO_IO_ALISTIO */
+	else if (method & LIO_IO_SYNCV) {
+		io_type = "readv(2)";
+
+		sprintf(Lio_SysCall, "readv(%d, &iov, 1) nbyte:%d", fd, size);
+
+		if (Debug_level) {
+			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
+			       Lio_SysCall);
+		}
+		if ((ret = readv(fd, &iov, 1)) == -1) {
+			sprintf(Errormsg,
+				"%s/%d readv(%d, iov, 1) nbyte:%d ret:-1, errno=%d %s",
+				__FILE__, __LINE__, fd, size, errno,
+				strerror(errno));
+			return -errno;
+		}
+
+		if (ret != size) {
+			sprintf(Errormsg,
+				"%s/%d readv(%d, iov, 1) nbyte:%d returned=%d",
+				__FILE__, __LINE__, fd, size, ret);
+		} else if (Debug_level > 1)
+			printf
+			    ("DEBUG %s/%d: readv completed without error (ret %d)\n",
+			     __FILE__, __LINE__, ret);
+
+		return ret;
+	}			/* LIO_IO_SYNCV */
 	else if (method & LIO_IO_SYNCP) {
 		io_type = "pread(2)";
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
