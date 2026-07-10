Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A81C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 06:29:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFE313E27A5
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:29:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D89D3E26AE
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 08:29:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D43B0600294
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 08:29:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 90CFA7661F;
 Fri, 10 Jul 2026 06:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783664963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8CG1kOe8vNDaW9Udqu5uyt/8xszsfNM02JA/zkJhN6g=;
 b=WydNen7J8QZ1nE5FMlAzXcNwbDOssbW9DOc0+CpjMFiNsATQgTRWUfMG9/hXBUy4mjfkin
 VYUjHJBCRUBnBYaz39TNBjl6fT9fjPuSjSxMSWxYPbSactBZdQZynhQfqg/1NKDvCIBYdi
 FshoaYTVNrmaU4nHBKOcyTXqpDulsyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783664963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8CG1kOe8vNDaW9Udqu5uyt/8xszsfNM02JA/zkJhN6g=;
 b=Zb7Gm0KeD/PpECY9O5APdZjuncZ7KpxjOC5KZQdMlGsIKf8UTyOGFDCGwW2UwdzPySbHvQ
 fSHqKjzUQR4UMFCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WydNen7J;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Zb7Gm0Ke
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783664963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8CG1kOe8vNDaW9Udqu5uyt/8xszsfNM02JA/zkJhN6g=;
 b=WydNen7J8QZ1nE5FMlAzXcNwbDOssbW9DOc0+CpjMFiNsATQgTRWUfMG9/hXBUy4mjfkin
 VYUjHJBCRUBnBYaz39TNBjl6fT9fjPuSjSxMSWxYPbSactBZdQZynhQfqg/1NKDvCIBYdi
 FshoaYTVNrmaU4nHBKOcyTXqpDulsyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783664963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8CG1kOe8vNDaW9Udqu5uyt/8xszsfNM02JA/zkJhN6g=;
 b=Zb7Gm0KeD/PpECY9O5APdZjuncZ7KpxjOC5KZQdMlGsIKf8UTyOGFDCGwW2UwdzPySbHvQ
 fSHqKjzUQR4UMFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 700F7779BD;
 Fri, 10 Jul 2026 06:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LWOJGkORUGpibgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 06:29:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 08:29:21 +0200
Message-ID: <20260710062921.1145948-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 90CFA7661F
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] checkpatch: Ignore USE_NEGATIVE_ERRNO
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

return of an errno should typically be negative is purely kernel
specific, avoid warning like:

epoll_ctl06.c:36: WARNING: return of an errno should typically be negative (ie: return -EPERM)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .checkpatch.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.checkpatch.conf b/.checkpatch.conf
index a7b6219ada..2ede8d54c5 100644
--- a/.checkpatch.conf
+++ b/.checkpatch.conf
@@ -12,6 +12,9 @@
 # kernel specific
 --ignore BIT_MACRO,PREFER_DEFINED_ATTRIBUTE_MACRO,PREFER_KERNEL_TYPES,STRCPY,STRLCPY,STRNCPY
 
+# kernel specific (cont)
+--ignore USE_NEGATIVE_ERRNO
+
 # TODO: document reason
 --ignore CONST_STRUCT,VOLATILE,FILE_PATH_CHANGES,LONG_LINE,MACRO_ARG_REUSE,MULTIPLE_ASSIGNMENTS
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
