Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C186C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:47:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94163C2AAE
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:47:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C9C23C296A
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:31 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2FA96230EEE
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 320FC21101
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w67/O2etXk0mox9/81VxlFRsDUdZiV5VhQPKru2SdX4=;
 b=DEjytwaNNln8hMogYlgMeFl0hFBCVcXQM4UJSNtTrnfxs1Yk5DVGinIHW3Ep9c5y2CoPok
 aEO17km+4QnW8E+EC9lUq9EjIlznKnUfX6c79Z3ZDfFP0ZvTuxHo15ef248I+RYgmp1ZGX
 KrQ3sza7qerRspz/HAgB/3uUj1nxsx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w67/O2etXk0mox9/81VxlFRsDUdZiV5VhQPKru2SdX4=;
 b=qNBpaighbP6sJLmkzQm2K8gUXhVoN6LuPm18Is3dIPbEq5T4CeN25BFZockQ5UcXc7+Ue5
 9STRUieJ0kKbfACQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DEjytwaN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qNBpaigh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w67/O2etXk0mox9/81VxlFRsDUdZiV5VhQPKru2SdX4=;
 b=DEjytwaNNln8hMogYlgMeFl0hFBCVcXQM4UJSNtTrnfxs1Yk5DVGinIHW3Ep9c5y2CoPok
 aEO17km+4QnW8E+EC9lUq9EjIlznKnUfX6c79Z3ZDfFP0ZvTuxHo15ef248I+RYgmp1ZGX
 KrQ3sza7qerRspz/HAgB/3uUj1nxsx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w67/O2etXk0mox9/81VxlFRsDUdZiV5VhQPKru2SdX4=;
 b=qNBpaighbP6sJLmkzQm2K8gUXhVoN6LuPm18Is3dIPbEq5T4CeN25BFZockQ5UcXc7+Ue5
 9STRUieJ0kKbfACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 278C413991
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6HJzCe3Oj2erPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 17:44:15 +0100
Message-ID: <20250121164426.27977-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121164426.27977-1-mdoucha@suse.cz>
References: <20250121164426.27977-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 320FC21101
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/10] kvm_read_sregs(): Read the TR segment register
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/bootstrap_x86.S    | 2 ++
 testcases/kernel/kvm/bootstrap_x86_64.S | 2 ++
 testcases/kernel/kvm/include/kvm_x86.h  | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/kvm/bootstrap_x86.S b/testcases/kernel/kvm/bootstrap_x86.S
index a39c6bea7..79d2218d3 100644
--- a/testcases/kernel/kvm/bootstrap_x86.S
+++ b/testcases/kernel/kvm/bootstrap_x86.S
@@ -215,6 +215,8 @@ kvm_read_sregs:
 	movw %ax, 8(%edi)
 	mov %ss, %ax
 	movw %ax, 10(%edi)
+	str %ax
+	movw %ax, 12(%edi)
 	pop %edi
 	ret
 
diff --git a/testcases/kernel/kvm/bootstrap_x86_64.S b/testcases/kernel/kvm/bootstrap_x86_64.S
index b02dd4d92..32170f7c9 100644
--- a/testcases/kernel/kvm/bootstrap_x86_64.S
+++ b/testcases/kernel/kvm/bootstrap_x86_64.S
@@ -319,6 +319,8 @@ kvm_read_sregs:
 	movw %ax, 8(%rdi)
 	mov %ss, %ax
 	movw %ax, 10(%rdi)
+	str %ax
+	movw %ax, 12(%rdi)
 	retq
 
 handle_interrupt:
diff --git a/testcases/kernel/kvm/include/kvm_x86.h b/testcases/kernel/kvm/include/kvm_x86.h
index 08d3f6759..f99fedbca 100644
--- a/testcases/kernel/kvm/include/kvm_x86.h
+++ b/testcases/kernel/kvm/include/kvm_x86.h
@@ -178,7 +178,7 @@ struct kvm_cregs {
 };
 
 struct kvm_sregs {
-	uint16_t cs, ds, es, fs, gs, ss;
+	uint16_t cs, ds, es, fs, gs, ss, tr;
 };
 
 struct kvm_regs64 {
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
