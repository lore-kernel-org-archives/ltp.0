Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8690FCD5BC5
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 13:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 836783C24B5
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 15:45:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DECCA3C23CA
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 15:45:12 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5AD1814010CE
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 15:45:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C902D2126D
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 13:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725543909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSKD2zRCHvG8ghXOD44L3xvZ6lGCnjk/NZP4SJJvalE=;
 b=xzj7Sg2Uv6Ua3bniRG5ehw63ifKk/TQZnfXoMxTkTMD/9QwJaB4+wHBxNVTJkcTjE3s7ax
 6TwnkWlOu0g+yHSGUoxBkQLrWs4+fTEhpWf9FFv9VuaFUG0+Dq5T0HEouX/l+Xo5DPzJNp
 saCaFq/ksXxHpkh6PT+cdMWgS4pKDjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725543909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSKD2zRCHvG8ghXOD44L3xvZ6lGCnjk/NZP4SJJvalE=;
 b=bgF6k4W6tvi9gD6XtX+K51azBdwPORBtItKgzbAeL2SP8DoIrkcbe+F1M7WuRAe4RxQAhY
 brn4+6lZ+STY+lBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xzj7Sg2U;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bgF6k4W6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725543909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSKD2zRCHvG8ghXOD44L3xvZ6lGCnjk/NZP4SJJvalE=;
 b=xzj7Sg2Uv6Ua3bniRG5ehw63ifKk/TQZnfXoMxTkTMD/9QwJaB4+wHBxNVTJkcTjE3s7ax
 6TwnkWlOu0g+yHSGUoxBkQLrWs4+fTEhpWf9FFv9VuaFUG0+Dq5T0HEouX/l+Xo5DPzJNp
 saCaFq/ksXxHpkh6PT+cdMWgS4pKDjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725543909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSKD2zRCHvG8ghXOD44L3xvZ6lGCnjk/NZP4SJJvalE=;
 b=bgF6k4W6tvi9gD6XtX+K51azBdwPORBtItKgzbAeL2SP8DoIrkcbe+F1M7WuRAe4RxQAhY
 brn4+6lZ+STY+lBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2DE8139D2
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 13:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0ElqK+W12Wb2CwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 05 Sep 2024 13:45:09 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  5 Sep 2024 15:45:00 +0200
Message-ID: <20240905134502.33759-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905134502.33759-1-mdoucha@suse.cz>
References: <20240905134502.33759-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C902D2126D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] fallocate05: Deallocate whole file on bcachefs
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

The default deallocation size is likely too small for bcachefs
to actually release the blocks. Since it is also a copy-on-write
filesystem, deallocated the whole file like on Btrfs.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

AFAICT Bcachefs uses 512 byte data blocks by default but 256KB inode
blocks. The whole file will be 128KB and 32KB gets deallocated which may
be too small. However, I'm not entirely sure whether this is the best
solution.

See also https://bugzilla.suse.com/show_bug.cgi?id=1230155

 testcases/kernel/syscalls/fallocate/fallocate05.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 979c70d6e..732a2f15d 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -114,7 +114,8 @@ static void run(void)
 	tst_res(TPASS, "fallocate() on full FS");
 
 	/* Btrfs deallocates only complete extents, not individual blocks */
-	if (!strcmp(tst_device->fs_type, "btrfs"))
+	if (!strcmp(tst_device->fs_type, "btrfs") ||
+		!strcmp(tst_device->fs_type, "bcachefs"))
 		holesize = bufsize + extsize;
 	else
 		holesize = DEALLOCATE_BLOCKS * blocksize;
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
